# Proposition : Chatbot "Expert" (Python + Prolog)

Vous avez demandé si l'on peut remplacer l'IA actuelle (ChatGPT) par une **IA Symbolique** basée sur **Prolog**. C'est **tout à fait possible** et c'est un excellent choix pour un PFE académique.

## Architecture Proposée

L'application changerait complètement de logique. Elle ne "devinerait" plus les réponses, elle les "calculerait" logiquement.

### 1. La Base de Connaissance (Prolog)
C'est le cerveau logique. Il contient des **Faits** (données) et des **Règles** (logique).
*Fichier : `knowledge.pl`*
```prolog
% Faits
enseignant('M. Dupont', 'Biologie').
enseignant('Mme. Martin', 'Maths').
dispo('M. Dupont', 'Lundi').

% Règles
peut_rencontrer(Etudiant, Prof) :- 
    a_cours_avec(Etudiant, Prof),
    dispo(Prof, Jour),
    dispo(Etudiant, Jour).
```

### 2. Le Serveur (Python)
C'est l'interface. Il reçoit la question de l'utilisateur, la traduit en logique, et interroge Prolog.
*Technologies :* `Flask` (Web) ou `Streamlit`, + `pyswip` (Pont Python-Prolog).

### 3. Comparaison avec l'existant

| Critère | IA Actuelle (GenAI) | IA Prolog (Symbolique) |
| :--- | :--- | :--- |
| **Intelligence** | Créative, comprend le langage naturel. | Logique pure, déductive. |
| **Précision** | Peut mentir ("Hallucination"). | **100% Exacte**. Ne se trompe jamais. |
| **Dialogue** | Fluide ("Salut, ça va ?"). | Rigide (Mots-clés ou règles strictes). |
| **PFE** | Tendance "Moderne / Start-up". | Tendance "Recherche / Algorithmique". |

## Décision Requise

Pour passer à cette architecture, nous devons :
1.  **Abandonner** le code React/Supabase actuel (ou le garder juste pour le design).
2.  **Installer Python** et **SWI-Prolog** sur votre machine.
3.  Réécrire la logique en règles Prolog.

**Voulez-vous démarrer ce projet maintenant ?**
