// This programm will manage the firewall raised by the
// captive portal

// Author: RALAIKOA Falinirina Raphael Joseph
// Date: 14 Octobre 2020


#include <iostream>
#include "../include/Menu.h"
#include "../include/function.h"
#include "../include/CaptivePortal.h"

using namespace std;
int main(int argc, char* argv[]){
    // Debut du programme
    // Verify if the programme is launched by root
    if(system("test $USER != root ") == 0){
        std::cout << "Le programme doit etre execute en root" << std::endl;
        return -1;
    }
    printSplashScreen();
    CaptivePortal::backupRules();

    // Launching the main menu
    Menu menu = Menu();
    char choice = '1';
    while(1){
        // system("clear");
        menu.show();
        if(menu.getChoice() == '5'){
            CaptivePortal::stop();
            break;
        }
        menu.process();
    }

    // Fin du programme
    CaptivePortal::end();    
    printEndProgrammText();
    return 0;
}
