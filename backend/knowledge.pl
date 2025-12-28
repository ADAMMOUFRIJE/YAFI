% =======================================================
% BASE DE CONNAISSANCES - PFE EXPERT (CLEAN VERSION)
% =======================================================

% -------------------------------------------------------
% 1. ORIENTATION & STRATEGIE (Règles Décisionnelles)
% -------------------------------------------------------

% A. RECOMMANDATIONS PAR BAC (debouche/4)
debouche('PC', 'Ingénierie', 'ENSA / FST', 'Recommandé. Concours ou dossier. (Maths/Physique importants)').
debouche('PC', 'Ingénierie d\'Excellence', 'UM6P / EMI', 'Si moyenne > 15 ou via CNC.').
debouche('PC', 'CPGE (Prépas)', 'MPSI / PCSI', 'Voie royale pour les grandes écoles. Moyenne > 15 conseillée.').
debouche('SM', 'Top Ingénierie', 'EMI / ENSIAS', 'Via CPGE ou CNC. Profil très recherché.').
debouche('SM', 'Informatique & Data', 'ENSIAS / INPT', 'Excellent choix pour les matheux.').
debouche('SM', 'Architecture', 'ENA', 'Concours spécifique.').
debouche('SVT', 'Médecine & Pharmacie', 'FMP / FMD', 'Filière de prédilection. Moyenne > 13 conseillée.').
debouche('SVT', 'Santé (Paramédical)', 'ISPITS / IFCS', 'Via concours. Bonnes perspectives.').
debouche('SVT', 'Biologie / Agro', 'FST / APESA', 'Cycle ingénieur agronome IAV possible.').
debouche('ECO', 'Commerce & Gestion', 'ENCG', 'Top école publique (Via TAFEM).').
debouche('ECO', 'Management', 'ISCAE', 'Après prépa ou licence. Très prestigieux.').
debouche('ECO', 'Droit / Eco', 'Facultés', 'Filières ouvertes. Maîtrise du français/arabe requise.').

% B. REGLES D'ELIGIBILITE MEDECINE
peut_faire_medecine(Bac, Note, '✅ Admissible (Favorable)') :-
    (Bac = 'SVT'), Note >= 13.
peut_faire_medecine(Bac, Note, '⚠️ Admissible mais dossier juste (Risqué)') :-
    (Bac = 'PC'; Bac = 'SM'), Note >= 12.
peut_faire_medecine(_, _, '❌ Moyenne insuffisante (<12) ou Bac inadapté. Tentez le Privé.').

% C. STRATEGIE SELON MOYENNE (conseil_note/2)
conseil_note(High, 'Viser l\'Excellence : Médecine, ENSA Rabat, EMI, Architecture.') :- High >= 15.
conseil_note(Med, 'Viser Stratégique : ENSA (Villes moins demandées : Safi, Khouribga), FST, EST.') :- Med >= 13, Med < 15.
conseil_note(Low, 'Viser Sécurité : Facultés, BTS, ISTA, ou Ecoles Privées (si budget).') :- Low < 13.

% D. COMPATIBILITE BAC-FILIERE (Nouveau - Avertissements)
% compatibilite_bac_filiere(Bac, Filiere, Statut, Message).

% Compatibilités EXCELLENTES
compatibilite_bac_filiere('SVT', medecine, excellent, '✅ Parfait ! SVT est le bac idéal pour médecine/santé.').
compatibilite_bac_filiere('PC', ingenierie, excellent, '✅ Parfait ! PC est très adapté pour l\'ingénierie.').
compatibilite_bac_filiere('SM', ingenierie, excellent, '✅ Parfait ! SM est excellent pour l\'ingénierie et l\'informatique.').
compatibilite_bac_filiere('SM', informatique, excellent, '✅ Parfait ! SM est idéal pour l\'informatique et data science.').
compatibilite_bac_filiere('PC', informatique, excellent, '✅ Très bon choix ! PC convient bien à l\'informatique.').
compatibilite_bac_filiere('ECO', commerce, excellent, '✅ Parfait ! Eco est le bac idéal pour commerce/gestion.').
compatibilite_bac_filiere('LITT', lettres, excellent, '✅ Parfait ! Littéraire est idéal pour lettres/langues/communication.').

