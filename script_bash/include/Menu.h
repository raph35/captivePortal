#ifndef MENU_H
#define MENU_H
#include <iostream>

using namespace std;

class Menu{
    public:
    // Contructor and desctructor
        Menu();
        ~Menu();

    // Loop and the textmenu
        void show();
        void loop();
        

    // Getters and setters 
        char getChoice();
        void setChoice(char choice);

    private:
        char choice;
};


#endif