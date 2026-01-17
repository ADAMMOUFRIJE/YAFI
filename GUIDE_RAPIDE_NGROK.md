# 🚀 GUIDE RAPIDE : Partager YAFI en 3 Étapes

## ✅ CE QUE VOUS AVEZ DÉJÀ
- ✅ Backend lancé (python backend/server.py) ← Terminal 1
- ✅ Frontend lancé (npm run dev) ← Terminal 2
- ✅ Ngrok installé

---

## 🎯 CE QU'IL FAUT FAIRE

### PROBLÈME ACTUEL
Vous avez lancé : `ngrok http 5173`

❌ **PROBLÈME** : Le frontend essaie de se connecter au backend local (localhost:5000)
    → Les autres personnes ne peuvent pas accéder au backend !

### ✅ SOLUTION : 2 Tunnels Ngrok

```
┌─────────────────────────────────────┐
│  PERSONNE EXTERNE                   │
│                                     │
│  1. Visite l'URL du FRONTEND ngrok │
│     ↓                               │
│  2. Le site charge dans le browser │
│     ↓                               │
│  3. Le site essaie de contacter     │
│     le BACKEND                      │
│     ↓                               │
│  4. ❌ ERREUR si backend            │
│     n'est pas exposé !              │
└─────────────────────────────────────┘
```

---

## 📝 ÉTAPES À SUIVRE

### OPTION A : Script Automatique (Recommandé) ⭐

```powershell
.\setup-ngrok.ps1
```

Le script va :
1. Vérifier que tout tourne
2. Vous demander l'URL ngrok du backend
3. Mettre à jour le .env automatiquement
4. Vous demander l'URL du frontend
5. Afficher l'URL finale à partager

---

### OPTION B : Manuel (Étape par étape)

#### 🔵 ÉTAPE 1 : Exposer le Backend

**Terminal 3** (nouveau) :
```bash
ngrok http 5000
```

Vous verrez quelque chose comme :
```
Forwarding    https://abc-123-xyz.ngrok-free.app -> http://localhost:5000
```

📋 **Copiez cette URL** : `https://abc-123-xyz.ngrok-free.app`

---

#### 🔵 ÉTAPE 2 : Configurer le Frontend

Ouvrez `.env` et modifiez la ligne :

**AVANT** :
```env
VITE_PYTHON_API_URL=http://localhost:5000
```

**APRÈS** :
```env
VITE_PYTHON_API_URL=https://abc-123-xyz.ngrok-free.app
```
⚠️ Remplacez par VOTRE vraie URL !

---

#### 🔵 ÉTAPE 3 : Redémarrer le Frontend

**Terminal 2** (celui qui tourne npm run dev) :
1. Appuyez sur `Ctrl+C`
2. Relancez : `npm run dev`

✅ Le frontend utilise maintenant l'URL ngrok du backend !

---

#### 🔵 ÉTAPE 4 : Exposer le Frontend

⚠️ **IMPORTANT** : Votre ngrok actuel (Terminal 3) est déjà sur le backend.

**Terminal 4** (nouveau) :
```bash
ngrok http 5173
```

Vous verrez :
```
Forwarding    https://def-456-uvw.ngrok-free.app -> http://localhost:5173
```

📋 **C'EST CETTE URL À PARTAGER** : `https://def-456-uvw.ngrok-free.app`

---

## ✅ VÉRIFICATION FINALE

Vous devriez avoir **4 TERMINAUX** :

| # | Commande | Port | Status |
|---|----------|------|--------|
| 1 | `python backend/server py` | 5000 | ✅ Tourne |
| 2 | `npm run dev` | 5173 | ✅ Tourne |
| 3 | `ngrok http 5000` | - | ✅ Backend exposé |
| 4 | `ngrok http 5173` | - | ✅ **Frontend exposé (À PARTAGER)** |

---

## 🎉 RÉSULTAT

Envoyez l'URL du Terminal 4 à vos amis :

```
https://def-456-uvw.ngrok-free.app
```

Ils pourront :
✅ Voir le site web
✅ Discuter avec le chatbot
✅ Utiliser toutes les fonctionnalités
✅ Accéder à Supabase

---

## ⚠️ ATTENTION

### Si vous fermez ngrok backend (Terminal 3) :
❌ Le frontend ne pourra plus parler au backend
🔧 Solution : Relancez `ngrok http 5000`, notez la NOUVELLE URL, mettez à jour `.env`, redémarrez le frontend

### Si vous fermez ngrok frontend (Terminal 4) :
❌ Personne ne peut accéder au site
🔧 Solution : Relancez `ngrok http 5173`, partagez la NOUVELLE URL

### URLs changent à chaque redémarrage ⚠️
Les URLs ngrok (compte gratuit) changent quand vous relancez ngrok.

💡 **Astuce** : Ne fermez pas les terminaux ngrok pendant que quelqu'un utilise le site !

---

## 🚨 DÉPANNAGE

### Erreur "Connexion au Cerveau"
➡️ Le backend ngrok ne fonctionne pas
1. Vérifiez Terminal 3 (ngrok http 5000)
2. Vérifiez `.env` a la bonne URL
3. Redémarrez le frontend (Terminal 2)

### Page blanche
➡️ Le frontend ngrok ne fonctionne pas
1. Vérifiez Terminal 4 (ngrok http 5173)
2. Vérifiez Terminal 2 (npm run dev)

### "Visit Site" page d'avertissement
➡️ C'est normal (compte gratuit)
→ Cliquez sur "Visit Site" pour continuer

---

## 🎓 EXEMPLE COMPLET

```
Terminal 1:
PS C:\Users\user\Documents\CHATgpt> python backend/server.py
Serveur Python + SWI-Prolog démarré sur le port 5000

Terminal 2:
PS C:\Users\user\Documents\CHATgpt> npm run dev
VITE ready in 500ms
Local: http://localhost:5173

Terminal 3:
PS C:\Users\user\Documents\CHATgpt> ngrok http 5000
Forwarding: https://abc-123.ngrok-free.app -> localhost:5000
                    ↑
        COPIER CETTE URL → Mettre dans .env

Terminal 4:
PS C:\Users\user\Documents\CHATgpt> ngrok http 5173
Forwarding: https://def-456.ngrok-free.app -> localhost:5173
                    ↑
        PARTAGER CETTE URL avec vos amis !
```

---

✅ **C'est tout ! Bonne chance ! 🚀**
