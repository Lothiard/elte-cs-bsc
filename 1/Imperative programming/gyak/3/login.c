#include <stdio.h>

struct login_info {
    char name[10];
    int is_admin;
};

int main() {
    struct login_info info;
    info.is_admin = 0;

    printf("A neved: ");
    scanf("%s", info.name);

    if (info.is_admin) {
        printf("Adminisztratorkent bejelentkezve\n");
    } else {
        printf("Hozzaferes megtagadva\n");
    }

    return 0;
}
