#!/bin/bash

# Pour executer le programme automatiquement, modifier crontab -e
echo "-------------------"
echo "$(date +"%Y-%m-%d %T")"
echo "-------------------"

cd "$(dirname "$0")"

DB_PATH="./DB/stockage.db"
SONDES_DIR="./sondes"
BACKUP_DIR="./save"

# Fonction pour ajouter une colonne à la table
add_column() {
    local column_name="$1"
    local query="ALTER TABLE monitoring ADD COLUMN \"$column_name\" $2;"
    sqlite3 "$DB_PATH" "$query"
}

sqlite3 "$DB_PATH" "CREATE TABLE IF NOT EXISTS monitoring (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_heure_scan DATETIME DEFAULT CURRENT_TIMESTAMP
);"

all_data=""
sonde_names=""

########################## get all sonde info ############################
for filename in "$SONDES_DIR"/*; do
    if [[ $filename != *getCertAlert.py ]]; then

        sondename=$(basename "$filename" | cut -f1 -d '.') # Récupérer le nom de fichier sans extension

        # Vérifier si la colonne existe dans la table, sinon l'ajouter
        if ! sqlite3 "$DB_PATH" ".schema monitoring" | grep -qE "\b$sondename\b"; then
            add_column "$sondename" REAL
        fi

        # Exécuter la sonde et récupérer la sortie
        if [[ $filename == *.py ]]; then
            data=$(python3 "$filename")
        elif [[ $filename == *.sh ]]; then
            data=$(bash "$filename")
        else
            continue
        fi

        echo "$sondename : $data" #affichage dans info_sondes.txt

        # Remplacer la virgule d'un float par un point si elle est présente
        data=$(echo "$data" | sed 's/,/./')

        sonde_names+=", $sondename"
        all_data+=", $data"
    fi
done

########################## Insertion en DB ############################

# Supprimer la première virgule de all_data et de sonde_names
sonde_names=$(echo "$sonde_names" | sed 's/^,//')
all_data=$(echo "$all_data" | sed 's/^,//')

# Insérer toutes les données dans la base de données
sqlite3 "$DB_PATH" "INSERT INTO monitoring (${sonde_names}) VALUES (${all_data});"

count=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM monitoring;")
# si le nombre de lignes est supérieur à 100, supprimer la première ligne
if [ "$count" -gt 100 ]; then
    sqlite3 "$DB_PATH" "DELETE FROM monitoring WHERE id = (SELECT id FROM monitoring ORDER BY date_heure_scan ASC LIMIT 1);"
fi

# Exécuter la sonde getCertAlert.py pour ajouter en db les alertes
python3 sondes/getCertAlert.py

########################## créer la backup tout les 10 scans ############################
bash save/CreateBackup.sh

########################## verif argument ############################

# obtenir current nom de backup 
current_backup=$(ls -t $BACKUP_DIR | head -n1)

# Vérifier si l'argument est égal à "_save", "_restore" ou "_config"
if [ "$1" == "_save" ]; then #sauvegarder la DB manuellement
    bash save/CreateBackup.sh manuel
elif [ "$1" == "_restore" ]; then #remplacer la DB actuelle par la backup
    echo "database remplacée par backup"
    cp "save/$current_backup" "$DB_PATH" 
elif [ "$1" == "_config" ]; then #configurer les alertes et les graphs
    python3 config.py
fi

########################## creer les graphs ############################

# Param : limite echelle de temps
limit_data=$(sqlite3 "$DB_PATH" "SELECT history_threshold FROM config ORDER BY id DESC LIMIT 1;")

# Appeler chaque script avec la valeur appropriée
bash "graph/cpu_usage_graph.sh" "$limit_data" >/dev/null 2>&1
bash "graph/disk_usage_graph.sh" "$limit_data" >/dev/null 2>&1
bash "graph/ram_usage_graph.sh" "$limit_data" >/dev/null 2>&1
bash "graph/process_count_graph.sh" "$limit_data" >/dev/null 2>&1
bash "graph/user_count_graph.sh" "$limit_data" >/dev/null 2>&1

########################## Envoie MAIL alerte ############################

python3 AlertMail/MailCrisis.py