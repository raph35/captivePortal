# Fonctionalitées dans les scripts
## Usage
start: Démmare le service

stop: Arrête le service, laissant passer toutes les connections(Stoppe le pare-feu)

restart: Redémmare puis relance le service en excluant les utilisateurs déja connectées

reboot: Redémmare puis relance le service en supprimant toutes les utilisateurs connectées

## Explication des fonctions utilisées
querySql: Faire une requete sql dans la base de données
Usage: querySql STATEMENT
STATEMENT la requete sql à executer

pingUser: execute une requete ICMP(ping) vers une ip et retourne
le status de la requete