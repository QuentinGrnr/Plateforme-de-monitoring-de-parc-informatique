#!/bin/bash

DB_PATH="DB/stockage.db"
LIMIT=$1

# Exporter les données depuis la base de données SQLite dans un fichier CSV
sqlite3 -header -csv "$DB_PATH" "SELECT date_heure_scan, userCount FROM monitoring ORDER BY date_heure_scan DESC LIMIT $LIMIT;" > data.csv

# Utiliser gnuplot pour générer le graphique
gnuplot << EOF
set datafile separator ","
set terminal png size 800,600
set output "Web/static/img/user_count.png"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M"  # Réglez le format de l'axe x comme nécessaire
set xlabel "Date et heure" textcolor rgb "white"
set ylabel "User Count" textcolor rgb "white"
set title "Evolution du User Count" textcolor rgb "white"
set grid linecolor rgb "white" linewidth 1
set border linecolor rgb "white" linewidth 1
set key textcolor rgb "white"
set style line 1 linecolor rgb "white"
set style line 2 linetype 0 pointtype 0 linecolor rgb "white"

# Définir la couleur de fond avec une bordure transparente
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb "#303F9F" behind
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb "#303F9F" behind lw 0

# Hachurer le dessous des lignes en blanc
set style fill pattern 1 border lt -1
set style line 1 lt 1 lw 2 pt 7 ps 0.5 lc rgb "white"

plot "data.csv" using 1:2 with lines ls 1 title "User Count"
EOF


# Supprimer le fichier CSV temporaire
rm data.csv