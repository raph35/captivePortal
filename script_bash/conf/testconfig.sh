# This script will do some test to check the configuration
# of the mysql and the captiveportal

# Sourcing functions that will be used
. .././function.sh

# Sourcing configurations files
. ./mysql.conf;

#checking if the confugurations are valide
echo -n "Utilisateur et mot de passe mysql..."
if [ -z mysql_user -a -z mysql_passworld ]; then
    echo "              [missing]"
else
    export MYSQL_PWD=$mysql_password
	$MYSQL -u $mysql_user $database_name
    if [ $? -eq 0 ]; then
        echo "           [OK]"
    else
        echo "           [wrong data]"
    fi
fi