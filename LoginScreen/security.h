#ifndef SECURITY_H
#define SECURITY_H

#include "argon2.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum{
    WITHOUT_SHAMIR,
    WITH_SHAMIR
}SHAMIR_TYPE;

#define HASHLEN 32
#define SALTLEN 32
#define SHAMIR_NUMB_OF_SHARE 3
#define SHAMIR_NUMB_OF_THRESHOLD 2

#define DISC_ENC_ECHO_STR "echo "
#define DISC_ENC_PIPE_STR " | "
#define DISC_ENC_ROOT_STR " " // " sudo "
#define DISC_ENC_ADDCRYPT_PATH " /usr/bin/addCrypt.sh "
#define DISC_ENC_INITCRYPT_PATH " /usr/bin/initDiskEnc.sh "
#define DISC_ENC_RESETCRYPT_PATH " /usr/bin/removeCrypt.sh "
#define DISC_ENC_DEV_PATH " /dev/mmcblk0p3 "
#define DISC_ENC_SALT_FILE_PATH "/usr/bin/salt.txt"

int securityGetHashValue(const char *pwd, const unsigned char pwdlen, const void *salt, const unsigned char saltlen, void *hash, const unsigned char hashlen);

int securityCheckPassword(const char *pwd, SHAMIR_TYPE shamirOption);

int securityInitDiscEncryption(const char *pwd, SHAMIR_TYPE shamirOption);

int securityResetDiscEncryption();


#if defined(__cplusplus)
}
#endif

#endif
