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

2. Installer les dépendances Python :

```bash
pip install -r requirements.txt
```

3. Configurer les seuils critiques dans le fichier `config.py`.

4. Configurer les adresses e-mail dans le fichier `config.py`.

5. Exécuter le programme principal :

```bash
python main.py
```

6. Configurer une tâche Cron pour exécuter le programme à intervalles réguliers. Par exemple, pour exécuter le programme toutes les 5 minutes :

```bash
*/5 * * * * /chemin/vers/python /chemin/vers/plateforme-surveillance-informatique/main.py
```

## Dépendances

- Python 3.x
- SQLite (inclus dans Python)
- Bibliothèques Python : flask, jinja2, requests, beautifulsoup4

## Structure du Projet

```
- app.py           # Point d'entrée de l'application Web
- config.py        # Configuration des seuils et des adresses e-mail
- monitoring.py    # Collecte des données de surveillance
- send_email.py    # Envoi d'e-mails d'alerte
- templates/       # Modèles HTML pour l'interface Web
  - index.html
- static/          # Fichiers statiques pour l'interface Web (CSS, JS, images)
  - css/
    - style.css
- DB/              # Base de données SQLite
  - stockage.db
```

## Auteurs

- [Nom de l'Auteur](https://github.com/auteur1)
- [Nom de l'Auteur](https://github.com/auteur2)

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.
```

Assurez-vous de personnaliser les sections en fonction des détails spécifiques de votre projet.