% Compatibilités POSSIBLES mais avec DIFFICULTES
compatibilite_bac_filiere('SVT', informatique, difficile, '⚠️ ATTENTION : SVT vers IT est difficile. Tu manqueras de bases en maths/programmation. Considère une remise à niveau ou choisis Bio/Santé.').
compatibilite_bac_filiere('SVT', ingenierie, difficile, '⚠️ ATTENTION : SVT vers ingénierie (sauf bio/agro) est difficile. Lacunes en maths/physique appliquée. Privilégie Médecine/Bio.').
compatibilite_bac_filiere('ECO', ingenierie, difficile, '⚠️ ATTENTION : Eco vers ingénierie est très difficile. Bases scientifiques insuffisantes. Reste sur Commerce/Gestion.').
compatibilite_bac_filiere('ECO', informatique, possible, '⚠️ Possible mais difficile. Eco vers IT nécessite forte motivation et remise à niveau en maths/logique. Considère Gestion SI.').
compatibilite_bac_filiere('LITT', ingenierie, impossible, '❌ INCOMPATIBLE : Littéraire vers ingénierie est quasi-impossible. Bases scientifiques absentes. Reste sur Lettres/Com/Droit.').
compatibilite_bac_filiere('LITT', informatique, difficile, '⚠️ Très difficile : LITT vers IT nécessite énorme effort en maths/logique. Considère Communication Digitale plutôt.').
compatibilite_bac_filiere('PC', medecine, possible, '⚠️ Possible mais SVT est mieux adapté. PC peut faire médecine mais avec plus d\'effort en biologie.').
compatibilite_bac_filiere('SM', medecine, possible, '⚠️ Possible mais SVT est mieux adapté. SM peut faire médecine mais avec plus d\'effort en biologie.').

% Helper
check_compatibilite(Bac, Filiere, Statut, Message) :- compatibilite_bac_filiere(Bac, Filiere, Statut, Message).

% -------------------------------------------------------
% 2. CARTOGRAPHIE & VILLES (Geographie)
% -------------------------------------------------------

% Villes à forte concurrence (Demande > Offre)
ville_concurrence('Casablanca').
ville_concurrence('Rabat').
ville_concurrence('Marrakech').
ville_concurrence('Fès').
ville_concurrence('Tanger').

% Villes "Opportunité" (Bon ration Places/Candidats)
ville_chance('Béni Mellal').
ville_chance('Safi').
ville_chance('Khouribga').
ville_chance('El Jadida').
ville_chance('Taza').
ville_chance('Errachidia').
ville_chance('Al Hoceima').

% Localisation des Etablissements Publics
localisation('Université Hassan II', 'Casablanca').
localisation('Université Hassan II', 'Mohammedia').
localisation('Université Mohammed V', 'Rabat').
localisation('Université Cadi Ayyad', 'Marrakech').
localisation('Université Ibn Zohr', 'Agadir').
localisation('Université Abdelmalek Essaâdi', 'Tétouan').
localisation('ENSA', 'Agadir').
localisation('ENSA', 'Fès').
localisation('ENSA', 'Marrakech').
localisation('ENSA', 'Tanger').
localisation('ENSA', 'Tétouan').
localisation('ENSA', 'Khouribga').
localisation('ENSA', 'Safi').
localisation('ENSA', 'El Jadida').
localisation('ENSA', 'Berrechid').
localisation('ENSA', 'Béni Mellal').
localisation('ENSA', 'Oujda').
localisation('ENSA', 'Al Hoceima').
localisation('ENSAM', 'Meknès').
localisation('ENSAM', 'Casablanca').
localisation('ENSAM', 'Rabat').
localisation('ENSIAS', 'Rabat').
localisation('EMI', 'Rabat').
localisation('FST', 'Fès').
localisation('FST', 'Settat').
localisation('FST', 'Mohammedia').
localisation('FST', 'Béni Mellal').
localisation('FST', 'Errachidia').
localisation('UM6P', 'Benguerir').
localisation('Université Al Akhawayn', 'Ifrane').

% Localisation du Privé
localisation('EMSI', 'Casablanca').
localisation('EMSI', 'Rabat').
localisation('EMSI', 'Marrakech').
localisation('EMSI', 'Fès').
localisation('UIR', 'Rabat').
localisation('SUPINFO', 'Casablanca').
localisation('HEM', 'Casablanca').
localisation('ESCA', 'Casablanca').
localisation('UIASS', 'Rabat').
localisation('UPSAT', 'Casablanca').

% -------------------------------------------------------
% 3. ECOLES PRIVEES (Détails & Frais)
% -------------------------------------------------------
detail_ecole('EMSI', 'Ingénierie (Privé)', 'Génie Info, Indus, Civil', '28 000 - 38 000 DH/an').
detail_ecole('UIR', 'Université Semi-Public', 'Aéro, Info, Business, Sc.Po', '65 000 - 95 000 DH/an').
detail_ecole('SUPINFO', 'IT (Privé)', 'Full Stack, Cloud, Cyber', '45 000 - 60 000 DH/an').
detail_ecole('HEM', 'Business (Privé)', 'Management, Marketing', '35 000 - 60 000 DH/an').
detail_ecole('ESCA', 'Business (Privé)', 'Finance, Audit', '45 000 - 70 000 DH/an').
detail_ecole('UIASS', 'Santé (Semi-Privé)', 'Médecine, Dentaire', '80 000 - 130 000 DH/an').
detail_ecole('UPSAT', 'Santé (Privé)', 'Médecine, Pharma', '70 000 - 110 000 DH/an').
detail_ecole('ISITT Privé', 'Tourisme', 'Management Hôtelier', '20 000 - 30 000 DH/an').

