# 🌍 Guide Complet : Partager YAFI avec Ngrok

Ce guide vous permet de partager **tout le site web** (Frontend + Backend) via Ngrok pour que d'autres personnes puissent l'utiliser.

---

## 📋 **Ce Qu'il Faut Savoir**

Votre application a **2 parties** :
- **Frontend** (Vite/React) : Port **5173**
- **Backend** (Python/Flask) : Port **5000**

### 🎯 **Solution Recommandée : 2 Tunnels Ngrok**

Pour que tout fonctionne, vous devez exposer les 2 ports avec ngrok.

---

## 1️⃣ **Installation de Ngrok** (Une seule fois)

Si ngrok n'est pas encore installé :
```bash
winget install ngrok
```

---

## 2️⃣ **Configuration Authtoken** (Une seule fois)

1. Créez un compte **gratuit** sur [dashboard.ngrok.com](https://dashboard.ngrok.com/signup)
2. Copiez votre **Authtoken** depuis le dashboard
3. Exécutez dans le terminal :
```bash
ngrok config add-authtoken VOTRE_TOKEN_ICI
```

---

## 3️⃣ **Lancer les Services Locaux**

### Terminal 1 : Backend (Python)
```bash
cd c:\Users\user\Documents\CHATgpt
python backend/server.py
```
✅ Backend démarre sur `http://localhost:5000`

### Terminal 2 : Frontend (Vite)
```bash
cd c:\Users\user\Documents\CHATgpt
npm run dev
```
✅ Frontend démarre sur `http://localhost:5173`

---

## 4️⃣ **Exposer le Backend via Ngrok**

### Terminal 3 : Ngrok Backend
```bash
cd c:\Users\user\Documents\CHATgpt
ngrok http 5000
```

📋 **Notez l'URL générée**, exemple :
```
https://abc123-xyz.ngrok-free.app
```

⚠️ **IMPORTANT** : Copiez cette URL, vous en aurez besoin !

---

## 5️⃣ **Configurer le Frontend pour Utiliser le Backend Ngrok**

### Modifier le fichier `.env`

Ouvrez `c:\Users\user\Documents\CHATgpt\.env` et modifiez :

```env
VITE_SUPABASE_URL=https://aiwsjiftowyensxgbrlj.supabase.co
VITE_SUPABASE_ANON_KEY=sb_publishable_oinhjI77TP0dFOSfVgPxeA_JDEsPyrD
VITE_PYTHON_API_URL=https://abc123-xyz.ngrok-free.app
```

⚠️ Remplacez `https://abc123-xyz.ngrok-free.app` par **votre vraie URL ngrok du backend** !

### Redémarrer le Frontend

**Arrêtez** le frontend (Ctrl+C dans Terminal 2) puis relancez :
```bash
npm run dev
```

---

## 6️⃣ **Exposer le Frontend via Ngrok**

### Terminal 4 : Ngrok Frontend
```bash
cd c:\Users\user\Documents\CHATgpt
ngrok http 5173
```

📋 **C'EST CETTE URL QUE VOUS PARTAGEZ !**

Exemple :
```
https://def456-uvw.ngrok-free.app
```

---

## 7️⃣ **Partager le Lien**

✅ **Envoyez le lien du FRONTEND (Terminal 4)** à vos amis :
```
https://def456-uvw.ngrok-free.app
```

🎉 **Ils pourront utiliser le site complet !**

---

## 📝 **Résumé des 4 Terminaux**

| Terminal | Commande | Port | Description |
|----------|----------|------|-------------|
| **1** | `python backend/server.py` | 5000 | Backend Python |
| **2** | `npm run dev` | 5173 | Frontend React |
| **3** | `ngrok http 5000` | - | Tunnel Backend |
| **4** | `ngrok http 5173` | - | **Tunnel Frontend (À PARTAGER)** |

---

## ⚠️ **Notes Importantes**

### 🔄 **À Chaque Redémarrage de Ngrok**

Les URLs Ngrok changent à chaque fois que vous relancez ngrok (sauf si vous avez un compte payant).

**Si vous relancez ngrok pour le backend** :
1. Notez la nouvelle URL backend
2. Mettez à jour `.env` → `VITE_PYTHON_API_URL`
3. Redémarrez le frontend (`npm run dev`)
4. Relancez ngrok pour le frontend
5. Partagez la nouvelle URL frontend

### 🌟 **Alternative : Ngrok Compte Payant**

Avec un compte ngrok payant (~5$/mois), vous pouvez :
- Avoir des URLs **fixes** (qui ne changent pas)
- Éviter de tout reconfigurer à chaque fois

---

## 🚀 **Workflow Complet (Démarrage Rapide)**

```bash
# Terminal 1
python backend/server.py

# Terminal 2
npm run dev

# Terminal 3
ngrok http 5000
# → Copier l'URL et mettre à jour .env

# Terminal 2 (Redémarrer)
Ctrl+C
npm run dev

# Terminal 4
ngrok http 5173
# → PARTAGER CETTE URL !
```

---

## ❓ **Dépannage**

### ❌ **"Erreur de connexion au Cerveau"**
➡ Le frontend ne trouve pas le backend
- Vérifiez que ngrok backend est lancé (Terminal 3)
- Vérifiez que `.env` contient la bonne URL ngrok
- Redémarrez le frontend

### ❌ **"This site can't be reached"**
➡ Ngrok frontend n'est pas lancé
- Vérifiez Terminal 4
- Vérifiez que `npm run dev` tourne (Terminal 2)

### ❌ **"Visit Site" sur page Ngrok**
➡ Page d'avertissement ngrok (compte gratuit)
- Cliquez sur "Visit Site" pour continuer
- C'est normal avec le compte gratuit

---

✅ **Voilà ! Vous pouvez maintenant partager YAFI avec le monde !** 🎓🤖
