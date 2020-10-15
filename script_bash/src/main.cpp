// This programm will manage the firewall raised by the
// captive portal

// Author: RALAIKOA Falinirina Raphael Joseph
// Date: 14 Octobre 2020


#include <iostream>
#include "../include/Menu.h"
#include "../include/function.h"

using namespace std;
int main(int argc, char* argv[]){
    // Debut du programme

    // Launching the main menu
    Menu menu = Menu();
    char choice = '1';
    while(1){
        if(!(   menu.getChoice() == '1' || \
                menu.getChoice() == '2' || \
                menu.getChoice() == '3' || \
                menu.getChoice() == '4' || \
                menu.getChoice() == '5' )){
            cout << "Choix invalide!!" << endl;
        }
        menu.show();
        if(menu.getChoice() == '5')
            break;
    }

    // Fin du programme
    return 0;
}