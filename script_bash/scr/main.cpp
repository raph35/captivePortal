// This programm will manage the firewall raised by the
// captive portal

// Author: RALAIKOA Falinirina Raphael Joseph
// Date: 14 Octobre 2020


#include <iostream>
#include "../scr/Menu.cpp"

int main(int argc, char* argv[]){
    // Launching the main menu
    Menu menu = Menu();
    char choice = '1';
    while( menu.getChoice() != '5' ){
        menu.show();
    }
    return 0;
}