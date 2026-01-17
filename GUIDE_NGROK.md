# 🌍 Guide : Mettre le Backend en Ligne avec Ngrok

Ce guide vous permet de rendre votre "Cerveau" (Python/Prolog) accessible d'internet, pour que le site sur Vercel puisse lui parler.

## 1️⃣ Installation (Déjà lancée)
Si l'installation automatique n'a pas marché, tapez ceci dans un terminal :
```bash
winget install ngrok
```

## 2️⃣ Connexion (Obligatoire)
Ngrok a besoin d'un compte gratuit pour fonctionner.
1.  Créez un compte sur [dashboard.ngrok.com](https://dashboard.ngrok.com/signup).
2.  Dans votre tableau de bord, copiez votre **Authtoken**.
3.  Ouvrez votre terminal et collez la commande donnée par le site, ex :
    ```bash
    ngrok config add-authtoken VOTRE_TOKEN_ICI
    ```

## 3️⃣ Lancer le Tunnel
À chaque fois que vous voulez que le site Vercel marche :
1.  Lancez votre serveur Python normalement (`python backend/server.py`).
2.  Ouvrez un **nouveau terminal**.
3.  Tapez :
    ```bash
    ngrok http 5000
    ```
4.  Ngrok va vous donner une URL bizarre (ex: `https://a1b2-c3d4.ngrok-free.app`).

## 4️⃣ Connecter Vercel
1.  Copiez cette URL (https://...).
2.  Allez sur votre projet **Vercel** -> **Settings** -> **Environment Variables**.
3.  Ajoutez une variable :
    *   **Key** : `VITE_API_URL`
    *   **Value** : `https://a1b2-c3d4.ngrok-free.app` (Votre URL Ngrok sans slash à la fin)
4.  Redéployez le site Vercel (ou attendez quelques minutes).

✅ **Terminé ! Votre site Vercel parle maintenant à votre PC.**