% -------------------------------------------------------
% 4. STATISTIQUES & CHIFFRES CLES
% -------------------------------------------------------
stat('Global', 'Etudiants Maroc', '1.25 Million').
stat('Global', 'Filières', '+1000 accréditées').
stat('Places', 'Médecine (Total)', '~4 800 places').
stat('Places', 'Médecine (Casa)', '~200 places').
stat('Places', 'ENSA (Total)', '~4 000 places').
stat('Places', 'ENSA (Casa)', '~350 places').
stat('Places', 'ENSA (Béni Mellal)', '~150 places').
stat('Selectivite', 'Médecine', '1 admis pour 22 candidats').
stat('Selectivite', 'ENSA', '1 admis pour 21 candidats').
stat('Salaires', 'Ingénieur Débutant', '8 000 - 12 000 DH/mois').
stat('Salaires', 'Médecin Public', '12 000 - 15 000 DH/mois').

% -------------------------------------------------------
% 5. CONSEILS & METHODOLOGIE (info/2) - EXPANDED
% -------------------------------------------------------
:- discontiguous info/2.

% Organisation Personnelle
info('Organisation', 'Fais un planning réaliste. Ne charge pas trop tes journées.').
info('Organisation', 'Utilise la méthode Pomodoro (25min travail / 5min pause).').
info('Organisation', 'Dors au moins 7h/nuit. Le cerveau mémorise en dormant.').
info('Organisation', 'Crée un agenda hebdomadaire avec horaires fixes pour études et révisions.').
info('Organisation', 'Planifie cours, révisions, travaux ET loisirs pour un équilibre sain.').

% Méthode de Travail
info('Méthode', 'Révise avec des fiches de synthèse (formules, dates, définitions).').
info('Méthode', 'Pratique sur les ANNALES des années précédentes. C\'est crucial.').
info('Méthode', 'Explique ton cours à voix haute (Technique Feynman) pour vérifier ta compréhension.').
info('Méthode', 'Travaille en groupe pour renforcer la compréhension.').
info('Méthode', 'Utilise cartes mentales et résumés visuels pour mémoriser.').

% Gestion Examens
info('Examens', 'Révise régulièrement (tous les soirs ou chaque semaine) pour éviter le stress de dernière minute.').
info('Examens', 'Priorise les matières clés mais ne néglige pas les "faciles" qui améliorent la moyenne.').
info('Examens', 'Divise les chapitres par semaine pour un plan d\'étude progressif.').
info('Examens', 'Fais des exercices et annales pour te préparer efficacement.').
info('Examens', 'Répétition espacée : revoir régulièrement les notions pour mémorisation durable.').
info('Examens', 'Auto-évaluation : teste tes connaissances régulièrement pour identifier points faibles.').
info('Examens', 'Questionnement actif : cherche à comprendre "pourquoi" plutôt que "comment".').

% Assiduité & Participation
info('Assiduité', 'Assiste à TOUS les cours et TD/TP. L\'absence crée des lacunes.').
info('Assiduité', 'Participe activement aux travaux pratiques et projets.').
info('Assiduité', 'Pose des questions en cours et lors des permanences des profs.').

% Ressources Universitaires
info('Ressources', 'Utilise bibliothèques, plateformes en ligne, notes partagées par anciens.').
info('Ressources', 'Rejoins tutorats ou groupes d\'études pour renforcer tes connaissances.').
info('Ressources', 'Cherche conseils auprès des profs sur cours, projets et examens.').

% Compétences Transversales
info('Compétences', 'Français et anglais indispensables. Renforce ton niveau via cours ou apps.').
info('Compétences', 'Maîtrise Excel, Word, PowerPoint et logiciels spécifiques à ta filière.').
info('Compétences', 'Développe soft skills : organisation, esprit critique, communication, travail en équipe.').

% Stratégies par Filière
info('Sciences', 'Révise TOUS les TP et exercices pratiques. Fais des projets persos pour comprendre.').
info('Médecine', 'Révisions continues pour cours volumineux. Groupes de travail pour anatomie/physiologie.').
info('Commerce', 'Pratique cas réels, études de marché, exercices financiers.').
info('Lettres', 'Lecture régulière, rédaction d\'essais, participation débats et séminaires.').

% Stratégie d'Orientation
info('Stratégie', 'Plan A / Plan B : Toujours avoir une filière "Sécurité" (Fac, Privé) si ton 1er choix échoue.').
info('Stratégie', 'Regarde les débouchés RÉELS (Offres d\'emploi sur LinkedIn) avant de choisir.').
info('Stratégie', 'Ne suis pas tes amis. Choisis ce qui TE correspond.').
info('Stratégie', 'Pense aux villes "Opportunité" (Béni Mellal, Safi...) si ta note est juste.').

% Vie Etudiante & Équilibre
info('Vie Pro', 'Les stages sont obligatoires pour un bon CV. Cherche dès la 1ère année.').
info('Vie Pro', 'Anglais = Salaire. Passe le TOEIC ou TOEFL si tu peux.').
info('Vie Pro', 'Réseaute : rencontre étudiants, anciens, profs. Participe aux clubs universitaires.').

