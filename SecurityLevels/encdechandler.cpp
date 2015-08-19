#include "encdechandler.h"
#include <QFile>

EncDecHandler::EncDecHandler(QObject *parent) : QObject(parent)
{

}

bool EncDecHandler::initiateFileEncryption(QString filepath, QString password){
    qDebug() << "Filepath: " << filepath;
    qDebug() << "Password: " << password;
    qDebug() << "ENcryption begins..";


    QFile file(filepath);

    qDebug() << file.fileName();

    QProcess process;
    saveFilePathPasswordPair(filepath, password);
    QString encryptScript = "openssl enc -aes-128-cbc -nosalt -pass pass:" + password + " -in " + filepath + " -out " + filepath + ".enc";
    qDebug() << encryptScript;
    process.execute(encryptScript);



    if(process.exitStatus() == QProcess::NormalExit){
        //now remove the original file since we have the encrypted version
        file.remove();
        return true;
    }
    else{
        return false;
    }

}

bool EncDecHandler::initiateFileDecryption(QString filepath, QString password){
    qDebug() << "Filepath: " << filepath;
    qDebug() << "Password: " << password;
    qDebug() << "DEcryption begins..";
    QString filepathWithoutEncAtTheEnd = filepath.mid(0, filepath.length() - 4 );

    if(checkFilePathPasswordPair(filepathWithoutEncAtTheEnd, password) == false)
    {
        qDebug() << "decryption failed. wrong password.";
        return false;
    }
    else{
        QProcess process;

        QString decryptScript = "openssl enc -d -aes-128-cbc -nosalt -pass pass:" + password + " -in " + filepath + " -out " + filepathWithoutEncAtTheEnd;
        qDebug() << "decrypt script workin: " +decryptScript;
        process.execute(decryptScript);



        if(process.exitStatus() == QProcess::NormalExit){
            //now remove the .enc file since it is decrypted.
            QFile file(filepath);
            file.remove();
            return true;
        }
        else{
            return false;
        }
    }
}

QString EncDecHandler::getLocalFilePath(QString fileurl){
    QUrl file(fileurl);
    QString localfilepath(file.toLocalFile());
    return localfilepath;
}

bool EncDecHandler::saveFilePathPasswordPair(QString filepath, QString password){
    QFile ppp("filepath_password_pairs");

    if(!ppp.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)){
        qDebug() << ppp.errorString();
        return false;
    }
    else{
        QTextStream out(&ppp);
        QString lineToWrite = filepath + "\t" + password;
        out << lineToWrite << endl;

        ppp.close();
        return true;
    }
}

bool EncDecHandler::checkFilePathPasswordPair(QString filepath, QString password){
    qDebug() << "checking filepath - password pair for : " + filepath + "\t" + password;
    QFile ppp("filepath_password_pairs");
    QString contentOfPpp;
    QString searchedLine = filepath + "\t" + password;
    if(!ppp.open(QIODevice::ReadWrite | QIODevice::Text)){
        qDebug() << ppp.errorString();
        return false;
    }
    else{
        bool foundYet = false;
        QTextStream in(&ppp);
        contentOfPpp = "";
        while(!in.atEnd()){
            QString line = in.readLine();
            qDebug() << "now line: " + line;
            if(!line.contains(searchedLine)){
                contentOfPpp.append(line + "\n");

            }
            else{
                //We found the line we are searching for.
                //Don't add it to the new content file.
                qDebug() << "filepath password pair found!";
                foundYet = true;
            }
        }
        //Update the file
        ppp.resize(0);
        //contentOfPpp = contentOfPpp.trimmed();
        if(ppp.write(contentOfPpp.toUtf8()) == -1)
            qDebug() << "error when writing into path password pair file";

        return foundYet;
    }
}

bool EncDecHandler::initiateFilesystemEncryption(QString filesystempath, QString password, bool encryptFileNamesToo){
    bool success;

    qDebug() << "Filesystem path: " << filesystempath;
    qDebug() << "Password: " << password;
    qDebug() << "Encrypt file names too? :" << encryptFileNamesToo;
    qDebug() << "ENcryption begins..";

    QDir dir(filesystempath);
    //QString dirName = dir.dirName();

    QString dn = dir.dirName();
    QString tempDir = filesystempath + ".old";
    dir.cd("..");
    //dir.mkdir(dn + ".old");
    // filename ----> filename.old
    if(!dir.rename(dn,dn + ".old")){
        qDebug() << "couldnt change name from: " + dn + " to: " + dn + ".old";
    }

    // mkdir filename
    dir.mkdir(dn);

    QString sig = getSignatureFromPassword(password);
    if(sig.length() == 0){
        qDebug() << "couldnt get a signature.";
        return false;
    }



    QString encfsScript = "mount.ecryptfs " + filesystempath + " " +  filesystempath + " -o key=passphrase:passphrase_passwd=" + password
            + ",no_sig_cache=yes,verbose=no,ecryptfs_sig=" + sig + ",ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto="
            + (encryptFileNamesToo ? "yes" : "no");

    qDebug() << encfsScript;

    QProcess process;
    process.start(encfsScript);
    process.waitForFinished();
    if(process.exitStatus() == QProcess::NormalExit){
        qDebug() << process.readAll();
        success = true;
    }
    else{
        qDebug() << process.errorString();
        return false;
    }

    //********************************************************************
    //to work on my computer
    process.start("chown arcelik:arcelik " + filesystempath);
    process.waitForFinished();
    //to work on my computer
    //********************************************************************




    saveFilesystemPathPasswordSig(filesystempath, password, sig);

    //move everything in .old folder to original named folder
    QString moveCommand = "mv " + filesystempath + ".old/* " + filesystempath;
    qDebug() << moveCommand;

    process.start("bash", QStringList() << "-c" << moveCommand);
    process.waitForFinished();
    if(process.exitStatus() == QProcess::NormalExit){
        qDebug() << "everything is moved into the original file";
    }
    else{
        qDebug() << "error when moving";
    }
    qDebug() << "now syncing dirs....";

    process.start("sync");
    process.waitForFinished();
    //delete the .old folder
    dir.rmdir(tempDir);

    return success;
}

