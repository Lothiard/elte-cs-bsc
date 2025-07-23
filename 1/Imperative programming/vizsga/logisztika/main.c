#include <stdio.h>
#include <stdlib.h>
#include "log.h"

int main() {
    Node* root = NULL;
    /*
    int initial[] = {8, 10, 3, 14, 1, 13, 6, 4, 7};
    for(int i = 0; i < 9; i++) {
        root = insert_pkg(root, initial[i]);
    }
 */
    int running = 1;
    while(running) {
        printf("\nMenu:\n");
        printf("1) Hozzaadas\n");
        printf("2) Kirajzolas\n");
        printf("3) Rakodasi lista\n");
        printf("4) Csomag torlese\n");
        printf("5) Kilepes\n");
        printf("Valasztas: ");
        int choice;
        scanf("%d", &choice);

        switch(choice) {
            case 1: {
                int dist;
                printf("Add meg a raklap tavolsagat: ");
                scanf("%d", &dist);
                root = insert_pkg(root, dist);
                break;
            }
            case 2:
                print_tree(root, 0);
                break;
            case 3: {
                int size = 0;
                Node** manifest = get_manifest(root, &size);
                if(manifest) {
                    FILE* f = fopen("manifest.txt", "w");
                    if(f) {
                        for(int i = 0; i < size; i++) {
                            fprintf(f, "(%p, %d)\n", (void*)manifest[i], manifest[i]->distance);
                        }
                        fclose(f);
                        printf("Kiiras kesz, manifest.txt\n");
                    }
                    free(manifest);
                }
                break;
            }
            case 4: {
                int dist;
                printf("Melyik tavolsagu csomagot toroljuk? ");
                scanf("%d", &dist);
                root = delete_pkg(root, dist);
                break;
            }
            case 5:
                delete_all_pkgs(root);
                root = NULL;
                running = 0;
                break;
            default:
                printf("Ervenytelen valasztas.\n");
        }
    }
    return 0;
}