% Santé & Bien-être
info('Santé', 'Dors suffisamment, fais de l\'exercice, mange équilibré.').
info('Santé', 'Gère le stress : respiration, sport, méditation ou loisirs.').

% Budget & Bourses
info('Budget', 'Bourses : Minhaty, Erasmus (Europe), Fulbright (USA). Renseigne-toi tôt.').
info('Budget', 'Logement : Les cités universitaires sont prioritaires pour ceux qui habitent loin.').

% Planification & Objectifs
info('Objectifs', 'Fixe objectifs précis : moyenne à atteindre, stages, compétences.').
info('Objectifs', 'Évalue régulièrement tes progrès après chaque examen.').
info('Objectifs', 'Ajuste ta méthode de travail si nécessaire.').
info('Objectifs', 'Prévois Plan B : rattrapage, cours supplémentaires si besoin.').

% -------------------------------------------------------
% 6. DEFINITIONS (Système LMD)
% -------------------------------------------------------
definition('LMD', 'Système Licence (3 ans) -> Master (+2 ans) -> Doctorat (+3 ans). Standard mondial.').
definition('CPGE', 'Classes Prépas (2 ans intensifs). Prépare aux concours des Grandes Ecoles d\'ingénieurs (CNC).').
definition('BTS', 'Brevet Technicien Supérieur (2 ans). Formation courte, pratique, bonne insertion pro.').
definition('DUT', 'Diplôme Universitaire Technologie (2 ans). Souvent en EST. Plus académique que le BTS.').
definition('Master', 'Bac+5. Spécialisation nécessaire pour les postes de cadres/responsabilité.').
definition('Ingénieur', 'Titre protégé Bac+5. Formation technique et managériale de haut niveau.').
definition('ENSA', 'Ecole Nationale des Sciences Appliquées (5 ans). Formation d\'ingénieur d\'état. Accès post-bac ou bac+2.').
definition('ENCG', 'Ecole Nationale de Commerce et de Gestion (5 ans). Formation management/commerce. Accès par concours TAFEM.').
definition('EST', 'Ecole Supérieure de Technologie (2 ans). Délivre le DUT. Formation technique courte.').
definition('FST', 'Faculté des Sciences et Techniques. Système LMD hybride (Tronc commun + Spécialité). Accès sur dossier.').
definition('OFPPT', 'Office de la Formation Professionnelle. Formations courtes (2 ans) type Technicien Spécialisé. Pratique et insertion rapide.').
definition('CPGE', 'Classes Prépas aux Grandes Ecoles (2 ans). Voie d\'excellence pour intégrer les meilleures écoles d\'ingénieurs (Maroc/France).').

% -------------------------------------------------------
% API LOGIQUE (Predicats appelés par Python)
% -------------------------------------------------------

% Recommandation simple
recommander_orientation(Bac, Domaine, Ecole) :-
    debouche(Bac, Domaine, Ecole, _).

% Extraction de conseils par thème
conseil(Theme, Texte) :- info(Theme, Texte).

% =======================================================
% 7. STRATEGIE AVANCEE (Nouvelle Logique)
% =======================================================

% Types d'établissements & Pros/Cons
info_type(public_ouvert, 
    'Filières ouvertes (Facs, Droit, Eco). Pas de sélection.',
    '✅ Gratuit, Large choix, Accessible tous niveaux.',
    '⚠️ Effectifs chargés, Moins de suivi, Peu de stages.').

info_type(public_regule, 
    'Filières sélectives (Médecine, ENSA, ENCG). Concours.',
    '✅ Diplôme prestigieux, Excellent insertion pro, Gratuit.',
    '⚠️ Trés forte concurrence, Stress, Sélection dure.').

info_type(prive, 
    'Ecoles privées (UIR, EMSI, HEM...). Payant.',
    '✅ Accès plus souple, Programmes modernes, Stages intégrés.',
    '⚠️ Coût élevé, Vérifier la reconnaissance du diplôme.').

% Logique de Stratégie (strategie_profil/3)
% Usage: strategie_profil(Note, Bac, Conseil).

% Cas 1 : Excellente moyenne (>15)
strategie_profil(Note, Bac, '🌟 Profil EXCELLENT : Visez les filières RÉGULÉES (Public).\n👉 Médecine, ENSA, ENCG, CPGE.\n👉 Visez les grandes villes (Rabat, Casa) mais gardez un Plan B.') :-
    Note >= 15.

% Cas 2 : Bonne moyenne (13-15)
strategie_profil(Note, Bac, '📈 Profil BON : Stratégie de "Contournement".\n👉 Visez les filières régulées dans les VILLES MOYENNES (Safi, Khouribga, El Jadida) où la concurrence est moindre.\n👉 Pensez aux FST qui sont un excellent compromis.') :-
    Note >= 13, Note < 15.

