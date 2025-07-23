#ifndef LOG_H
#define LOG_H

typedef struct Node {
    int distance;
    struct Node* left;
    struct Node* right;
} Node;

Node* create_pkg(int distance);
Node* insert_pkg(Node* root, int distance);
void print_tree(Node* root, int depth);
Node** get_manifest(Node* root, int* size);
Node* delete_pkg(Node* root, int distance);
void delete_all_pkgs(Node* root);

#endif