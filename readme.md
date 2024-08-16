Voici un exemple de README pour présenter votre projet :

```
# Plateforme de Surveillance Informatique

Ce projet vise à développer une plateforme de surveillance informatique permettant de collecter des données sur les performances des systèmes informatiques, de détecter les situations de crise et d'envoyer des alertes en cas de besoin.

## Fonctionnalités

- Surveillance en temps réel des performances du CPU, du disque, de la RAM, du nombre de processus et du nombre d'utilisateurs connectés.
- Détection automatique des situations de crise en comparant les valeurs actuelles avec des seuils critiques configurables.
- Envoi d'alertes par e-mail en cas de dépassement des seuils critiques.
- Interface web pour consulter les informations et les historiques sous forme de graphiques.

## Utilisation

1. Cloner le dépôt depuis GitHub :

```bash
git clone https://github.com/votre-utilisateur/plateforme-surveillance-informatique.git
cd plateforme-surveillance-informatique
```

2. Installer les dépendances Python (voir ci dessous)

3. Configurer les seuils critiques dans le fichier `./main.sh _config`.

4. Exécuter le programme principal :

```bash
./main.sh
```

5. Configurer une tâche Cron pour exécuter le programme à intervalles réguliers. Par exemple, pour exécuter le programme toutes les 5 minutes :

```bash
*/5 * * * * /chemin/vers/main.sh
```

## Dépendances

- Python 3.x
- SQLite (inclus dans Python)
- Bibliothèques Python : flask, jinja2, requests, beautifulsoup4


## Structure du Projet

```
- Web / 
    app.py           # Point d'entrée de l'application Web
    templates/       # Modèles HTML pour l'interface Web
        index.html
    static/          # Fichiers statiques pour l'interface Web (CSS, JS, images)
- DB/              # Base de données SQLite contenant toutes les données de monitoring
  - stockage.db
- AlertMail/         # gestion envoie mail et detection situation crtique
- graph/        # creation des graph
- main.sh       # fichier principal du projet

```

## Auteurs

- [Garnier Quentin](https://github.com/ClueXIII)