% Cas 3 : Moyenne Moyenne (11-13)
strategie_profil(Note, _, '🤔 Profil MOYEN : Choix Tactique nécessaire.\n👉 1. Universités Publiques (Filières Ouvertes) pour exceller et tenter des passerelles.\n👉 2. Ecoles Privées (si budget) pour un encadrement plus serré.\n👉 3. EST/BTS pour un diplôme court et pro.') :-
    Note >= 11, Note < 13.

% Cas 4 : Moyenne Juste (<11)
strategie_profil(Note, _, '⚠️ Profil JUSTE : Ne prenez pas de risques.\n👉 Privilégiez un BTS/DTS (OFPPT) pour un métier rapide.\n👉 Ou une école Privée qui mise sur la pratique.\n👉 Evitez les facs surchargées si vous manquez d\'autonomie.') :-
    Note < 11.

% Helpers
get_info_type(T, D, A, I) :- info_type(T, D, A, I).
get_strategie_profil(N, B, C) :- strategie_profil(N, B, C).

% =======================================================
% 8. PROFILS BAC DETAILLES (Nouveau)
% =======================================================
% detail_bac(Bac, Ideales, Avantages, Limites, Conseil).

detail_bac('PC', 
    'Ingénierie (ENSA, EMI...), Informatique/IT, Sciences fondamentales.',
    '✅ Accès à presque toutes les filières scientifiques. Bonne base pour concours.',
    '⚠️ Concurrence élevée en ingénierie.',
    '💡 Idéal si motivé par les sciences exactes. Moyenne >= 13-14 recommandée pour le public sélectif.').

detail_bac('SVT',
    'Médecine, Pharmacie, Dentaire, Biologie, Paramédical.',
    '✅ Voie royale pour la Santé. Profil polyvalent.',
    '⚠️ Difficile pour l\'ingénierie mécanique/info pure dans le public.',
    '💡 Moyenne >= 14-15 impérative pour Médecine. Sinon, viser le Privé ou les filières Bio.').

detail_bac('SM',
    'Maths, Statistique, Data Science, Ingénierie Top Niveau, Architecture.',
    '✅ Très polyvalent. Accès privilégié aux Prépas (MPSI) et Grandes Ecoles.',
    '⚠️ Rythme intense.',
    '💡 Excellent pour combiner sciences et économie/finance de haut niveau.').

detail_bac('ECO',
    'Economie, Gestion, Commerce (ENCG/ISCAE), Droit, Finance.',
    '✅ Débouchés nombreux en entreprise. Filières bancaires.',
    '⚠️ Difficile pour l\'ingénierie et les sciences dures.',
    '💡 Viser les écoles de commerce sélectives si bonne note. Sinon, Fac d\'Eco/Droit.').

detail_bac('LITT',
    'Lettres, Langues, Communication, Journalisme, Sciences Humaines, Droit.',
    '✅ Accès aux métiers de la culture, médias et enseignement.',
    '⚠️ Difficile pour l\'informatique et les sciences.',
    '💡 Explorer les écoles privées pour les programmes modernes (Com, Digital Media).').

% Helper pour Python
get_detail_bac(Bac, I, A, L, C) :- detail_bac(Bac, I, A, L, C).
    
% =======================================================
% 9. PROFILS DOMAINE DETAILLES (Nouveau)
% =======================================================
% detail_domaine(Domaine, Metiers, Ecoles, Conseil).

detail_domaine(medecine,
    'Médecin, Pharmacien, Dentiste, Recherche biomédicale.',
    'Universités (Rabat, Casa...), FMP, FMD.',
    '💡 Moyenne Bac >= 14-15 pour le Public. Villes moyennes plus accessibles.').

detail_domaine(ingenierie,
    'Ingénieur Civil, Mécanique, Indus, Data Scientist.',
    'ENSA, EMI, ENSIAS, UM6P. (Toutes villes).',
    '💡 Bac PC ou SM recommandé. Moyenne >= 13-15 selon ville.').

detail_domaine(informatique,
    'Développeur, Data Scientist, Cybersécurité, Consultant.',
    'EMSI, SUPINFO, UIR, ENSIAS, INPT.',
    '💡 Bac PC/SM (ou ES expert Maths). Privé efficace pour insertion rapide. ⚠️ Forte demande du marché mais besoin de mise à jour constante.').

detail_domaine(commerce,
    'Manager, Analyste Financier, Auditeur, Marketing, RH.',
    'ENCG, ISCAE, HEM, ESCA, UIR.',
    '💡 Bac ES ou SM recommandé. Anglais crucial.').

detail_domaine(shs,
    'Enseignant, Psychologue, Journaliste, RH, Administration.',
    'Facultés des Lettres & Sciences Humaines (FLSH), Droit.',
    '💡 Bac LITT ou ES. Penser au Master pour se spécialiser.').

