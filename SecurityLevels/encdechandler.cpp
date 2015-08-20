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
    QString encryptScript = "openssl enc -aes-128-cbc -nosalt -pass pass:" + password + " -in \"" + filepath + "\" -out \"" + filepath + ".enc\"";
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

        QString decryptScript = "openssl enc -d -aes-128-cbc -nosalt -pass pass:" + password + " -in \"" + filepath + "\" -out \"" + filepathWithoutEncAtTheEnd + "\"";
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

bool EncDecHandler::initiateFilesystemEncryption(QString filesystempath, QString password, bool encryptFileNamesToo, bool recognizeMe){

    qDebug() << "Filesystem path: " << filesystempath;
    qDebug() << "Password: " << password;
    qDebug() << "Encrypt file names too? :" << encryptFileNamesToo;
    qDebug() << "ENcryption begins..";

    QDir dir(filesystempath);
    //QString dirName = dir.dirName();

    QString dn = dir.dirName();
    QString tempDir = filesystempath + ".old";
    dir.cd("..");

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


    if(!mountFS(filesystempath, password, sig)){
        qDebug() << "error when mounting " + filesystempath;
        return false;
    }

    QProcess process;
    //********************************************************************
    //to work on my computer
    process.start("chown arcelik:arcelik " + filesystempath);
    process.waitForFinished();
    //to work on my computer
    //********************************************************************

    saveFilesystemPathPasswordEtc(filesystempath, password, sig, recognizeMe);

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

    if(!recognizeMe){
        if(!unmountFS(filesystempath)){
            qDebug() << "error when unmounting " + filesystempath;
            return false;
        }
        qDebug() << "unmount of " + filesystempath + " completed";
        return true;
    }
}

bool EncDecHandler::initiateFilesystemDecryption(QString filesystempath, QString password){
    qDebug() << "Filesystem path: " << filesystempath;
    qDebug() << "Password: " << password;
    qDebug() << "DEcryption begins..";
    QString sig;
    bool recognizeMe;
    QProcess process;

    if(checkFilesystemPathPasswordPair(filesystempath, password, sig, recognizeMe) == false)
    {
        qDebug() << "decryption failed. wrong password.";
        return false;
    }
    else{

        if(!recognizeMe){
            mountFS(filesystempath, password, sig);
        }


        //Now, carry all the files in the 'filesystempath' into filesystempath.temp
        //Then unmount empty filesystempath.
        //Then rename filesystempath.temp ---> filesystempath

        //create .temp directory
        QDir d(filesystempath);
        d.cdUp();
        d.mkdir(filesystempath + ".temp");


        //move the files into the .temp folder
        QString moveCommand = "mv " + filesystempath + "/* " + filesystempath + ".temp/";
        qDebug() << moveCommand;
        process.start("bash", QStringList() << "-c" << moveCommand);
        process.waitForFinished();
        if(process.exitStatus() == QProcess::NormalExit){
            qDebug() << "everything is moved into the .temp file";
            qDebug() << "now syncing dirs....";
            process.start("sync");
            process.waitForFinished();
        }
        else{
            qDebug() << "error when moving";
        }


        //Unmount the previous folder (at filesystempath)
        if(!unmountFS(filesystempath)){
            qDebug() << "could not unmount " + filesystempath;
            return false;
        }else{
            //unmounted successfully. now delete that folder and rename filename.temp ----> filename back.
            qDebug() << "now deleting " + filesystempath + " and replacing " + filesystempath + ".temp with that.";
            QDir dir(filesystempath);
            dir.rmdir(filesystempath);
            dir.rename(filesystempath + ".temp", filesystempath);

            return true;
        }
    }
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
}

bool EncDecHandler::mountFS(QString filesystempath, QString password, QString sig){
    QProcess process;

    //Remount it back.
    QString mountScript = "mount.ecryptfs " + filesystempath + " " +  filesystempath + " -o key=passphrase:passphrase_passwd=" + password
            + ",no_sig_cache=yes,verbose=no,ecryptfs_sig=" + sig + ",ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=no";
    process.start(mountScript);
    process.waitForFinished();
    if(process.exitStatus() == QProcess::NormalExit){
        qDebug() << "remounting done.";
        //***********************************************************************************************

    }
    else{
        return false;
    }
}

bool EncDecHandler::saveFilesystemPathPasswordEtc(QString filesystempath, QString password, QString sig, bool recognizeMe){
    QFile fspp("filesystempath_password_pairs");

    if(!fspp.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)){
        qDebug() << fspp.errorString();
        return false;
    }
    else{
        QTextStream out(&fspp);
        QString lineToWrite = filesystempath + "\t" + password + "\t" + sig + "\t" + (recognizeMe ? "true" : "false");
        out << lineToWrite << endl;

        fspp.close();
        return true;
    }
}

bool EncDecHandler::checkFilesystemPathPasswordPair(QString filesystempath, QString password, QString& sig, bool& recognizeMe){
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
                recognizeMe = (line.split("\t")[3] == "true" ? true : false);
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

QStringList EncDecHandler::getListOfEncryptedFilesystemNames(){
    QStringList resultList;
    QFile f("filesystempath_password_pairs");
    if(!f.open(QIODevice::ReadWrite | QIODevice::Text)){
        qDebug() << f.errorString();
    }
    else{
        QTextStream in(&f);
        while(!in.atEnd()){
            QString line = in.readLine();
            resultList << line.split("\t")[0];
        }
    }
    return resultList;
}
