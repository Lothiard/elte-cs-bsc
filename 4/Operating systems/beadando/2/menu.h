#ifndef MENU_H
#define MENU_H

#include "bor.h"

void menu_print(void);
int menu_input(void);
void menu_handle_input(int input, BorData* db);

#endif