bool EncDecHandler::initiateFilesystemDecryption(QString filesystempath, QString password){
    qDebug() << "Filesystem path: " << filesystempath;
    qDebug() << "Password: " << password;
    qDebug() << "DEcryption begins..";
    QString sig;

    if(checkFilesystemPathPasswordPair(filesystempath, password, sig) == false)
    {
        qDebug() << "decryption failed. wrong password.";
        return false;
    }
    else{
        QProcess process;

        //Remount it back.
        QString decryptFSScript = "mount.ecryptfs " + filesystempath + " " +  filesystempath + " -o key=passphrase:passphrase_passwd=" + password
                + ",no_sig_cache=yes,verbose=no,ecryptfs_sig=" + sig + ",ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=no";
        process.execute(decryptFSScript);



        if(process.exitStatus() == QProcess::NormalExit){
//            //now remove the .enc file since it is decrypted.
//            //QFile file(filepath);
//            file.remove();
            return true;
        }
        else{
            return false;
        }
    }


    return false;
}

bool EncDecHandler::unmountFS(QString filesystemPath){

    //Now unmount the filesystem.
    QProcess process;
    QString umountScript = "umount.ecryptfs " + filesystemPath;
    process.start(umountScript);
    process.waitForFinished();

    if(process.exitStatus() == QProcess::NormalExit)
        return true;
    else{
        return false;
    }

    return false;
}

bool EncDecHandler::saveFilesystemPathPasswordSig(QString filesystempath, QString password, QString sig){
    QFile fspp("filesystempath_password_pairs");

    if(!fspp.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)){
        qDebug() << fspp.errorString();
        return false;
    }
    else{
        QTextStream out(&fspp);
        QString lineToWrite = filesystempath + "\t" + password + "\t" + sig;
        out << lineToWrite << endl;

        fspp.close();
        return true;
    }
}

bool EncDecHandler::checkFilesystemPathPasswordPair(QString filesystempath, QString password, QString& sig){
    qDebug() << "checking filesystempath - password pair for : " + filesystempath + "\t" + password;
    QFile fspp("filesystempath_password_pairs");

    QString contentOfFspp;
    QString searchedLine = filesystempath + "\t" + password;
    if(!fspp.open(QIODevice::ReadWrite | QIODevice::Text)){
        qDebug() << fspp.errorString();
        return false;
    }
    else{
        bool foundYet = false;
        QTextStream in(&fspp);
        contentOfFspp = "";
        while(!in.atEnd()){
            QString line = in.readLine();
            qDebug() << "now line: " + line;
            if(!line.contains(searchedLine)){
                contentOfFspp.append(line + "\n");

            }
            else{
                //We found the line we are searching for.
                //Don't add it to the new content file.
                qDebug() << "filesystempath password pair found! getting sig.";
                sig = line.split("\t")[2];
                foundYet = true;
            }
        }
        //Update the file
        fspp.resize(0);
        //contentOfPpp = contentOfPpp.trimmed();
        if(fspp.write(contentOfFspp.toUtf8()) == -1)
            qDebug() << "error when writing into path password pair file";

        return foundYet;
    }
}




QString EncDecHandler::getSignatureFromPassword(QString password){
    QProcess process;
    process.start("bash", QStringList() << "-c" << "echo " + password + " | ecryptfs-add-passphrase");
    process.waitForFinished();

    if(process.exitStatus() == QProcess::NormalExit){
        QString output(process.readAllStandardOutput());

        qDebug() << "output from ecryptfs-add-passphrase: ";
        qDebug() << output;

        QString signature = output.split("[")[1].split("]")[0];
        return signature;
    }

    else{
        return "";
    }

}

//bool EncDecHandler::copyRecursively(const QString &srcFilePath,
//                                    const QString &tgtFilePath){

//    qDebug() << "src file path: " + srcFilePath;
//    qDebug() << "tgt file path: " + tgtFilePath;
//    QFileInfo srcFileInfo(srcFilePath);
//    if (srcFileInfo.isDir()) {
//        QDir targetDir(tgtFilePath);
//        targetDir.cdUp();
//        QDir sourceDir(srcFilePath);
//        QStringList fileNames = sourceDir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
//        foreach (const QString &fileName, fileNames) {
//            const QString newSrcFilePath
//                    = srcFilePath + QLatin1Char('/') + fileName;
//            const QString newTgtFilePath
//                    = tgtFilePath + QLatin1Char('/') + fileName;
//            if (!copyRecursively(newSrcFilePath, newTgtFilePath)){
//                qDebug() << "checkpoint 1 failed.";
//                return false;
//            }
//        }
//    } else {
//        if (!QFile::copy(srcFilePath, tgtFilePath)){
//            qDebug() << "checkpoint 2 failed.";
//            return false;
//        }
//    }
//    return true;
//}

void EncDecHandler::clearDir( const QString path )
{
    QDir dir( path );

    dir.setFilter( QDir::NoDotAndDotDot | QDir::Files );
    foreach( QString dirItem, dir.entryList() )
        dir.remove( dirItem );

    dir.setFilter( QDir::NoDotAndDotDot | QDir::Dirs );
    foreach( QString dirItem, dir.entryList() )
    {
        QDir subDir( dir.absoluteFilePath( dirItem ) );
        subDir.removeRecursively();
    }
}
