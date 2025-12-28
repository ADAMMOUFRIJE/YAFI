from flask import Flask, request, jsonify
from flask_cors import CORS
from pyswip import Prolog 
import random
import time

app = Flask(__name__)
CORS(app)

# Init Prolog
prolog = Prolog()
try:
    prolog.consult("backend/knowledge.pl") # Path relative to CWD (root)
except:
    try:
        prolog.consult("knowledge.pl") # Fallback if running from backend dir
    except Exception as e:
        print(f"Error loading Prolog knowledge base: {e}")

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_message = data.get('message', '').strip().lower()
    
    # Normalisation pour gérer les accents et variations
    import unicodedata
    def normalize_text(text):
        """Normalise le texte en retirant les accents et en gérant les variations courantes"""
        # Retirer les accents
        text = ''.join(c for c in unicodedata.normalize('NFD', text) if unicodedata.category(c) != 'Mn')
        # Remplacements courants
        replacements = {
            'medcine': 'medecine',
            'ingenerie': 'ingenierie',
            'ingenieurie': 'ingenierie',
            'informatik': 'informatique',
            'economie': 'eco',
            'litteraire': 'litt',
            'debouche': 'debouches',
            'debouches': 'debouches',
            'metier': 'metiers',
            'metiers': 'metiers',
            'ecole': 'ecoles',
            'ecoles': 'ecoles',
        }
        for old, new in replacements.items():
            text = text.replace(old, new)
        return text
    
    # Normaliser le message utilisateur
    user_message_normalized = normalize_text(user_message)
    
    response_text = "Je n'ai pas compris. Posez une question sur l'orientation (ex: 'Que faire avec un Bac PC ?', 'Conseils révision', 'Médecine avec 11 ?')."

    # Helper pour l'encodage (PySwip retourne parfois du Mojibake)
    def clean_text(text):
        if not isinstance(text, str): return str(text)
        cleaned = text
        # 1. Essayer réparation automatique (Magic Encoding)
        try:
            cleaned = text.encode('cp1252').decode('utf-8')
        except (UnicodeDecodeError, UnicodeEncodeError):
            try:
                cleaned = text.encode('latin-1').decode('utf-8')
            except (UnicodeDecodeError, UnicodeEncodeError):
                pass
        
        # 2. Réparation Manuelle (Fallback si Magic échoue à cause des Emojis)
        # Les emojis font planter l'encode('latin-1'), donc le texte reste cassé (ex: Ã©).
        # On force le remplacement des séquences UTF-8 interprétées en Latin-1.
        replacements = {
            'Ã©': 'é', 'Ã¨': 'è', 'Ã ': 'à', 'Ã¢': 'â', 'Ãª': 'ê', 'Ã®': 'î', 'Ã´': 'ô', 
            'Ã»': 'û', 'Ã¹': 'ù', 'Ã§': 'ç', 'â€™': "'", 'Å“': 'œ', 'â‚¬': '€',
            'Ã\xa0': 'à', 'Ã«': 'ë', 'Ã¯': 'ï'
        }
        for bad, good in replacements.items():
            cleaned = cleaned.replace(bad, good)
            
        # Nettoyage final des artefacts Prolog (guillemets, virgules au début/fin)
        return cleaned.strip().strip("'").strip('"').strip(',').strip()

    try:
        # --- ABBREVIATIONS & MOTS COURTS (Très Haute Priorité) ---
        # CV / Curriculum
        if user_message in ['cv', 'c v', 'curriculum']:
            return jsonify({"response": "Pour créer un bon CV étudiant :\n\n📝 **Sections essentielles** :\n- Informations personnelles\n- Formation (Bac, mention)\n- Compétences (langues, informatique)\n- Expériences (stages, projets)\n- Centres d'intérêt\n\n💡 **Conseils** :\n- 1 page maximum\n- Police professionnelle\n- Pas de photo (sauf demandé)\n- Mettre en avant les projets académiques\n\nBesoin d'aide pour une section spécifique ?"})
        
        # Abréviations écoles
        if user_message in ['ensa', 'e n s a']:
            return jsonify({"response": "🏫 **ENSA** (École Nationale des Sciences Appliquées)\n\nÉcoles d'ingénieurs publiques au Maroc.\n\n📍 **Villes** : Rabat, Casa, Fès, Marrakech, Tanger, Safi, Khouribga, El Jadida, Tétouan, Oujda, Agadir, Kenitra.\n\n✅ **Admission** : Bac PC/SM avec bonne moyenne (13-15+)\n💰 **Frais** : Gratuit (public)\n\nPosez une question plus précise (ex: 'ENSA Safi', 'Admission ENSA')"})
        
        if user_message in ['emsi', 'e m s i']:
            return jsonify({"response": "🏫 **EMSI** (École Marocaine des Sciences de l'Ingénieur)\n\nÉcole privée d'ingénierie et IT.\n\n📍 **Villes** : Rabat, Casa, Marrakech, Tanger\n💰 **Frais** : ~45 000 - 55 000 DH/an\n✅ **Filières** : Informatique, Réseaux, Data Science, Génie Civil\n\nPosez une question plus précise !"})
        
        # Langues courtes
        if user_message in ['fr', 'français', 'francais']:
            return jsonify({"response": "🇫🇷 **Études en Français**\n\nLe français est la langue principale pour :\n✅ Sciences et techniques\n✅ Médecine\n✅ Ingénierie\n✅ Commerce\n\nRecommandé si niveau ≥ B2.\n\nPosez 'Langue français' pour plus de détails."})
        
        if user_message in ['en', 'anglais', 'english']:
            return jsonify({"response": "🇬🇧 **Études en Anglais**\n\nL'anglais est utilisé pour :\n✅ IT et Data Science\n✅ Business international\n✅ Programmes internationaux\n\nNiveau B2/C1 requis.\n\nPosez 'Langue anglais' pour plus de détails."})
        
        if user_message in ['ar', 'arabe']:
            return jsonify({"response": "🇲🇦 **Études en Arabe**\n\nL'arabe est utilisé pour :\n✅ Lettres et sciences humaines\n✅ Droit national\n✅ Sciences islamiques\n\nPosez 'Langue arabe' pour plus de détails."})

        # --- SALUTATIONS MULTILINGUES (Priorité Haute) ---
        # Français
        if user_message in ['bonjour', 'bjr', 'bonsoir', 'bsr']:
            greetings = [
                "Bonjour ! 👋 Comment puis-je vous aider avec votre orientation ?",
                "Bonjour ! 🎓 Posez-moi vos questions sur l'orientation post-bac.",
                "Bonsoir ! Comment s'est passée votre journée ? Je suis là pour vous aider."
            ]
            return jsonify({"response": random.choice(greetings)})
        
        if user_message in ['salut', 'slt', 'coucou', 'cc']:
             return jsonify({"response": "Salut ! 👋 Ça va ? Besoin d'aide pour ton orientation ?"})
        
        if user_message in ['ca va', 'ça va', 'comment ca va', 'comment ça va', 'labas', 'kidayr']:
             return jsonify({"response": "Je vais très bien, merci ! 🤖 Toujours prêt pour vous orienter. Et vous ?"})
        
        if user_message in ['hey', 'yo']:
            return jsonify({"response": "Hey ! 😊 Quoi de neuf ? Des questions sur tes études ?"})
        
        if 'bonjour monsieur' in user_message or 'bonjour madame' in user_message:
            return jsonify({"response": "Bonjour Monsieur/Madame ! Comment puis-je vous aider aujourd'hui ?"})
        
        if 'bonjour professeur' in user_message:
            return jsonify({"response": "Bonjour Professeur ! 🎓"})
        
        # Darija (Arabe Marocain)
        if user_message in ['salam', 'salam alaykom', 'salam 3likom']:
            return jsonify({"response": "Salam ! 👋 Labas 3lik ? Kifach n9der n3awnek ?"})
        
        if 'sb7 lkhir' in user_message or 'sbah lkhir' in user_message:
            return jsonify({"response": "Sb7 lkhir ! ☀️ Labas ? Chno bghiti t3raf 3la l9raya ?"})
        
        if 'msa lkhir' in user_message or 'msa2 lkhir' in user_message:
            return jsonify({"response": "Msa lkhir ! 🌙 Kidayra nhark ? Wash 3andek chi so2al ?"})
        
        if 'choukran' in user_message or 'chokran' in user_message:
            return jsonify({"response": "Marhba bik ! 😊 Wakha ghir so2el."})
        
        # Anglais
        if user_message in ['hello', 'hi', 'hey there']:
            return jsonify({"response": "Hello! 👋 How can I help you with your studies today?"})
        
        if 'good morning' in user_message:
            return jsonify({"response": "Good morning! ☀️ How can I assist you?"})
        
        if 'good evening' in user_message:
            return jsonify({"response": "Good evening! 🌙 How's your day going?"})

        # --- QUESTIONS META SUR LE CHATBOT ---
        # YAFI Definition (TRES HAUTE PRIORITE)
        if any(keyword in user_message for keyword in ['yafi', 'y.a.f.i', 'y a f i']):
            return jsonify({"response": "✨ **YAFI** est un acronyme formé à partir des prénoms des créateurs du projet :\n\n👤 **Y** → Yasser\n👤 **A** → Adam\n👤 **F** → Fahd\n🧠 **I** → Intelligence\n\n👉 **I = Intelligence**, en référence à :\n- 🤖 L'intelligence artificielle\n- 🧭 L'intelligence d'orientation\n- 💡 L'aide intelligente à la décision post-bac"})

        # Identité et rôle
        if any(keyword in user_message for keyword in ['qui es-tu', 'qui es tu', 'quel est ton role', 'quel est ton roll', 'ton role', 'ton roll', 'tu fais quoi', 'ton but', 'c\'est quoi ce bot', 'c\'est quoi ce site', 'c\'est quoi cette app']):
            return jsonify({"response": "Je suis un chatbot d'orientation post-bac pour les étudiants marocains ! 🎓\n\nMon rôle est de vous aider à :\n✅ Choisir votre filière selon votre Bac\n✅ Trouver les bonnes écoles (publiques/privées)\n✅ Comprendre les stratégies d'admission\n\n💡 **Bon à savoir** : Vous pouvez m'écrire **sans accents** et sans vous soucier des caractères complexes (ex: 'medecine', 'ingenieur'). Je vous comprendrai parfaitement !"})
        
        # Créateur
        if any(keyword in user_message for keyword in ['qui t\'a cree', 'qui t\'a créé', 'qui a cree', 'qui a créé', 'adam moufrije', 'ton createur', 'ton créateur', 'le createur', 'le créateur', 'son createur', 'son créateur', 'qui t a fait', 'qui t\'a fait', 'ton developpeur', 'ton développeur', 'qui a developpe', 'qui a développé']):
            return jsonify({"response": "👨‍💻 Le créateur et développeur de ce modèle et de la base de connaissances est **Adam Moufrije**.\n\n🚀 Ce projet a été réalisé avec le soutien de différents **LLMs** (Large Language Models) pour aider à la création et au développement du système."})
        
        # Nature (AI/Bot)
        if any(keyword in user_message for keyword in ['tu es un ai', 'tu est un ai', 'tu es une ia', 'tu est une ia', 'es-tu un robot', 'es-tu un bot', 'est-tu un robot', 'chatbot', 'robot']):
            return jsonify({"response": "Oui, je suis un chatbot intelligent (IA) ! 🤖\n\nJe combine :\n- **Prolog** pour la logique d'orientation\n- **Python** pour le traitement\n- **React** pour l'interface\n\nJe suis spécialisé dans l'orientation post-bac au Maroc. Posez-moi vos questions !"})
        
        # Remerciements / Feedback
        if any(keyword in user_message for keyword in ['merci', 'thank you', 'thanks', 'شكرا']):
            return jsonify({"response": "De rien ! 😊 Je suis là pour vous aider.\n\nN'hésitez pas si vous avez d'autres questions sur votre orientation ! 🎓"})
        
        # Plaintes / Erreurs
        if any(keyword in user_message for keyword in ['arret', 'arrête', 'stop', 'meme reponse', 'même réponse', 'bug', 'erreur']):
            return jsonify({"response": "Désolé si ma réponse n'était pas claire ! 😅\n\nEssayez de reformuler votre question de manière plus précise, par exemple :\n- 'Que faire avec un Bac PC ?'\n- 'Médecine avec 13 de moyenne'\n- 'Prix EMSI'\n- 'Débouchés informatique'\n\nJe suis là pour vous aider ! 💪"})

        # --- 4. INFOS PRATIQUES (Prioritaire) ---
        
        # 4.1. Seuils & Dates
        if "seuil" in user_message or "date" in user_message or ("quand" in user_message and ("concours" in user_message or "inscription" in user_message)):
             keywords_map = {
                 'ensa': 'Concours ENSA', 'encg': 'Concours ENCG (TAFEM)', 'medecine': 'Concours Medecine', 'médecine': 'Concours Medecine',
                 'fst': 'Inscription CursusSup', 'est': 'Inscription CursusSup', 'cursussup': 'Inscription CursusSup', 'ofppt': 'Inscription OFPPT',
                 'bac': 'Resultats Bac'
             }
             found = None
             for k, v in keywords_map.items():
                 if k in user_message: found = v; break
            
             if found:
                 q_date = f"get_date_concours('{found}', D)"
                 res_d = list(prolog.query(q_date))
                 date_txt = clean_text(res_d[0]['D']) if res_d else "Non défini"
                 
                 seuil_txt = ""
                 if "ENSA" in found: school="ENSA"
                 elif "ENCG" in found: school="ENCG"
                 elif "Medecine" in found: school="Medecine"
                 elif "FST" in user_message.upper(): school="FST"
                 elif "EST" in user_message.upper(): school="EST"
                 else: school=None
                 
                 if school:
                     q_seuil = f"get_seuil('{school}', 2023, N)"
                     res_s = list(prolog.query(q_seuil))
                     if res_s: seuil_txt = f"\\n📉 **Seuil 2023** : {clean_text(res_s[0]['N'])}/20"
                 
                 return jsonify({"response": f"📅 **{found}** :\\n🗓️ **Date** : {date_txt}{seuil_txt}"})
             else:
                 return jsonify({"response": "📅 **Calendrier** : Je connais les dates pour ENSA, ENCG, Médecine, CursusSup..."})

        # 4.2. Liens & Sites
        if "lien" in user_message or "site" in user_message or "adresse" in user_message:
             keys = {'cursussup': 'CursusSup', 'minhaty': 'Minhaty (Bourse)', 'ensa': 'ENSA Maroc', 'tafem': 'TAFEM (ENCG)', 'ofppt': 'OFPPT'}
             found = None
             for k, v in keys.items():
                 if k in user_message: found = v; break
             
             if found:
                 q = f"get_lien('{found}', U)"
                 res = list(prolog.query(q))
                 url = clean_text(res[0]['U']) if res else "#"
                 return jsonify({"response": f"🔗 **Lien {found}** : [Cliquez ici]({url})"})
             else:
                 return jsonify({"response": "🔗 **Liens Utiles** : Demandez-moi CursusSup, Minhaty, ENSA..."})

        # 4.3. Procédures & Logement
        if "démarche" in user_message or "procédure" in user_message or "dossier" in user_message or "inscription" in user_message or "s'inscrire" in user_message or "papier" in user_message or "document" in user_message or "logement" in user_message or "cité" in user_message or "internat" in user_message:
            # Check Logement
            if "logement" in user_message or "cité" in user_message or "internat" in user_message:
                type_log = 'Cite Universitaire'
                if "privé" in user_message or "location" in user_message: type_log = 'Location Privee'
                elif "internat" in user_message: type_log = 'Internat'
                
                q = f"get_logement('{type_log}', D, C)"
                res = list(prolog.query(q))
                if res:
                     return jsonify({"response": f"🏠 **{type_log}** :\\nℹ️ {clean_text(res[0]['D'])}\\n💡 {clean_text(res[0]['C'])}"})
                else:
                     return jsonify({"response": "🏠 **Logement** : Précisez Cité, Internat ou Location."})
            else:
                # Procédures
                proc = 'Inscription Fac' # Default
                if "minhaty" in user_message or "bourse" in user_message: proc = 'Dossier Minhaty'
                elif "legalis" in user_message: proc = 'Legalisation'
                
                q = f"get_procedure('{proc}', D)"
                res = list(prolog.query(q))
                if res:
                     return jsonify({"response": f"📝 **Procédure {proc}** :\\n{clean_text(res[0]['D'])}"})

        # 4.4. OFPPT
        if "ofppt" in user_message or "technicien" in user_message or "ista" in user_message:
             niveau = 'Technicien Specialise'
             if "qualif" in user_message: niveau = 'Qualification'
             elif "technicien" in user_message and "spécialisé" not in user_message: niveau = 'Technicien'
             
             q = f"get_formation_pro('{niveau}', D, C)"
             res = list(prolog.query(q))
             if res:
                  return jsonify({"response": f"🏭 **OFPPT ({niveau})** :\\nℹ️ {clean_text(res[0]['D'])}\\n💡 {clean_text(res[0]['C'])}"})

        # 4.5. Calculateur de Note
        if "calcul" in user_message or "moyenne" in user_message or "score" in user_message:
             import re
             nums = re.findall(r'\d+(?:[.,]\d+)?', user_message)
             nums = [float(n.replace(',', '.')) for n in nums]
             
             if len(nums) >= 2:
                  reg = nums[0]
                  nat = nums[1]
                  if reg <= 20 and nat <= 20:
                      score = (reg * 0.25) + (nat * 0.75)
                      resp = f"🧮 **Calculateur de Seuil** :\\n- Régional (25%) : {reg}\\n- National (75%) : {nat}\\n\\n✨ **Votre Score d'Admission : {score:.2f}/20**\\n"
                      
                      if score >= 15: resp += "🌟 Excellent ! Vous êtes bien parti pour Médecine/ENSA."
                      elif score >= 12: resp += "✅ Bon score. FST et EST sont très jouables. ENSA possible (vérifiez seuils)."
                      else: resp += "⚠️ Un peu juste pour les filières sélectives. Visez EST, BTS ou Fac."
                      return jsonify({"response": resp})
                  else:
                      return jsonify({"response": "⚠️ Les notes doivent être sur 20."})
             else:
                  return jsonify({"response": "🧮 **Calculateur** : Donnez-moi vos notes Régional et National (ex: 'Calcul 14 16') pour avoir votre score."})

        # 4.6. Quiz Orientation
        if "quiz" in user_message or "aime" in user_message or "préfère" in user_message or "fort en" in user_message:
             scores = {'ingenierie': 0, 'medecine': 0, 'commerce': 0, 'lettres': 0, 'art': 0}
             
             if "math" in user_message: scores['ingenierie'] += 2; scores['commerce'] += 1
             if "physique" in user_message: scores['ingenierie'] += 2
             if "svt" in user_message or "bio" in user_message: scores['medecine'] += 3
             if "info" in user_message or "cod" in user_message: scores['ingenierie'] += 2
             if "eco" in user_message or "gest" in user_message: scores['commerce'] += 3
             if "langue" in user_message or "fran" in user_message: scores['lettres'] += 2; scores['commerce'] += 1
             if "dessin" in user_message or "art" in user_message: scores['art'] += 3; scores['ingenierie'] += 1
             
             best = max(scores, key=scores.get)
             resp = "🧠 **Quiz Orientation** :\\n"
             if scores[best] > 0:
                 if best == 'ingenierie': rec = "Vous semblez avoir un profil **Ingénieur / Tech** ! 🛠️\\n👉 Visez ENSA, CPGE, FST, EST."
                 elif best == 'medecine': rec = "Vous avez un profil **Santé / Bio** ! 🩺\\n👉 Visez Médecine, Pharmacie, ISPITS."
                 elif best == 'commerce': rec = "Vous avez un profil **Manager / Eco** ! 💼\\n👉 Visez ENCG, ISCAE, EST."
                 elif best == 'lettres': rec = "Vous avez un profil **Littéraire / Droit** ! 📚\\n👉 Visez Fac de Droit, Lettres, Journalisme."
                 elif best == 'art': rec = "Vous avez un profil **Créatif / Archi** ! 🎨\\n👉 Visez ENA (Archi), Beaux-Arts ou Design."
                 
                 resp += rec + "\\n\\n(Dites 'Détail Ingénieur' pour en savoir plus)"
             else:
                 resp += "Dites-moi quelles matières vous aimez (Maths, SVT, Eco, Langues...) pour que je vous oriente !"
             return jsonify({"response": resp})
        
        # Critiques / Insultes (réponse calme)
        if any(keyword in user_message for keyword in ['nul', 'null', 'mauvais', 'pas bon', 'debile', 'bête', 'idiot']):
            return jsonify({"response": "Je suis désolé si je n'ai pas répondu à vos attentes. 😔\n\nPour mieux vous aider, posez une question précise comme :\n- 'Bac PC que faire ?'\n- 'Prix école privée'\n- 'Conseils révision'\n\nJe ferai de mon mieux ! 💪"})

        # --- 1. STATISTIQUES & CHIFFRES (Priorité Haute) ---
        if "place" in user_message or "combien" in user_message or "nombre" in user_message or "stat" in user_message or "chance" in user_message or "monde" in user_message:
            
            keywords = ['médecine', 'ensa', 'encg', 'ensam', 'fst', 'global', 'casa', 'rabat', 'agadir', 'salaire']
            found_key = next((k for k in keywords if k in user_message), None)
            
            if found_key:
                stats = list(prolog.query("stat(Cat, Entite, Val)"))
                matches = []
                for s in stats:
                    if found_key.lower() in str(s['Entite']).lower():
                        matches.append(s)
                
                if matches:
                     response_text = f"📊 **Statistiques pour '{found_key.capitalize()}' :**\n"
                     for m in matches:
                         val_clean = clean_text(m['Val'])
                         cat_clean = clean_text(m['Cat'])
                         entite_clean = clean_text(m['Entite'])
                         response_text += f"- {cat_clean} ({entite_clean}) : **{val_clean}**\n"
                else:
                    response_text = f"Je n'ai pas de chiffre précis pour '{found_key}'."
            else:
                 response_text = "📊 **Le Saviez-vous ?**\n- Il y a 1.25 million d'étudiants au Maroc.\n- La sélectivité est rude : 1 place pour 22 candidats en Médecine !"

        # --- 2. GEOGRAPHIE & VILLES (Priorité Haute) ---
        elif ("où" in user_message or "ville" in user_message or "trouve" in user_message or "localisation" in user_message or "campus" in user_message or "école" in user_message or "ecole" in user_message or "université" in user_message or any(v in user_message for v in ['rabat', 'casa', 'marrakech', 'agadir', 'fès', 'meknès', 'tanger', 'oujda', 'safi', 'khouribga', 'el jadida', 'tetouan'])) and not "avantage" in user_message and not "inconvénient" in user_message:
            
            # Cas 1 : User cherche où se trouve une école (ex: "Où est l'ENSA ?")
            ecoles_cles = ['ensa', 'ensam', 'ensias', 'encg', 'fst', 'est', 'um6p', 'universite', 'emsi', 'uir', 'hem']
            ecole_demandee = next((e for e in ecoles_cles if e in user_message), None)
            
            # On distingue "Où est ecole" de "Ecoles à Ville"
            # Si on a un nom de ville explicite, on priorise la recherche par ville
            villes_cles = ['rabat', 'casa', 'marrakech', 'agadir', 'fès', 'meknès', 'tanger', 'oujda', 'safi', 'khouribga', 'beni mellal', 'el jadida', 'taza', 'errachidia']
            ville_demandee = next((v for v in villes_cles if v in user_message), None)

            if ville_demandee and not ("où est" in user_message):
                 # Cas 2 : User demande ce qu'il y a dans une VILLE
                 locs = list(prolog.query("localisation(Ecole, Ville)"))
                 found_ecoles = []
                 for l in locs:
                     ville_p = clean_text(l['Ville'])
                     if ville_demandee.lower() in ville_p.lower():
                          found_ecoles.append(clean_text(l['Ecole']))
                 
                 chance_msg = ""
                 chances = list(prolog.query("ville_chance(V)"))
                 for c in chances:
                     vc = clean_text(c['V'])
                     if ville_demandee.lower() in vc.lower():
                         chance_msg = "\n✅ **Note:** Ville 'Opportunité' (Moins de concurrence, bon plan !)."

                 if found_ecoles:
                     response_text = f"🏫 À **{ville_demandee.capitalize()}**, vous trouverez :\n" + "\n".join([f"- {e}" for e in set(found_ecoles)]) + chance_msg
                 else:
                     response_text = f"Je n'ai pas d'info spécifique sur les écoles à {ville_demandee}."
            
            elif ecole_demandee:
                ecole_upper = ecole_demandee.upper()
                if ecole_demandee == 'universite': ecole_upper = 'Université'
                
                locs = list(prolog.query("localisation(Ecole, Ville)"))
                found_villes = []
                
                for l in locs:
                    if ecole_demandee.lower() in str(l['Ecole']).lower():
                        found_villes.append(clean_text(l['Ville']))
                
                if found_villes:
                    unique_villes = sorted(list(set(found_villes)))
                    response_text = f"📍 **{ecole_demandee.upper()}** est présent à :\n" + ", ".join(unique_villes)
                else:
                    response_text = f"Désolé, je ne trouve pas la localisation pour '{ecole_demandee}'."
            else:
                 response_text = "🌍 Je peux vous dire où se trouvent les écoles ou ce qu'il y a dans votre ville."


        # --- 3. STRATEGIE & TYPES ETABLISSEMENTS ---
        # --- 3. STRATEGIE & TYPES ETABLISSEMENTS ---
        elif "stratégie" in user_message or "avantage" in user_message or "inconvénient" in user_message or "ouvert" in user_message or "régulé" in user_message or "type" in user_message:
             
             # A. PROS / CONS Types
             types_map = {
                 'public_ouvert': ['fac', 'ouverte', 'ouvert', 'université', 'droit', 'eco', 'sans sélection', 'open', 'public', 'publique'],
                 'public_regule': ['régulée', 'régulé', 'regule', 'ensa', 'médecine', 'prepa', 'concours', 'public sélectif'],
                 'prive': ['privé', 'prive', 'payant', 'supinfo', 'uir', 'emsi', 'ecole payante']
             }
             found_type = next((k for k, v in types_map.items() if any(sub in user_message for sub in v)), None)
            
             # Priorité aux questions sur les avantages/inconvénients ou définitions de types
             if ("avantage" in user_message or "inconvénient" in user_message or "c'est quoi" in user_message or "type" in user_message) and found_type:
                  # Note: found_type is now an atom string like 'public_ouvert'
                  q = f"get_info_type({found_type}, Desc, Av, Inc)"
                  res = list(prolog.query(q))
                  if res:
                      r = res[0]
                      # Clean type name for display
                      display_name = found_type.replace('_', ' ').replace('regule', 'régulé').title()
                      response_text = f"🏫 **{display_name}** :\n📌 {clean_text(r['Desc'])}\n{clean_text(r['Av'])}\n{clean_text(r['Inc'])}"
                  else:
                      response_text = f"Je n'ai pas d'infos détaillées sur le type '{found_type}'."

             # B. STRATEGIE PERSO (Note + Bac ?)
             elif "stratégie" in user_message or "conseil" in user_message:
                 import re
                 match = re.search(r'\b(1[0-9]|20|[0-9])(\.[0-9]+)?\b', user_message) # Float support
                 
                 if match:
                     note = float(match.group(0))
                     
                     # Detect Bac
                     bac = 'SVT' # Default
                     if 'pc' in user_message: bac = 'PC'
                     elif 'sm' in user_message: bac = 'SM'
                     elif 'eco' in user_message: bac = 'ECO'
                     
                     q = f"strategie_profil({note}, '{bac}', Conseil)"
                     res = list(prolog.query(q))
                     if res:
                         response_text = f"🎯 **Stratégie Orientation ({note}/20 - Bac {bac})** :\n{clean_text(res[0]['Conseil'])}"
                     else:
                         response_text = "Pas de conseil spécifique pour ce cas exact."
                 else:
                     if "stratégie" in user_message:
                        response_text = "Pour une stratégie personnalisée, donnez-moi votre moyenne (ex: 'Stratégie avec 14')."
                     else:
                        # Fallback to generic conseil if no note
                        pass # Let it fall through to generic Conseil block?
                        # No, if we are in this ELIF, we are trapped. 
                        # We must provide response OR use 'continue' logic which Flask doesn't have easily.
                        # So I should handle "Conseil" without note here or return "Je ne sais pas".
                        # But "Conseil" general is handled below. 
                        # I should only trap "Strategy" here.
                        response_text = "Pour une stratégie personnalisée, donnez-moi votre moyenne (ex: 'Stratégie avec 14')."

             if not response_text: # Fallback if B failed to produce text (e.g. "conseil" matched but no note)
                  # If we captured "conseil" here but didn't have a note, we might want to let the Generic Conseil block handle it.
                  # But we can't 'break' to next elif.
                  # So I strictly limit B to "stratégie".
                  pass 
             
             # Re-refining B condition:
             # Only trap if "stratégie" is present.
             # If "conseil", let it go to Generic Conseil block?
             # But "stratégie" keywords triggered the outer block.
             # So we must handle it.
             
             if not ('response_text' in locals() and response_text):
                 response_text = "Je peux comparer les filières (Ouvertes vs Régulées) ou vous donner une stratégie selon votre note."
        
        # --- 6. ECOLES PRIVEES & FRAIS & PUBLIC (Prix) ---
        elif "prix" in user_message or "frais" in user_message or "coût" in user_message or "payer" in user_message or "privé" in user_message or "gratuit" in user_message or "emsi" in user_message or "uir" in user_message or "hem" in user_message or "esca" in user_message or ("ensa" in user_message and ("frais" in user_message or "prix" in user_message or "gratuit" in user_message)):
             
             # A. Check Ecoles Publiques (Gratuites)
             ecoles_publiques = ['ensa', 'ensam', 'ensias', 'encg', 'fst', 'est', 'universite', 'faculté', 'médecine']
             public_found = next((e for e in ecoles_publiques if e in user_message), None)
             
             # B. Check Ecoles Privées
             ecoles_privees = ['emsi', 'uir', 'supinfo', 'emg', 'hem', 'esca', 'uiass', 'upsat', 'isitt']
             priv_found = next((e for e in ecoles_privees if e in user_message), None)

             if public_found and not priv_found:
                 response_text = f"🏛️ **{public_found.upper()}** est un établissement **Public**.\n✅ **Les frais de scolarité sont GRATUITS** (0 DH).\nIl faut juste payer les frais d'inscription annuels (~200 DH) et l'assurance."

             elif priv_found:
                 # Limitation: Ne pas repondre aux questions "Qui est le directeur" avec les frais
                 if "directeur" in user_message or "président" in user_message:
                     response_text = f"Je n'ai pas l'information sur le directeur de {priv_found.upper()}. Je peux par contre vous donner les frais et spécialités."
                 else:
                     details = list(prolog.query("detail_ecole(Nom, Cat, Spec, Frais)"))
                     match = next((d for d in details if priv_found.lower() in str(d['Nom']).lower()), None)
                     
                     if match:
                         response_text = f"💎 **{clean_text(match['Nom'])}** ({clean_text(match['Cat'])})\n"
                         response_text += f"- 💰 **Frais**: {clean_text(match['Frais'])}\n"
                         response_text += f"- 🎓 **Spécialités**: {clean_text(match['Spec'])}\n"
                     else:
                         response_text = f"Détails financiers non trouvés pour {priv_found}."
             else:
                 response_text = "💰 **Enseignement Privé** : EMSI (~35k/an), UIR (~80k/an), Medecine Privée (~100k/an)...\n🏛️ **Public** : Gratuit."

        # --- 4. DEFINITIONS & SYSTEME ---
        elif "c'est quoi" in user_message or "système" in user_message or "diplôme" in user_message or "lmd" in user_message or "master" in user_message or "licence" in user_message or "doctorat" in user_message or "bts" in user_message or "dut" in user_message or "cpge" in user_message:
            
            termes = ['lmd', 'licence', 'master', 'doctorat', 'bts', 'dut', 'ingénieur', 'cpge']
            terme_found = next((t for t in termes if t in user_message), None)
            
            if terme_found:
                defs = list(prolog.query("definition(Terme, Def)"))
                match = next((d for d in defs if terme_found.lower() in str(d['Terme']).lower()), None)
                
                if match:
                    response_text = f"📖 **{clean_text(match['Terme'])}** :\n{clean_text(match['Def'])}"
                else:
                    response_text = f"Définition non trouvée pour {terme_found}."
            else:
                 response_text = "📚 **Système LMD** : Licence (3 ans), Master (5 ans), Doctorat (8 ans)."

        # --- 5. MEDECINE (Test de note & Compatibilité) ---
        elif "médecine" in user_message or "medecine" in user_message:
            # A. Check Incompatibilité BAC
            if "bac eco" in user_message or "bac éco" in user_message or "bac techniques" in user_message:
                response_text = "⛔ **Orientation Impossible** : Les études de Médecine ne sont pas accessibles avec un Bac Economie ou Technique. Il faut un Bac Scientifique (SVT, PC, SM)."
            
            # B. Check Simulation vs Conseil
            else:
                import re
                match = re.search(r'\b(1[0-9]|20|[0-9])\b', user_message)
                
                if not match and ("conseil" in user_message or "comment" in user_message):
                     response_text = "💡 **Conseil Médecine** : C'est un cursus long (7 ans min). La sélection se fait sur note du Bac (Moyenne > 12 pour le concours) + Concours écrit. Préparez-vous dès le début de l'année !"
                
                else:
                    user_note = float(match.group(1)) if match else 12.0
                    mon_bac = 'SVT' 
                    if 'pc' in user_message: mon_bac = 'PC'
                    if 'sm' in user_message: mon_bac = 'SM'
        
                    q = f"peut_faire_medecine('{mon_bac}', {user_note}, Resultat)"
                    res = list(prolog.query(q))
                    if res:
                        verdict = clean_text(res[0]['Resultat'])
                        response_text = f"🩺 Pour Médecine (Bac {mon_bac}, Moyenne {user_note}):\n👉 **{verdict}**"














        # --- 6.1 STAGES & EXPERIENCES PRATIQUES ---
        elif "stage" in user_message or "stages" in user_message or "pratique" in user_message or "expérience" in user_message or "pfe" in user_message or "projet" in user_message:
            
            # Map keywords to fields
            stages_map = {
                'medecine': ['médecine', 'medecine', 'pharmacie', 'dentaire', 'santé'],
                'ingenierie': ['ingénierie', 'ingenieur', 'ensa', 'emi', 'technique'],
                'informatique': ['informatique', 'info', 'it', 'data', 'cyber', 'dev'],
                'commerce': ['commerce', 'gestion', 'finance', 'marketing', 'business'],
                'shs': ['sciences humaines', 'psycho', 'socio', 'lettres'],
                'arts': ['arts', 'design', 'architecture', 'créatif'],
                'tourisme': ['tourisme', 'hôtel', 'logistique']
            }
            
            found_stage = None
            for stage_key, keywords in stages_map.items():
                if any(k in user_message for k in keywords):
                    found_stage = stage_key
                    break
            
            if found_stage:
                # Query specific field
                q = f"get_stages_filiere({found_stage}, S, A)"
                res = list(prolog.query(q))
                
                if res:
                    r = res[0]
                    display_name = found_stage.capitalize()
                    if found_stage == 'medecine': display_name = 'Médecine'
                    elif found_stage == 'ingenierie': display_name = 'Ingénierie'
                    elif found_stage == 'shs': display_name = 'Sciences Humaines'
                    
                    response_text = f"🎓 **Stages & Pratique - {display_name}** :\n"
                    response_text += f"📋 {clean_text(r['S'])}\n"
                    response_text += f"{clean_text(r['A'])}\n"
                else:
                    response_text = f"Je n'ai pas d'infos sur les stages en '{found_stage}'."
            else:
                # General advice
                response_text = "🎓 **Stages & Expériences** :\n"
                response_text += "Les stages sont essentiels dans toutes les filières.\n"
                response_text += "- Vérifie que ton école intègre des stages obligatoires\n"
                response_text += "- Planifie dès la 1ʳᵉ année pour max d'expérience\n"
                response_text += "Précisez une filière pour détails spécifiques."


        # --- 6.2 DUREE ETUDES (Courtes vs Longues) ---
        elif "études courtes" in user_message or "etudes courtes" in user_message or "études longues" in user_message or "etudes longues" in user_message or ("courte" in user_message and "longue" in user_message) or "bts" in user_message or "dut" in user_message or "combien d'années" in user_message or "durée" in user_message or "duree" in user_message:
            
            # Detect which type
            if "courte" in user_message or "bts" in user_message or "dut" in user_message or "rapide" in user_message:
                found_duree = 'courtes'
            elif "longue" in user_message or "master" in user_message or "doctorat" in user_message:
                found_duree = 'longues'
            else:
                found_duree = None
            
            if found_duree:
                # Query specific duration type
                q = f"get_duree_etudes({found_duree}, D, A, I, C)"
                res = list(prolog.query(q))
                
                if res:
                    r = res[0]
                    display_name = "Études Courtes" if found_duree == 'courtes' else "Études Longues"
                    
                    response_text = f"⏱️ **{display_name}** :\n"
                    response_text += f"📌 {clean_text(r['D'])}\n"
                    response_text += f"{clean_text(r['A'])}\n"
                    response_text += f"{clean_text(r['I'])}\n"
                    response_text += f"{clean_text(r['C'])}\n"
                else:
                    response_text = f"Je n'ai pas d'infos sur les études '{found_duree}'."
            else:
                # General comparison
                response_text = "⏱️ **Durée des Études** :\n"
                response_text += "- **Courtes (2-3 ans)** : BTS, DUT, Licence → Insertion rapide\n"
                response_text += "- **Longues (5-8 ans)** : Ingénieur, Médecine, Master → Spécialisation\n"
                response_text += "Précisez 'courtes' ou 'longues' pour plus de détails."


        # --- 6.3 CONCOURS & EXAMENS D'ADMISSION (Nouveau) ---
        elif "concours" in user_message or "examen" in user_message or "admission" in user_message or "test" in user_message or "entretien" in user_message:
            
            # Map keywords to exam types
            concours_map = {
                'medecine': ['médecine', 'medecine', 'pharmacie', 'dentaire'],
                'ingenierie_public': ['ingénierie', 'ingenieur', 'ensa', 'emi', 'ensias', 'public'],
                'ecoles_privees': ['privé', 'prive', 'emsi', 'uir', 'um6p', 'hem'],
                'commerce': ['commerce', 'gestion', 'encg', 'iscae', 'esca', 'business']
            }
            
            found_concours = None
            for conc_key, keywords in concours_map.items():
                if any(k in user_message for k in keywords):
                    found_concours = conc_key
                    break
            
            if found_concours:
                # Query specific exam type
                q = f"get_concours_admission({found_concours}, E, C)"
                res = list(prolog.query(q))
                
                if res:
                    r = res[0]
                    display_name = found_concours.replace('_', ' ').title()
                    if found_concours == 'medecine': display_name = 'Médecine'
                    elif found_concours == 'ingenierie_public': display_name = 'Ingénierie (Public)'
                    elif found_concours == 'ecoles_privees': display_name = 'Écoles Privées'
                    
                    response_text = f"📝 **Concours {display_name}** :\n"
                    response_text += f"📋 {clean_text(r['E'])}\n"
                    response_text += f"{clean_text(r['C'])}\n"
                else:
                    response_text = f"Je n'ai pas d'infos sur les concours '{found_concours}'."
            else:
                # General exam advice
                response_text = "📝 **Concours & Admissions** :\n"
                response_text += "- **Médecine** : Dossier + concours écrit/oral\n"
                response_text += "- **Ingénierie** : Tests maths, physique, logique\n"
                response_text += "- **Privé** : Tests + entretien motivationnel\n"
                response_text += "- **Commerce** : Tests aptitude + étude de cas\n"
                response_text += "Précisez une filière pour plus de détails."

        # --- 6.4 CHOIX DE LANGUE (Nouveau) ---
        elif "langue" in user_message or "français" in user_message or "anglais" in user_message or "arabe" in user_message or "continuer en" in user_message:
            
            # Detect which language is being asked about
            langues_map = {
                'arabe': ['arabe', 'arabic', 'ar '],  # Space after 'ar' to avoid matching 'carrière'
                'francais': ['français', 'francais', 'french'],
                'anglais': ['anglais', 'english']
            }
            
            found_langue = None
            for lang_key, keywords in langues_map.items():
                if any(k in user_message for k in keywords):
                    found_langue = lang_key
                    break
            
            if found_langue:
                # Query specific language
                q = f"get_choix_langue({found_langue}, D, A, I, C)"
                res = list(prolog.query(q))
                
                if res:
                    r = res[0]
                    display_name = found_langue.capitalize()
                    if found_langue == 'francais': display_name = 'Français'
                    elif found_langue == 'anglais': display_name = 'Anglais'
                    
                    response_text = f"🌍 **Continuer en {display_name}** :\n"
                    response_text += f"📌 {clean_text(r['D'])}\n"
                    response_text += f"{clean_text(r['A'])}\n"
                    response_text += f"{clean_text(r['I'])}\n"
                    response_text += f"{clean_text(r['C'])}\n"
                else:
                    response_text = f"Je n'ai pas d'infos sur la langue '{found_langue}'."
            else:
                # General language advice
                response_text = "🌍 **Choix de Langue** :\n"
                response_text += "- **Français** : Sciences, Médecine, Ingénierie\n"
                response_text += "- **Anglais** : IT, Commerce International\n"
                response_text += "- **Arabe** : Lettres, Droit, Sciences Humaines\n"
                response_text += "Précisez une langue pour plus de détails."


        # --- 6.4.BIS FINANCEMENT & BOURSES (Nouveau) ---
        elif "bourse" in user_message or "financement" in user_message or "aide" in user_message or "prêt" in user_message or "logement" in user_message or "coût" in user_message or "payer" in user_message:
            # Note: "coût" et "payer" peuvent matcher Ecoles Privées (section 6), mais ici on capture les questions génériques ou spécifiques bourses
            
            # Map keywords
            financement_map = {
                'public': ['public', 'gratuit', 'fac'],
                'bourses_gouvernementales': ['bourse', 'minhaty', 'gouvernement'],
                'bourses_privees': ['privé', 'prive', 'fondation', 'mérite'],
                'international': ['étranger', 'etranger', 'erasmus', 'internationale'],
                'personnel': ['prêt', 'banque', 'travail', 'job']
            }
            
            found_fin = None
            for key, keywords in financement_map.items():
                if any(k in user_message for k in keywords):
                    found_fin = key
                    break
            
            # Default to bourses if just "bourse" is asked
            if not found_fin and "bourse" in user_message:
                found_fin = 'bourses_gouvernementales'

            if found_fin:
                q = f"get_financement({found_fin}, D, C)"
                res = list(prolog.query(q))
                if res:
                    r = res[0]
                    display_name = found_fin.replace('_', ' ').title()
                    response_text = f"💰 **Financement : {display_name}**\n📌 {clean_text(r['D'])}\n💡 {clean_text(r['C'])}"
                else: 
                     response_text = f"Pas d'info financement pour '{found_fin}'."
            else:
                 # Si on n'a pas détecté de type précis mais que le mot clé financement est là
                 # On ne fait rien si c'était "aide" (déjà géré par Vague) ou "coût" (géré par Ecoles)
                 # Sauf si on est ici, c'est que les sections précédentes n'ont pas matché (ordre important)
                 # On renvoie un conseil général
                 q = f"get_financement(bourses_gouvernementales, D, C)"
                 res = list(prolog.query(q))
                 if res:
                     r = res[0]
                     response_text = f"💰 **Bourses & Aides** :\nLa plupart des étudiants demandent **Minhaty**.\n📌 {clean_text(r['D'])}\n💡 Précisez 'bourse public', 'prêt' ou 'étranger' pour plus de détails."

        # --- 6.4.TER DEFINITIONS (Nouveau) ---
        elif "c'est quoi" in user_message or "définition" in user_message or "signifie" in user_message or "c est quoi" in user_message or "cest quoi" in user_message or "qu'est ce que" in user_message or "quest ce que" in user_message:
             
             def_map = {
                 'lmd': 'LMD', 'cpge': 'CPGE', 'prepa': 'CPGE', 'bts': 'BTS', 'dut': 'DUT',
                 'ensa': 'ENSA', 'encg': 'ENCG', 'est': 'EST', 'fst': 'FST', 'ofppt': 'OFPPT',
                 'master': 'Master', 'ingénieur': 'Ingénieur', 'ingenieur': 'Ingénieur'
             }
             
             import re
             found_key = None
             for k, v in def_map.items():
                 # Use regex for word boundary to avoid "est" matching "c'est"
                 if re.search(rf'\b{re.escape(k)}\b', user_message):
                     found_key = v
                     break
            
             if found_key:
                 q = f"definition('{found_key}', T)"
                 res = list(prolog.query(q))
                 if res:
                     response_text = f"📖 **Définition ({found_key})** :\n{clean_text(res[0]['T'])}"
                 else:
                     response_text = f"Je n'ai pas de définition pour '{found_key}'."
             else:
                 response_text = "📖 **Définitions** : Je peux définir LMD, CPGE, ENSA, ENCG, EST, FST, BTS, DUT..."

        # --- 6.5 DOMAINES & DEBOUCHES (Nouveau) ---
        elif "débouché" in user_message or "débouchés" in user_message or "métier" in user_message or "carrière" in user_message or "profession" in user_message or "travailler" in user_message:
            
            # Map keywords to domain atoms
            domaines_map = {
                'medecine': ['médecine', 'medecine', 'pharmacie', 'dentaire', 'santé', 'docteur'],
                'ingenierie': ['ingénierie', 'ingenieur', 'ensa', 'emi', 'génie'],
                'informatique': ['informatique', 'info', 'it', 'data', 'cyber', 'développeur', 'programmation'],
                'commerce': ['commerce', 'gestion', 'finance', 'marketing', 'business', 'encg'],
                'shs': ['sciences humaines', 'psycho', 'socio', 'journalisme', 'communication', 'lettres'],
                'archi': ['architecture', 'design', 'urbanisme', 'architecte'],
                'tourisme': ['tourisme', 'hôtel', 'logistique', 'événementiel']
            }
            
            found_domaine = None
            for dom_key, keywords in domaines_map.items():
                if any(k in user_message for k in keywords):
                    found_domaine = dom_key
                    break
            
            if found_domaine:
                # Query Prolog for domain details
                q = f"get_detail_domaine({found_domaine}, M, E, C)"
                res = list(prolog.query(q))
                
                if res:
                    r = res[0]
                    display_name = found_domaine.replace('_', ' ').title()
                    if found_domaine == 'medecine': display_name = 'Médecine & Santé'
                    elif found_domaine == 'ingenierie': display_name = 'Ingénierie'
                    elif found_domaine == 'informatique': display_name = 'Informatique & IT'
                    elif found_domaine == 'shs': display_name = 'Sciences Humaines & Sociales'
                    elif found_domaine == 'archi': display_name = 'Architecture & Design'
                    
                    response_text = f"💼 **{display_name}** :\n"
                    response_text += f"👔 **Métiers** : {clean_text(r['M'])}\n"
                    response_text += f"🏫 **Écoles** : {clean_text(r['E'])}\n"
                    response_text += f"{clean_text(r['C'])}\n"
                    
                    # NOUVEAU: Check compatibility if Bac is mentioned
                    bacs_keywords = {
                        'SM': ['sm', 'math'],
                        'PC': ['pc', 'physique'],
                        'SVT': ['svt', 'bio'],
                        'ECO': ['eco', 'economie'],
                        'LITT': ['litt', 'lettre']
                    }
                    detected_bac = None
                    for bac_code, keywords in bacs_keywords.items():
                        if any(k in user_message for k in keywords):
                            detected_bac = bac_code
                            break
                    
                    if detected_bac:
                        # Map domain to compatibility atom
                        compat_domain_map = {
                            'medecine': 'medecine',
                            'ingenierie': 'ingenierie',
                            'informatique': 'informatique',
                            'commerce': 'commerce',
                            'shs': 'lettres',  # SHS maps to lettres in compatibility
                            'arts': 'lettres',
                            'tourisme': 'commerce'
                        }
                        compat_atom = compat_domain_map.get(found_domaine, found_domaine)
                        
                        # Check compatibility
                        q_compat = f"check_compatibilite('{detected_bac}', {compat_atom}, Statut, Msg)"
                        compat_res = list(prolog.query(q_compat))
                        if compat_res:
                            response_text += f"\n\n🎯 **Compatibilité Bac {detected_bac}** :\n{clean_text(compat_res[0]['Msg'])}"
                
                else:
                    response_text = f"Je n'ai pas de détails sur le domaine '{found_domaine}'."
            else:
                response_text = "💼 **Débouchés** : Précisez un domaine (Médecine, Ingénierie, IT, Commerce, SHS, Architecture, Tourisme)."

        # --- 6.5 COMPATIBILITE BAC-FILIERE (Question type "SVT + informatique possible?") ---
        elif ("possible" in user_message or "peut" in user_message or "peux" in user_message or "compatible" in user_message or "difficile" in user_message or "veux faire" in user_message) and "bac" in user_message:
            # Détecter le BAC
            bacs_map = {
                'SM': ['sm', 'math', 'maths'],
                'PC': ['pc', 'physique'],
                'SVT': ['svt', 'bio'],
                'ECO': ['eco', 'economie'],
                'LITT': ['litt', 'lettre']
            }
            detected_bac = None
            for code, keywords in bacs_map.items():
                if any(k in user_message for k in keywords):
                    detected_bac = code
                    break
            
            # Détecter la Filière
            filieres_map = {
                'medecine': ['médecine', 'medecine', 'pharmacie', 'dentaire', 'santé'],
                'ingenierie': ['ingénierie', 'ingenieur', 'genie', 'technique', 'ensa'],
                'informatique': ['informatique', 'info', 'it', 'data', 'cyber', 'dev', 'programmation'],
                'commerce': ['commerce', 'gestion', 'finance', 'marketing', 'business', 'encg']
            }
            detected_filiere = None
            for fil_key, keywords in filieres_map.items():
                if any(k in user_message for k in keywords):
                    detected_filiere = fil_key
                    break
            
            if detected_bac and detected_filiere:
                # Requêter Prolog pour la compatibilité
                q_compat = f"check_compatibilite('{detected_bac}', {detected_filiere}, Statut, Msg)"
                compat_res = list(prolog.query(q_compat))
                
                if compat_res:
                    statut = clean_text(compat_res[0]['Statut'])
                    msg = clean_text(compat_res[0]['Msg'])
                    
                    # Ajouter un conseil supplémentaire selon le statut
                    if 'excellent' in statut:
                        conseil_sup = "\\n\\n👍 **Conseil** : Foncez ! Ce choix est parfaitement adapté à votre profil."
                    elif 'difficile' in statut or 'possible' in statut:
                        conseil_sup = "\\n\\n⚡ **Conseil** : C'est possible mais demande plus d'efforts ou une mise à niveau. Soyez réaliste sur vos capacités."
                    elif 'impossible' in statut:
                        conseil_sup = "\\n\\n🚫 **Conseil** : Choisissez une filière plus adaptée à votre Bac pour réussir."
                    else:
                        conseil_sup = ""
                    
                    response_text = f"🎯 **Compatibilité Bac {detected_bac} → {detected_filiere.capitalize()}**\\n\\n{msg}{conseil_sup}"
                else:
                    response_text = f"🎯 Pour Bac {detected_bac} vers {detected_filiere} : Je n'ai pas de données précises. Consultez un conseiller."
            elif detected_bac and not detected_filiere:
                response_text = "🎯 **Compatibilité** : Vous avez mentionné un Bac mais pas de filière spécifique. Précisez la filière (informatique, médecine, ingénierie, commerce...)."
            elif detected_filiere and not detected_bac:
                response_text = f"🎯 **Compatibilité {detected_filiere}** : Précisez votre type de Bac (PC, SM, SVT, Eco, Litt) pour un avis personnalisé."
            else:
                response_text = "🎯 **Compatibilité** : Précisez votre Bac ET la filière souhaitée (ex: 'Bac SVT vers informatique, possible ?')."

        # --- 7. ORIENTATION PAR BAC (Generic & Détaillé) ---
        elif "bac" in user_message or "recommander" in user_message or "faire" in user_message or "orientation" in user_message or "choisir" in user_message:
            # Ex: "bac pc", "bac sm"
            bacs_map = {
                'SM': ['sm', 'math', 'maths'],
                'PC': ['pc', 'physique', 'chimie'],
                'SVT': ['svt', 'science vie', 'bio'],
                'ECO': ['eco', 'agestion', 'economie', 'es'],
                'LITT': ['litt', 'lettre', 'humanité', 'homme']
            }
            
            user_bac = None
            for code, keywords in bacs_map.items():
                if any(k in user_message for k in keywords):
                    user_bac = code
                    break
            
            if user_bac:
                # 1. Chercher le Profil Détaillé
                q_detail = f"get_detail_bac('{user_bac}', I, A, L, C)"
                res_detail = list(prolog.query(q_detail))
                
                if res_detail:
                    d = res_detail[0]
                    response_text = f"🎓 **Profil BAC {user_bac}** :\n"
                    response_text += f"🌟 **Filières Idéales** : {clean_text(d['I'])}\n"
                    response_text += f"{clean_text(d['A'])}\n"
                    response_text += f"{clean_text(d['L'])}\n"
                    response_text += f"{clean_text(d['C'])}\n"
                
                # Check Note if present for nuance (Logic conservée)
                import re
                match_note = re.search(r'\b(1[0-9]|20|[0-9])\b', user_message)
                if match_note:
                    note = float(match_note.group(1))
                    if note >= 15: response_text += "\n🌟 **Note > 15 : Les portes de l'Excellence (Médecine, Prépa...) sont grandes ouvertes !**"
                    elif note < 12: response_text += "\n⚠️ **Note Juste : Assurez vos arrières avec des concours plus accessibles ou le privé.**"

                # 2. (Optionnel) Ajouter les recommandations spécifiques si le user a demandé "recommander" exmplicitement ? 
                # Le profil détaillé est déjà très riche. On garde la liste simple en complément si pas de détail trouvé?
                # Non, si on a trouvé le détail, c'est suffisant et mieux structuré.
                
                if not res_detail:
                     # Fallback Old Logic
                     q = f"recommander_orientation('{user_bac}', Domaine, Ecole)"
                     results = list(prolog.query(q))
                     if results:
                        response_text = f"🎓 Avec un **BAC {user_bac}**, voici des pistes :\n"
                        done = set()
                        for res in results:
                            d = clean_text(res['Domaine'])
                            e = clean_text(res['Ecole'])
                            line = f"- {d} (via {e})"
                            if line not in done:
                                response_text += line + "\n"
                                done.add(line)
            else:
                 response_text = "🎓 **Orientation** : Précisez votre Bac (PC, SM, SVT, Eco...) pour des conseils ciblés." 

        # --- 8. INFOS PRATIQUES & OUTILS (Nouveau) ---
        
        # 8.1. Seuils & Dates
        elif "seuil" in user_message or "date" in user_message or "quand" in user_message and ("concours" in user_message or "inscription" in user_message):
             keywords_map = {
                 'ensa': 'Concours ENSA', 'encg': 'Concours ENCG (TAFEM)', 'medecine': 'Concours Medecine', 'médecine': 'Concours Medecine',
                 'fst': 'Inscription CursusSup', 'est': 'Inscription CursusSup', 'cursussup': 'Inscription CursusSup', 'ofppt': 'Inscription OFPPT',
                 'bac': 'Resultats Bac'
             }
             found = None
             for k, v in keywords_map.items():
                 if k in user_message: found = v; break
            
             if found:
                 # Check Date
                 q_date = f"get_date_concours('{found}', D)"
                 res_d = list(prolog.query(q_date))
                 date_txt = clean_text(res_d[0]['D']) if res_d else "Non défini"
                 
                 # Check Seuil (Only for schools key, tricky map reuse)
                 # We need school name for seuil: 'ENSA' not 'Concours ENSA'.
                 seuil_txt = ""
                 if "ENSA" in found: school="ENSA"
                 elif "ENCG" in found: school="ENCG"
                 elif "Medecine" in found: school="Medecine"
                 elif "FST" in user_message.upper(): school="FST" # Fallback checks
                 elif "EST" in user_message.upper(): school="EST"
                 else: school=None
                 
                 if school:
                     q_seuil = f"get_seuil('{school}', 2023, N)"
                     res_s = list(prolog.query(q_seuil))
                     if res_s: seuil_txt = f"\n📉 **Seuil 2023** : {clean_text(res_s[0]['N'])}/20"
                 
                 response_text = f"📅 **{found}** :\n🗓️ **Date** : {date_txt}{seuil_txt}"
             else:
                 response_text = "📅 **Calendrier** : Je connais les dates pour ENSA, ENCG, Médecine, CursusSup..."

        # 8.2. Liens & Sites
        elif "lien" in user_message or "site" in user_message or "adresse" in user_message:
             keys = {'cursussup': 'CursusSup', 'minhaty': 'Minhaty (Bourse)', 'ensa': 'ENSA Maroc', 'tafem': 'TAFEM (ENCG)', 'ofppt': 'OFPPT'}
             found = None
             for k, v in keys.items():
                 if k in user_message: found = v; break
             
             if found:
                 q = f"get_lien('{found}', U)"
                 res = list(prolog.query(q))
                 url = clean_text(res[0]['U']) if res else "#"
                 response_text = f"🔗 **Lien {found}** : [Cliquez ici]({url})"
             else:
                 response_text = "🔗 **Liens Utiles** : Demandez-moi CursusSup, Minhaty, ENSA..."

        # 8.3. Procédures & Logement
        elif "comment" in user_message or "inscription" in user_message or "papier" in user_message or "document" in user_message or "logement" in user_message or "cité" in user_message or "internat" in user_message:
            # Check Logement
            if "logement" in user_message or "cité" in user_message or "internat" in user_message:
                type_log = 'Cité Universitaire' # Default
                if "privé" in user_message or "location" in user_message: type_log = 'Location Privée'
                elif "internat" in user_message: type_log = 'Internat'
                
                q = f"get_logement('{type_log}', D, C)"
                res = list(prolog.query(q))
                if res:
                     response_text = f"🏠 **{type_log}** :\nℹ️ {clean_text(res[0]['D'])}\n💡 {clean_text(res[0]['C'])}"
                else:
                     response_text = "🏠 **Logement** : Précisez Cité, Internat ou Location."
            else:
                # Procédures
                proc = 'Inscription Fac' # Default
                if "minhaty" in user_message or "bourse" in user_message: proc = 'Dossier Minhaty'
                elif "legalis" in user_message: proc = 'Legalisation'
                
                q = f"get_procedure('{proc}', D)"
                res = list(prolog.query(q))
                if res:
                     response_text = f"📝 **Procédure {proc}** :\n{clean_text(res[0]['D'])}"

        # 8.4. OFPPT
        elif "ofppt" in user_message or "technicien" in user_message or "ista" in user_message:
             niveau = 'Technicien Spécialisé'
             if "qualif" in user_message: niveau = 'Qualification'
             elif "technicien" in user_message and "spécialisé" not in user_message: niveau = 'Technicien'
             
             q = f"get_formation_pro('{niveau}', D, C)"
             res = list(prolog.query(q))
             if res:
                  response_text = f"🏭 **OFPPT ({niveau})** :\nℹ️ {clean_text(res[0]['D'])}\n💡 {clean_text(res[0]['C'])}"

        # 8.5. Calculateur de Note
        elif "calcul" in user_message or "moyenne" in user_message or "score" in user_message:
             import re
             # Extract numbers like 14.5 or 14
             nums = re.findall(r'\b\d+[.,]?\d*\b', user_message)
             nums = [float(n.replace(',', '.')) for n in nums]
             
             if len(nums) >= 2:
                  reg = nums[0]
                  nat = nums[1]
                  if reg <= 20 and nat <= 20:
                      score = (reg * 0.25) + (nat * 0.75)
                      response_text = f"🧮 **Calculateur de Seuil** :\n- Régional (25%) : {reg}\n- National (75%) : {nat}\n\n✨ **Votre Score d'Admission : {score:.2f}/20**\n"
                      
                      if score >= 15: response_text += "🌟 Excellent ! Vous êtes bien parti pour Médecine/ENSA."
                      elif score >= 12: response_text += "✅ Bon score. FST et EST sont très jouables. ENSA possible (vérifiez seuils)."
                      else: response_text += "⚠️ Un peu juste pour les filières sélectives. Visez EST, BTS ou Fac."
                  else:
                      response_text = "⚠️ Les notes doivent être sur 20."
             else:
                  response_text = "🧮 **Calculateur** : Donnez-moi vos notes Régional et National (ex: 'Calcul 14 16') pour avoir votre score."

        # 8.6. Quiz Orientation (Matières préférées)
        elif "quiz" in user_message or "aime" in user_message or "préfère" in user_message or "fort en" in user_message:
             response_text = "🧠 **Quiz Orientation** :\n"
             
             scores = {'ingenierie': 0, 'medecine': 0, 'commerce': 0, 'lettres': 0, 'art': 0}
             
             if "math" in user_message: scores['ingenierie'] += 2; scores['commerce'] += 1
             if "physique" in user_message: scores['ingenierie'] += 2
             if "svt" in user_message or "bio" in user_message: scores['medecine'] += 3
             if "info" in user_message or "cod" in user_message: scores['ingenierie'] += 2
             if "eco" in user_message or "gest" in user_message: scores['commerce'] += 3
             if "langue" in user_message or "fran" in user_message: scores['lettres'] += 2; scores['commerce'] += 1
             if "dessin" in user_message or "art" in user_message: scores['art'] += 3; scores['ingenierie'] += 1 # Archi
             
             best = max(scores, key=scores.get)
             if scores[best] > 0:
                 if best == 'ingenierie': rec = "Vous semblez avoir un profil **Ingénieur / Tech** ! 🛠️\n👉 Visez ENSA, CPGE, FST, EST."
                 elif best == 'medecine': rec = "Vous avez un profil **Santé / Bio** ! 🩺\n👉 Visez Médecine, Pharmacie, ISPITS."
                 elif best == 'commerce': rec = "Vous avez un profil **Manager / Eco** ! 💼\n👉 Visez ENCG, ISCAE, EST."
                 elif best == 'lettres': rec = "Vous avez un profil **Littéraire / Droit** ! 📚\n👉 Visez Fac de Droit, Lettres, Journalisme."
                 elif best == 'art': rec = "Vous avez un profil **Créatif / Archi** ! 🎨\n👉 Visez ENA (Archi), Beaux-Arts ou Design."
                 
                 response_text += rec + "\n\n(Dites 'Détail Ingénieur' pour en savoir plus)"
             else:
                 response_text += "Dites-moi quelles matières vous aimez (Maths, SVT, Eco, Langues...) pour que je vous oriente !"

        # --- 3. CONSEILS (Organisation, Sommeil...) ---
        elif "conseil" in user_message or "méthode" in user_message or "methode" in user_message or "révision" in user_message or "revision" in user_message or "travail" in user_message or "avenir" in user_message or "budget" in user_message:
            # Extraction du theme
            theme = "Organisation" # Default
            if "méthode" in user_message or "methode" in user_message: theme = "Méthode"
            if "révision" in user_message or "revision" in user_message: theme = "Examens"
            if "avenir" in user_message: theme = "Vie Pro"
            if "budget" in user_message: theme = "Budget"

            # On essaie de requeter par theme, sinon on prend tout
            all_conseils = list(prolog.query("conseil(T, Txt)"))
            
            # Filtrage python simple
            filtered = []
            print(f"DEBUG: Theme demandé: {theme}")
            for c in all_conseils:
                t_raw = c['T']
                t_clean = clean_text(t_raw)
                
                # Check match sur clean ET raw (au cas où mojibake persiste)
                # On normalize aussi pour retirer accents potentiels
                if theme.lower() in t_clean.lower() or theme.lower() in t_raw.lower() or normalize_text(theme).lower() in normalize_text(t_clean).lower():
                    filtered.append(c)
            
            print(f"DEBUG: Filtered count: {len(filtered)}")
            
            if not filtered: 
                print("DEBUG: Fallback to all_conseils")
                filtered = all_conseils
            
            if filtered:
                shuffled = random.sample(filtered, min(3, len(filtered)))
                response_text = f"💡 **Conseils ({theme}) :**\n"
                for r in shuffled:
                     response_text += f"- {clean_text(r['Txt'])}\n"

        # --- 8. SIMPLES ---
        elif "pomodoro" in user_message:
            response_text = "🍅 **Pomodoro** : Travaille 25 min à fond, puis 5 min de pause."

        # --- 9. FALLBACKS (Messages vagues, Perdu, Gibberish) ---
        elif any(keyword in user_message for keyword in ['aide', 'aidez', 'help', 'aider', 'besoin']):
            response_text = "Bien sûr ! 🤝 Je peux vous aider sur :\n\n🎓 **Orientation** : 'Que faire avec un Bac PC/SVT/Eco ?'\n🏫 **Écoles** : 'Prix EMSI', 'Où est ENSA ?'\n💡 **Conseils** : 'Conseils révision', 'Méthode travail'\n🩺 **Médecine** : 'Médecine avec 14 de moyenne'\n💼 **Débouchés** : 'Métiers informatique'\n\nQuelle est votre question ?"
        
        elif any(keyword in user_message for keyword in ['perdu', 'confus', 'comprends pas', 'sais pas', 'comment faire', 'quoi faire']):
            response_text = "Pas de panique ! 🧭 Je vais vous guider.\n\n**Dites-moi :**\n1. Quel est votre type de Bac ? (PC, SVT, Eco...)\n2. Quelle est votre moyenne ?\n3. Avez-vous une filière en tête ?\n\nExemple : 'Bac SVT 14 médecine'\n\nJe vous donnerai des conseils personnalisés !"

        elif len(user_message) < 4 and not any(kw in user_message for kw in ['cv', 'bac', 'pc', 'sm', 'svt', 'eco', 'it', 'fr', 'en']):
            response_text = "Je n'ai pas compris votre message (trop court). 🤔\n\nEssayez une question comme :\n- 'Que faire avec un Bac PC ?'\n- 'Prix EMSI'\n- 'Conseils révision'\n- 'Médecine avec 14'"
            
    except Exception as e:
        print(f"Prolog Error: {e}")
        response_text = "🧠 Je réfléchis... (Erreur interne Prolog). Réessayez."

    return jsonify({
        "response": response_text
    })

if __name__ == '__main__':
    print("Serveur Python + SWI-Prolog demarré sur le port 5000")
    app.run(port=5000, debug=True)
