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
    // Verify if the programme is launched by root
    if(system("test $USER != root ") == 0){
        std::cout << "Le programme doit etre execute en root" << std::endl;
        return -1;
    }
    printSplashScreen();

    // Launching the main menu
    Menu menu = Menu();
    char choice = '1';
    while(1){
        menu.show();
        if(menu.getChoice() == '5')
            break;
        menu.process();
    }

    // Fin du programme
    printEndProgrammText();
    return 0;
}
