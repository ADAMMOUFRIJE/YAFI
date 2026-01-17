# 🎓 YAFI Chatbot - Présentation du Projet

## 🌟 Introduction
**YAFI** (Yasser - Adam - Fahd - Intelligence) est une plateforme d'orientation intelligente dédiée aux étudiants marocains (post-bac). 
Contrairement aux chatbots classiques, YAFI combine la puissance de l'IA générative avec la rigueur d'un **système expert (Prolog)** pour fournir des réponses précises, fiables et vérifiées sur les écoles, les seuils d'admission et les stratégies d'orientation.

---

## 🚀 Fonctionnalités Principales

### 🤖 1. Chatbot d'Orientation Intelligent
*   **Conseil Personnalisé** : Analyse des notes (Régional/National) pour calculer un score et recommander des filières adaptées.
*   **Info Écoles** : Détails complets sur les établissements (ENSA, ENCG, Médecine, FST, EST, OFPPT, etc.).
*   **Stratégie** : Comparaison entre le secteur Public (Gratuit, Sélectif) et Privé (Payant, Flexible).
*   **Recherche Géographique** : "Quelles écoles à Marrakech ?", "Où trouver l'ENSA ?".

### 👑 2. Système Premium (YAFI PLUS)
*   **Modèle Freemium** : Les utilisateurs gratuits sont limités à 5 questions par 30 minutes.
*   **Upgrade** : Paiement unique pour débloquer l'illimité et supprimer les publicités (simulation).
*   **Compte à Rebours** : Affichage dynamique du temps restant avant la prochaine question gratuite.

### 🛠️ 3. Panneau d'Administration (Admin Center)
Une interface dédiée aux administrateurs pour gérer le contenu sans toucher au code :
*   **Gestion des Membres** : Voir les utilisateurs, leurs statistiques, et **accorder/retirer le statut Premium** en un clic.
*   **Q&A Personnalisées** : Ajouter manuellement des questions/réponses spécifiques pour surcharger la logique de base.
*   **Base Documentaire (RAG)** : Ajouter des documents texte pour enrichir les connaissances de l'IA.

### 📊 4. Analyse et Profilage
*   **Extraction de Profil** : Le système détecte automatiquement les infos de l'utilisateur (Bac, Moyenne, Ville) au fil de la discussion pour mieux l'orienter.
*   **Historique** : Sauvegarde des conversations pour les reprendre plus tard.

---

## 💻 Stack Technologique

Le projet repose sur une architecture moderne et hybride :

### 🎨 Frontend (Interface)
*   **React (TypeScript)** : Pour une interface fluide et réactive.
*   **Tailwind CSS** : Pour un design moderne, responsive et esthétique ("Glassmorphism").
*   **Vite** : Pour des performances de développement et de build ultra-rapides.
*   **Lucide React** : Pour des icônes vectorielles élégantes.

### 🧠 Backend & IA (Cerveau)
*   **Python (Flask)** : API REST qui gère les requêtes du frontend et orchestre la logique.
*   **SWI-Prolog** : **Cœur du système expert**. Il contient la base de connaissances logique (règles d'admission, dates, seuils).
*   **PySwip** : Passerelle ("Bridge") permettant à Python d'interroger la base Prolog.

### ☁️ Base de Données & Auth
*   **Supabase** : Backend-as-a-Service complet.
    *   **PostgreSQL** : Pour stocker les utilisateurs, les messages, les sessions et les configurations Admin.
    *   **Authentication** : Gestion sécurisée des inscriptions et connexions.

---

## 🏗️ Architecture Simplifiée

`[React Frontend]` <---> `[Flask API]` <---> `[Prolog Knowledge Base]`
                               ^
                               |
                        `[Supabase DB]`

---

## ✍️ Auteurs
Développé par **Adam Moufrije** dans le cadre du projet PFE (Projet de Fin d'Études) - EST Safi.
