#include "../include/Menu.h"

Menu::Menu(){
    choice = '1';
}

Menu::~Menu(){

}

void Menu::show(){
    cout << "1. Demarrer le service" << endl;
    cout << "2. Restarter le service(suprimme toutes les utilisateurs)" << endl;
    cout << "3. Stopper le service" << endl;
    cout << "4. Regarder les regles actives" << endl;
    cout << "5. Quitter l'application" << endl;
    cout << "Entrer votre choix: ";
    cin >> choice;
}

char Menu::getChoice(){
    return choice;
}

void Menu::setChoice(char _choice){
    choice = _choice;
}