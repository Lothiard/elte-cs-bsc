#include <stdio.h>
#include <stdlib.h>
#include "log.h"

Node* create_pkg(int distance) {
    Node* newNode = malloc(sizeof(Node));
    if(!newNode) return NULL;
    newNode->distance = distance;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

Node* insert_pkg(Node* root, int distance) {
    if(!root) return create_pkg(distance);
    if(root->distance == distance) {
        printf("Hiba: %d mar letezik!\n", distance);
        return root;
    }
    if(distance < root->distance) {
        root->left = insert_pkg(root->left, distance);
    } else {
        root->right = insert_pkg(root->right, distance);
    }
    return root;
}

void print_tree(Node* root, int depth) {
    if(!root) return;
    print_tree(root->left, depth + 1);
    for(int i = 0; i < depth; i++) {
        printf("   ");
    }
    printf("%d\n", root->distance);
    print_tree(root->right, depth + 1);
}

static void fill_manifest(Node* root, Node** arr, int* index) {
    if(!root) return;
    fill_manifest(root->left, arr, index);
    arr[*index] = root;
    (*index)++;
    fill_manifest(root->right, arr, index);
}

static int count_nodes(Node* root) {
    if(!root) return 0;
    return 1 + count_nodes(root->left) + count_nodes(root->right);
}

Node** get_manifest(Node* root, int* size) {
    *size = count_nodes(root);
    if(*size == 0) return NULL;
    Node** arr = malloc(*size * sizeof(Node*));
    int index = 0;
    fill_manifest(root, arr, &index);
    return arr;
}

static Node* find_min(Node* root) {
    while(root && root->left) {
        root = root->left;
    }
    return root;
}

Node* delete_pkg(Node* root, int distance) {
    if(!root) return NULL;
    if(distance < root->distance) {
        root->left = delete_pkg(root->left, distance);
    } else if(distance > root->distance) {
        root->right = delete_pkg(root->right, distance);
    } else {
        if(!root->left && !root->right) {
            free(root);
            return NULL;
        } else if(!root->left) {
            Node* temp = root->right;
            free(root);
            return temp;
        } else if(!root->right) {
            Node* temp = root->left;
            free(root);
            return temp;
        } else {
            Node* temp = find_min(root->right);
            root->distance = temp->distance;
            root->right = delete_pkg(root->right, temp->distance);
        }
    }
    return root;
}

void delete_all_pkgs(Node* root) {
    if(!root) return;
    delete_all_pkgs(root->left);
    delete_all_pkgs(root->right);
    free(root);
}