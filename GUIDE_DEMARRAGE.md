# 🚀 Guide de Démarrage Rapide - YAFI Chatbot

## 0️⃣ Prérequis (Installation par commande)

Ouvrez un terminal (PowerShell ou CMD) en tant qu'administrateur et copiez cette commande pour tout installer d'un coup :

```bash
winget install -e --id OpenJS.NodeJS
winget install -e --id Python.Python.3.11
winget install -e --id SWI-Prolog.SWI-Prolog
```

*Une fois terminé, REDÉMARREZ votre terminal pour que les commandes soient prises en compte.*

## 1️⃣ Première Installation (Après avoir téléchargé le projet)

Suivez ces étapes UNIQUEMENT la première fois :

1.  **Ouvrez un terminal** dans le dossier du projet.
2.  **Installez les dépendances Frontend :**
    ```bash
    npm install
    ```
3.  **Installez les dépendances Backend (Python) :**
    ```bash
    pip install flask flask-cors pyswip python-dotenv supabase
    ```
    *(Assurez-vous d'avoir Python et SWI-Prolog installés sur votre PC)*
4.  **Configurez l'environnement :**
    *   Créez un fichier `.env` à la racine (copiez le contenu de `.env.example` si disponible).
    *   Ajoutez vos clés Supabase si nécessaire.

---

## 2️⃣ Lancement Quotidien (Si le projet est déjà installé)

À chaque fois que vous voulez travailler sur le projet, ouvrez **DEUX terminaux** :

### Terminal 1 (Frontend) :
```bash
npm run dev
```
*Le site sera accessible ici : `http://localhost:5173`*

### Terminal 2 (Backend) :
```bash
python backend/server.py
```
*Le serveur Flask doit afficher : `Running on http://127.0.0.1:5000`*

---

✅ **C'est tout ! Le projet est opérationnel.**