detail_domaine(archi,
    'Architecte, Urbaniste, Designer, Styliste.',
    'ENA, Beaux-Arts, Ecoles privées d\'Architecture.',
    '💡 Bac LITT ou ES (profil artistique). Portfolio recommandé.').

detail_domaine(tourisme,
    'Manager Hôtelier, Logistique, Agence de Voyage, Evénementiel.',
    'ISITT (Tanger), Ecoles privées de Tourisme.',
    '💡 Bac ES ou SM. Stages pratiques indispensables.').

% Helpers
get_detail_domaine(D, M, E, C) :- detail_domaine(D, M, E, C).
% Overload for Info which has 4 args in Description logic above but Prolog needs constant arity implies we mostly stick to 3 descriptive fields.
% Let's standardize on 3 fields: Metiers, Ecoles, Conseil.
% Added 4th arg for IT above by mistake in draft? No, let's keep it simple.
% Retrying IT without 4th arg to match others or update predicate.
% I will use 3 args for content: Metiers, Ecoles, Conseil.
% If I need extra 'Avantage', I'll squeeze in Conseil or split.
% User input had "Avantages" separate in previous turn but here inputs for domains are: Debouches, Ecoles, Conseil.
% IT input had "Conseil: Bac PC... Options privées...".
% I'll merge advice.

% Corrected logic (Standard Arity 3 for display simplicity + Key):
% detail_domaine(Key, Metiers, Ecoles, Conseil).

% =======================================================
% 10. CHOIX DE LANGUE D'ENSEIGNEMENT
% =======================================================
% choix_langue(Langue, Description, Avantages, Inconvenients, Conseil).

choix_langue(francais,
    'Langue dominante dans les filières scientifiques, techniques, médicales et commerciales.',
    '✅ Facilité d\'intégration universités publiques/privées. Reconnaissance internationale (Europe francophone). Accès large aux filières sélectives.',
    '⚠️ Niveau faible nécessite renforcement linguistique.',
    '💡 Continuer en français si niveau >= B2. Très recommandé pour sciences et techniques.').

choix_langue(anglais,
    'Langue d\'enseignement dans IT, business international, sciences de l\'ingénieur (UIR, UM6P, EMSI).',
    '✅ Ouverture internationale. Opportunités stage à l\'étranger. Obligatoire pour recherche scientifique et numérique.',
    '⚠️ Moins de cours dans universités publiques traditionnelles. Niveau B2/C1 requis.',
    '💡 Opter pour anglais si IT, data science, commerce international ou études à l\'étranger.').

choix_langue(arabe,
    'Principalement pour filières littéraires, droit, sciences islamiques, filières sociales.',
    '✅ Plus facile si excellent niveau arabe. Adapté lettres, droit national, sociologie, histoire.',
    '⚠️ Limite internationalisation. Moins adapté sciences et techniques.',
    '💡 Choisir arabe si motivé par filières littéraires/sociales/juridiques nationales.').

% Helper
get_choix_langue(L, D, A, I, C) :- choix_langue(L, D, A, I, C).

% =======================================================
% 11. CONCOURS & EXAMENS D'ADMISSION
% =======================================================
% concours_admission(Type, Exigences, Conseil).

concours_admission(medecine,
    'Sélection sur dossier académique (moyenne bac, notes scientifiques). Concours écrit/oral dans certaines universités (Casa, Fès).',
    '💡 Prépare intensivement SVT, physique-chimie, maths. Stages scientifiques renforcent le dossier.').

concours_admission(ingenierie_public,
    'Concours post-bac basé sur dossier + tests logique et mathématiques. Tests maths avancées, physique, français/anglais.',
    '💡 Bac PC/SM recommandé. Révisions ciblées maths, physique, logique. Entraîne-toi avec annales.').

concours_admission(ecoles_privees,
    'Tests admission internes : logique, maths, anglais, français. Entretien oral/motivationnel (HEM, UM6P).',
    '💡 Même avec bonne moyenne, prépare test et entretien. Pratique exercices logique et simulations entretien.').

concours_admission(commerce,
    'Test écrit aptitude : maths, logique, anglais/français. Entretien individuel ou étude de cas.',
    '💡 Prépare tests numériques, logique, culture générale. Ateliers ou cours préparatoires recommandés.').

% Stratégie générale concours
info('Concours', 'Identifie toutes les écoles visées et leurs exigences spécifiques.').
info('Concours', 'Planifie préparation concours parallèlement aux révisions bac.').
info('Concours', 'Simule examens avec annales et tests en ligne.').
info('Concours', 'Prévois Plan B : écoles ouvertes ou moins sélectives en cas de non-admission.').

% Helper
get_concours_admission(T, E, C) :- concours_admission(T, E, C).

% =======================================================
% 12. ETUDES COURTES VS LONGUES
% =======================================================
% duree_etudes(Type, Description, Avantages, Inconvenients, Conseil).

