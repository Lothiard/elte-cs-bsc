// print out the owner of a file

#include <errno.h>
#include <pwd.h> //password
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h> //stat
#include <unistd.h>   //stat
/*
struct passwd{
  char    *pw_name   User's login name.
  uid_t    pw_uid    Numerical user ID.
  gid_t    pw_gid    Numerical group ID.
  char    *pw_dir    Initial working directory.
  char    *pw_shell  Program to use as shell.
}
*/
int main(int argc, char** argv) {
    struct stat st;
    stat(argv[0], &st); // fstat(file descriptor, stat structure)
    printf("The user id: %i\n", st.st_uid);
    struct passwd* pwd;
    pwd = getpwuid(st.st_uid);
    printf("The user name: %s\n", pwd->pw_name);
    return 0;
}