duree_etudes(courtes,
    'Durée 2-3 ans (BTS, DUT, Licence pro). Objectif : compétences pratiques rapides.',
    '✅ Insertion rapide marché travail. Moins exigeant (moyenne bac). Tester domaine. Frais moins élevés.',
    '⚠️ Diplôme moins valorisé pour postes responsabilité. Moins de recherche/académique. Master parfois nécessaire.',
    '💡 Idéal pour insertion rapide ou si moyenne limite accès filières longues. Bien choisir spécialité selon débouchés et stages.').

duree_etudes(longues,
    'Durée 5-8 ans (Ingénieur 5 ans, Médecine 7 ans). Objectif : niveau avancé et spécialisé.',
    '✅ Diplômes très valorisés. Reconnaissance nationale/internationale. Postes responsabilité. Possibilité Master/Doctorat.',
    '⚠️ Durée longue (engagement). Concurrence élevée. Stress et charge travail importante.',
    '💡 Choisir si forte motivation, aptitudes académiques solides, plan carrière clair. Évaluer capacité gérer études exigeantes.').

% Critères de choix
info('Durée Études', 'Moyenne élevée + Bac PC/SM → études longues scientifiques/ingénierie possibles.').
info('Durée Études', 'Moyenne moyenne → études courtes pour sécuriser insertion.').
info('Durée Études', 'Rapidité insertion → études courtes. Spécialisation/responsabilité → études longues.').
info('Durée Études', 'Études longues demandent organisation, endurance, persévérance.').
info('Durée Études', 'Plan A (longues) si moyenne/motivation suffisantes. Plan B (courtes) avec possibilité Master plus tard.').

% Helper
get_duree_etudes(T, D, A, I, C) :- duree_etudes(T, D, A, I, C).

% =======================================================
% 13. STAGES & EXPERIENCES PRATIQUES PAR FILIERE
% =======================================================
% stages_filiere(Filiere, Stages, Avantages).

stages_filiere(medecine,
    'Stages hospitaliers/cliniques dès 2ᵉ-3ᵉ année. TP laboratoire (bio, chimie, pharmacologie). Internats/stages fin études.',
    '✅ Préparation directe marché travail. Expérience pratique indispensable pour carrière.').

stages_filiere(ingenierie,
    'PFE (Projet Fin Études) obligatoire. Stages entreprise dès 3ᵉ-4ᵉ année. Labos et TP par spécialité.',
    '✅ Compétences techniques/professionnelles. Embauche possible via réseau entreprises partenaires.').

stages_filiere(informatique,
    'Projets pratiques dès 1ʳᵉ année. Stages entreprise/start-up/labo recherche. Hackathons et projets collaboratifs.',
    '✅ Expérience réelle dev/cyber/data. Insertion professionnelle rapide après diplôme.').

stages_filiere(commerce,
    'Stages entreprise/banques/assurances/conseil. TP : études marché, analyses financières. Alternances (HEM, ESCA, UIR).',
    '✅ Facilite insertion pro. Développe compétences réelles et réseau professionnel.').

stages_filiere(shs,
    'Travaux terrain, enquêtes, projets recherche. Stages ONG/collectivités/médias/associations. Méthodologie recherche appliquée.',
    '✅ Mise en pratique concepts théoriques. Compétences organisationnelles et analytiques.').

stages_filiere(arts,
    'Projets studio/labo créatif. Stages agences/studios design/cabinets architecture. Expositions et concours.',
    '✅ Portfolio professionnel prêt. Expérience concrète pour entreprises créatives.').

stages_filiere(tourisme,
    'Stages obligatoires hôtels/agences/transport. Projets : organisation événements, gestion circuits touristiques.',
    '✅ Acquisition rapide expérience pro. Réseautage entreprises locales/internationales.').

% Conseils généraux stages
info('Stages', 'Vérifie avant inscription : quelles écoles intègrent réellement des stages.').
info('Stages', 'Priorise filières avec alternance ou projets pratiques pour insertion rapide.').
info('Stages', 'Planifie tôt : stages dès 1ʳᵉ année pour acquérir maximum expérience.').
info('Stages', 'Réseautage et mentorat : profite des stages pour contacts professionnels futurs.').

% Helper
get_stages_filiere(F, S, A) :- stages_filiere(F, S, A).

% =======================================================
% 14. FINANCEMENT & BOURSES
% =======================================================
% financement(Type, Description, Conseil).

financement(public,
    'Frais très faibles (quelques centaines DH/semestre). Idéal budget limité.',
    '💡 Accessible moyens modestes. Possibilité aides sociales universitaires.').

financement(bourses_gouvernementales,
    'Bourses mérite (notes bac/excellence) et bourses sociales (revenus faibles). Allocation mensuelle ou frais réduits.',
    '💡 Vérifier critères et dates limites chaque année sur site ministère/université.').

financement(bourses_privees,
    'Écoles privées (EMSI, UIR, HEM) : bourses partielles/totales selon mérite/besoins. Plans paiement échelonné. Fondations (OCP, BMCE, UM6P).',
    '💡 Bourses basées sur mérite, projet académique ou situation sociale.').

financement(international,
    'Erasmus+, Fulbright, Chevening, DAAD, Campus France. Couvrent frais scolarité, logement, voyage.',
    '💡 Vérifier critères linguistiques/académiques. Préparer un an à l\'avance (dossier, tests, motivation).').

financement(personnel,
    'Travail étudiant (tutorat, freelance). Prêts étudiants banques marocaines (taux réduits). Économies famille.',
    '💡 Planifier budget. Combiner plusieurs sources : bourse + travail + aide familiale.').

% Conseils généraux financement
info('Financement', 'Planification : identifier toutes sources financement avant inscription.').
info('Financement', 'Dossier solide pour bourses mérite : bonnes notes, lettres motivation, projet clair.').
info('Financement', 'Suivi dates : respecter échéances candidatures et documents.').
info('Financement', 'Combiner sources : bourse + travail + aide familiale pour couvrir tous frais.').

% Helper
get_financement(T, D, C) :- financement(T, D, C).

% =======================================================
% 15. SEUILS D'ADMISSION (Historique)
% =======================================================
% seuil(Ecole, Annee, Note).
seuil('ENSA', 2023, 13.5).
seuil('ENSA', 2022, 12.0).
seuil('ENCG', 2023, 12.0).
seuil('ENCG', 2022, 12.0).
seuil('Medecine', 2023, 12.0).
seuil('FST', 2023, 12.0).
seuil('EST', 2023, 11.0).

get_seuil(E, A, N) :- seuil(E, A, N).

% =======================================================
% 16. DATES & CALENDRIER (Estimations)
% =======================================================
% date_concours(Event, Date).
date_concours('Inscription CursusSup', 'Mai - Juin').
date_concours('Concours Medecine', 'Juillet (mi-juillet)').
date_concours('Concours ENSA', 'Juillet (fin juillet)').
date_concours('Concours ENCG (TAFEM)', 'Juillet').
date_concours('Inscription OFPPT', 'Avril - Juin (1ère session)').
date_concours('Resultats Bac', 'Juin (fin juin)').

get_date_concours(E, D) :- date_concours(E, D).

% =======================================================
% 17. LIENS UTILES
% =======================================================
% lien(Nom, URL).
lien('CursusSup', 'https://www.cursussup.gov.ma').
lien('Minhaty (Bourse)', 'https://www.minhaty.ma').
lien('ENSA Maroc', 'http://www.ensa-concours.ma').
lien('TAFEM (ENCG)', 'http://www.tafem.ma').
lien('OFPPT', 'https://www.ofppt.ma').

get_lien(N, U) :- lien(N, U).

% =======================================================
% 18. PROCEDURES ADMINISTRATIVES
% =======================================================
% procedure(Titre, Description).
procedure('Inscription Fac', '1. Pré-inscription sur site université. 2. Dépôt dossier (Bac original, Relevé notes, CIN, Photos). 3. Reçu inscription.').
procedure('Dossier Minhaty', '1. Inscription sur minhaty.ma. 2. Dépôt dossier physique (Attestation revenu parents, Certificat résidence...) auprès des autorités locales / Lycée.').
procedure('Legalisation', 'Toujours légaliser les copies du Bac et Relevés de notes à la commune (Moqatia). Garder plusieurs copies d\'avance.').

get_procedure(T, D) :- procedure(T, D).

% =======================================================
% 19. LOGEMENT ETUDIANT
% =======================================================
% logement(Type, Description, Conseil).
logement('Cite Universitaire', 'Logement public subventionné. ~40-50 DH/mois. Priorité aux boursiers et éloignés.', '💡 Demande à faire via l\'Office National (ONOUHC). Places limitées.').
logement('Internat', 'Disponible dans certaines prépas (CPGE) et lycées d\'excellence.', '💡 Renseigne-toi directement auprès de l\'établissement.').
logement('Location Privee', 'Chambre ou appartement partagé. Coût variable (1000-3000 DH).', '💡 Cherche des colocations pour réduire frais. Proche transport/école.').
logement('Bayt Al Maarifa', 'Résidences étudiantes privées/publiques de bon standing.', '💡 Plus cher mais sécurisé et équipé.').

get_logement(T, D, C) :- logement(T, D, C).

% =======================================================
% 20. FORMATION PROFESSIONNELLE (OFPPT)
% =======================================================
% formation_pro(Niveau, Description, Conseil).
formation_pro('Technicien Specialise', 'Bac requis. 2 ans. Diplôme TS. Accès aux Licences Pro possible.', '💡 Top filières : Dév Digital, Gestion Entreprise, Diagnostic Auto.').
formation_pro('Technicien', 'Niveau Bac (sans bac). 2 ans. Métiers techniques.', '💡 Electricité, Mécanique, Cuisine. Insertion rapide.').
formation_pro('Qualification', 'Niveau 3ème collégiale. Métiers manuels.', '💡 Plomberie, Soudure, Réparation.').

get_formation_pro(N, D, C) :- formation_pro(N, D, C).

