:- encoding(utf8).
:- discontiguous etablissement/5.
:- discontiguous filiere/6.
:- discontiguous serie_bac/1.
:- discontiguous secteur_formation/1.
:- discontiguous plateforme/2.
:- discontiguous specialite/2.
:- discontiguous debouche_associe/2.
:- discontiguous conseil_orientation/4.
:- discontiguous recommandation_profil/4.
:- discontiguous debouches_filiere/2.
:- discontiguous detail_ecole/4.
:- discontiguous localisation/2.
:- discontiguous definition/2.
:- discontiguous info/2.
:- discontiguous stat/3.
:- discontiguous ville_chance/1.

% =======================================================
% BASE DE CONNAISSANCES - PFE EXPERT (CLEAN VERSION)
% =======================================================

% -------------------------------------------------------
% 1. ORIENTATION & STRATEGIE (RÃ¨gles DÃ©cisionnelles)
% -------------------------------------------------------

% A. RECOMMANDATIONS PAR BAC (debouche/4)
debouche('PC', 'IngÃ©nierie', 'ENSA / FST', 'RecommandÃ©. Concours ou dossier. (Maths/Physique importants)').
debouche('PC', 'IngÃ©nierie d\'Excellence', 'UM6P / EMI', 'Si moyenne > 15 ou via CNC.').
debouche('PC', 'CPGE (PrÃ©pas)', 'MPSI / PCSI', 'Voie royale pour les grandes Ã©coles. Moyenne > 15 conseillÃ©e.').
debouche('SM', 'Top IngÃ©nierie', 'EMI / ENSIAS', 'Via CPGE ou CNC. Profil trÃ¨s recherchÃ©.').
debouche('SM', 'Informatique & Data', 'ENSIAS / INPT', 'Excellent choix pour les matheux.').
debouche('SM', 'Architecture', 'ENA', 'Concours spÃ©cifique.').
debouche('SVT', 'MÃ©decine & Pharmacie', 'FMP / FMD', 'FiliÃ¨re de prÃ©dilection. Moyenne > 13 conseillÃ©e.').
debouche('SVT', 'SantÃ© (ParamÃ©dical)', 'ISPITS / IFCS', 'Via concours. Bonnes perspectives.').
debouche('SVT', 'Biologie / Agro', 'FST / APESA', 'Cycle ingÃ©nieur agronome IAV possible.').
debouche('ECO', 'Commerce & Gestion', 'ENCG', 'Top Ã©cole publique (Via TAFEM).').
debouche('ECO', 'Management', 'ISCAE', 'AprÃ¨s prÃ©pa ou licence. TrÃ¨s prestigieux.').
debouche('ECO', 'Droit / Eco', 'FacultÃ©s', 'FiliÃ¨res ouvertes. MaÃ®trise du franÃ§ais/arabe requise.').

% B. REGLES D'ELIGIBILITE MEDECINE
peut_faire_medecine(Bac, Note, 'âœ… Admissible (Favorable)') :-
    (Bac = 'SVT'), Note >= 13.
peut_faire_medecine(Bac, Note, 'âš ï¸� Admissible mais dossier juste (RisquÃ©)') :-
    (Bac = 'PC'; Bac = 'SM'), Note >= 12.
peut_faire_medecine(_, _, 'â�Œ Moyenne insuffisante (<12) ou Bac inadaptÃ©. Tentez le PrivÃ©.').

% C. STRATEGIE SELON MOYENNE (conseil_note/2)
conseil_note(High, 'Viser l\'Excellence : MÃ©decine, ENSA Rabat, EMI, Architecture.') :- High >= 15.
conseil_note(Med, 'Viser StratÃ©gique : ENSA (Villes moins demandÃ©es : Safi, Khouribga), FST, EST.') :- Med >= 13, Med < 15.
conseil_note(Low, 'Viser SÃ©curitÃ© : FacultÃ©s, BTS, ISTA, ou Ecoles PrivÃ©es (si budget).') :- Low < 13.

% D. COMPATIBILITE BAC-FILIERE (Nouveau - Avertissements)
% compatibilite_bac_filiere(Bac, Filiere, Statut, Message).

% CompatibilitÃ©s EXCELLENTES
compatibilite_bac_filiere('SVT', medecine, excellent, 'âœ… Parfait ! SVT est le bac idÃ©al pour mÃ©decine/santÃ©.').
compatibilite_bac_filiere('PC', ingenierie, excellent, 'âœ… Parfait ! PC est trÃ¨s adaptÃ© pour l\'ingÃ©nierie.').
compatibilite_bac_filiere('SM', ingenierie, excellent, 'âœ… Parfait ! SM est excellent pour l\'ingÃ©nierie et l\'informatique.').
compatibilite_bac_filiere('SM', informatique, excellent, 'âœ… Parfait ! SM est idÃ©al pour l\'informatique et data science.').
compatibilite_bac_filiere('PC', informatique, excellent, 'âœ… TrÃ¨s bon choix ! PC convient bien Ã  l\'informatique.').
compatibilite_bac_filiere('ECO', commerce, excellent, 'âœ… Parfait ! Eco est le bac idÃ©al pour commerce/gestion.').
compatibilite_bac_filiere('LITT', lettres, excellent, 'âœ… Parfait ! LittÃ©raire est idÃ©al pour lettres/langues/communication.').

% CompatibilitÃ©s POSSIBLES mais avec DIFFICULTES
compatibilite_bac_filiere('SVT', informatique, difficile, 'âš ï¸� ATTENTION : SVT vers IT est difficile. Tu manqueras de bases en maths/programmation. ConsidÃ¨re une remise Ã  niveau ou choisis Bio/SantÃ©.').
compatibilite_bac_filiere('SVT', ingenierie, difficile, 'âš ï¸� ATTENTION : SVT vers ingÃ©nierie (sauf bio/agro) est difficile. Lacunes en maths/physique appliquÃ©e. PrivilÃ©gie MÃ©decine/Bio.').
compatibilite_bac_filiere('ECO', ingenierie, difficile, 'âš ï¸� ATTENTION : Eco vers ingÃ©nierie est trÃ¨s difficile. Bases scientifiques insuffisantes. Reste sur Commerce/Gestion.').
compatibilite_bac_filiere('ECO', informatique, possible, 'âš ï¸� Possible mais difficile. Eco vers IT nÃ©cessite forte motivation et remise Ã  niveau en maths/logique. ConsidÃ¨re Gestion SI.').
compatibilite_bac_filiere('LITT', ingenierie, impossible, 'â�Œ INCOMPATIBLE : LittÃ©raire vers ingÃ©nierie est quasi-impossible. Bases scientifiques absentes. Reste sur Lettres/Com/Droit.').
compatibilite_bac_filiere('LITT', informatique, difficile, 'âš ï¸� TrÃ¨s difficile : LITT vers IT nÃ©cessite Ã©norme effort en maths/logique. ConsidÃ¨re Communication Digitale plutÃ´t.').
compatibilite_bac_filiere('PC', medecine, possible, 'âš ï¸� Possible mais SVT est mieux adaptÃ©. PC peut faire mÃ©decine mais avec plus d\'effort en biologie.').
compatibilite_bac_filiere('SM', medecine, possible, 'âš ï¸� Possible mais SVT est mieux adaptÃ©. SM peut faire mÃ©decine mais avec plus d\'effort en biologie.').

% Helper
check_compatibilite(Bac, Filiere, Statut, Message) :- compatibilite_bac_filiere(Bac, Filiere, Statut, Message).

% -------------------------------------------------------
% 2. CARTOGRAPHIE & VILLES (Geographie)
% -------------------------------------------------------

% Villes Ã  forte concurrence (Demande > Offre)
ville_concurrence('Casablanca').
ville_concurrence('Rabat').
ville_concurrence('Marrakech').
ville_concurrence('FÃ¨s').
ville_concurrence('Tanger').

% Villes "OpportunitÃ©" (Bon ration Places/Candidats)
ville_chance('BÃ©ni Mellal').
ville_chance('Safi').
ville_chance('Khouribga').
ville_chance('El Jadida').
ville_chance('Taza').
ville_chance('Errachidia').
ville_chance('Al Hoceima').

% Localisation des Etablissements Publics
localisation('UniversitÃ© Hassan II', 'Casablanca').
localisation('UniversitÃ© Hassan II', 'Mohammedia').
localisation('UniversitÃ© Mohammed V', 'Rabat').
localisation('UniversitÃ© Cadi Ayyad', 'Marrakech').
localisation('UniversitÃ© Ibn Zohr', 'Agadir').
localisation('UniversitÃ© Abdelmalek EssaÃ¢di', 'TÃ©touan').
localisation('ENSA', 'Agadir').
localisation('ENSA', 'FÃ¨s').
localisation('ENSA', 'Marrakech').
localisation('ENSA', 'Tanger').
localisation('ENSA', 'TÃ©touan').
localisation('ENSA', 'Khouribga').
localisation('ENSA', 'Safi').
localisation('ENSA', 'El Jadida').
localisation('ENSA', 'Berrechid').
localisation('ENSA', 'BÃ©ni Mellal').
localisation('ENSA', 'Oujda').
localisation('ENSA', 'Al Hoceima').
localisation('ENSAM', 'MeknÃ¨s').
localisation('ENSAM', 'Casablanca').
localisation('ENSAM', 'Rabat').
localisation('ENSIAS', 'Rabat').
localisation('EMI', 'Rabat').
localisation('FST', 'FÃ¨s').
localisation('FST', 'Settat').
localisation('FST', 'Mohammedia').
localisation('FST', 'BÃ©ni Mellal').
localisation('FST', 'Errachidia').
localisation('UM6P', 'Benguerir').
localisation('UniversitÃ© Al Akhawayn', 'Ifrane').

% Localisation du PrivÃ©
localisation('EMSI', 'Casablanca').
localisation('EMSI', 'Rabat').
localisation('EMSI', 'Marrakech').
localisation('EMSI', 'FÃ¨s').
localisation('UIR', 'Rabat').
localisation('SUPINFO', 'Casablanca').
localisation('HEM', 'Casablanca').
localisation('ESCA', 'Casablanca').
localisation('UIASS', 'Rabat').
localisation('UPSAT', 'Casablanca').

% -------------------------------------------------------
% 3. ECOLES PRIVEES (DÃ©tails & Frais)
% -------------------------------------------------------
detail_ecole('EMSI', 'IngÃ©nierie (PrivÃ©)', 'GÃ©nie Info, Indus, Civil', '28 000 - 38 000 DH/an').
detail_ecole('UIR', 'UniversitÃ© Semi-Public', 'AÃ©ro, Info, Business, Sc.Po', '65 000 - 95 000 DH/an').
detail_ecole('SUPINFO', 'IT (PrivÃ©)', 'Full Stack, Cloud, Cyber', '45 000 - 60 000 DH/an').
detail_ecole('HEM', 'Business (PrivÃ©)', 'Management, Marketing', '35 000 - 60 000 DH/an').
detail_ecole('ESCA', 'Business (PrivÃ©)', 'Finance, Audit', '45 000 - 70 000 DH/an').
detail_ecole('UIASS', 'SantÃ© (Semi-PrivÃ©)', 'MÃ©decine, Dentaire', '80 000 - 130 000 DH/an').
detail_ecole('UPSAT', 'SantÃ© (PrivÃ©)', 'MÃ©decine, Pharma', '70 000 - 110 000 DH/an').
detail_ecole('ISITT PrivÃ©', 'Tourisme', 'Management HÃ´telier', '20 000 - 30 000 DH/an').

% -------------------------------------------------------
% 4. STATISTIQUES & CHIFFRES CLES
% -------------------------------------------------------
stat('Global', 'Etudiants Maroc', '1.25 Million').
stat('Global', 'FiliÃ¨res', '+1000 accrÃ©ditÃ©es').
stat('Places', 'MÃ©decine (Total)', '~4 800 places').
stat('Places', 'MÃ©decine (Casa)', '~200 places').
stat('Places', 'ENSA (Total)', '~4 000 places').
stat('Places', 'ENSA (Casa)', '~350 places').
stat('Places', 'ENSA (BÃ©ni Mellal)', '~150 places').
stat('Selectivite', 'MÃ©decine', '1 admis pour 22 candidats').
stat('Selectivite', 'ENSA', '1 admis pour 21 candidats').
stat('Salaires', 'IngÃ©nieur DÃ©butant', '8 000 - 12 000 DH/mois').
stat('Salaires', 'MÃ©decin Public', '12 000 - 15 000 DH/mois').

% -------------------------------------------------------
% 5. CONSEILS & METHODOLOGIE (info/2) - EXPANDED
% -------------------------------------------------------

% Organisation Personnelle
info('Organisation', 'Fais un planning rÃ©aliste. Ne charge pas trop tes journÃ©es.').
info('Organisation', 'Utilise la mÃ©thode Pomodoro (25min travail / 5min pause).').
info('Organisation', 'Dors au moins 7h/nuit. Le cerveau mÃ©morise en dormant.').
info('Organisation', 'CrÃ©e un agenda hebdomadaire avec horaires fixes pour Ã©tudes et rÃ©visions.').
info('Organisation', 'Planifie cours, rÃ©visions, travaux ET loisirs pour un Ã©quilibre sain.').

% MÃ©thode de Travail
info('MÃ©thode', 'RÃ©vise avec des fiches de synthÃ¨se (formules, dates, dÃ©finitions).').
info('MÃ©thode', 'Pratique sur les ANNALES des annÃ©es prÃ©cÃ©dentes. C\'est crucial.').
info('MÃ©thode', 'Explique ton cours Ã  voix haute (Technique Feynman) pour vÃ©rifier ta comprÃ©hension.').
info('MÃ©thode', 'Travaille en groupe pour renforcer la comprÃ©hension.').
info('MÃ©thode', 'Utilise cartes mentales et rÃ©sumÃ©s visuels pour mÃ©moriser.').

% Gestion Examens
info('Examens', 'RÃ©vise rÃ©guliÃ¨rement (tous les soirs ou chaque semaine) pour Ã©viter le stress de derniÃ¨re minute.').
info('Examens', 'Priorise les matiÃ¨res clÃ©s mais ne nÃ©glige pas les "faciles" qui amÃ©liorent la moyenne.').
info('Examens', 'Divise les chapitres par semaine pour un plan d\'Ã©tude progressif.').
info('Examens', 'Fais des exercices et annales pour te prÃ©parer efficacement.').
info('Examens', 'RÃ©pÃ©tition espacÃ©e : revoir rÃ©guliÃ¨rement les notions pour mÃ©morisation durable.').
info('Examens', 'Auto-Ã©valuation : teste tes connaissances rÃ©guliÃ¨rement pour identifier points faibles.').
info('Examens', 'Questionnement actif : cherche Ã  comprendre "pourquoi" plutÃ´t que "comment".').

% AssiduitÃ© & Participation
info('AssiduitÃ©', 'Assiste Ã  TOUS les cours et TD/TP. L\'absence crÃ©e des lacunes.').
info('AssiduitÃ©', 'Participe activement aux travaux pratiques et projets.').
info('AssiduitÃ©', 'Pose des questions en cours et lors des permanences des profs.').

% Ressources Universitaires
info('Ressources', 'Utilise bibliothÃ¨ques, plateformes en ligne, notes partagÃ©es par anciens.').
info('Ressources', 'Rejoins tutorats ou groupes d\'Ã©tudes pour renforcer tes connaissances.').
info('Ressources', 'Cherche conseils auprÃ¨s des profs sur cours, projets et examens.').

% CompÃ©tences Transversales
info('CompÃ©tences', 'FranÃ§ais et anglais indispensables. Renforce ton niveau via cours ou apps.').
info('CompÃ©tences', 'MaÃ®trise Excel, Word, PowerPoint et logiciels spÃ©cifiques Ã  ta filiÃ¨re.').
info('CompÃ©tences', 'DÃ©veloppe soft skills : organisation, esprit critique, communication, travail en Ã©quipe.').

% StratÃ©gies par FiliÃ¨re
info('Sciences', 'RÃ©vise TOUS les TP et exercices pratiques. Fais des projets persos pour comprendre.').
info('MÃ©decine', 'RÃ©visions continues pour cours volumineux. Groupes de travail pour anatomie/physiologie.').
info('Commerce', 'Pratique cas rÃ©els, Ã©tudes de marchÃ©, exercices financiers.').
info('Lettres', 'Lecture rÃ©guliÃ¨re, rÃ©daction d\'essais, participation dÃ©bats et sÃ©minaires.').

% StratÃ©gie d'Orientation
info('StratÃ©gie', 'Plan A / Plan B : Toujours avoir une filiÃ¨re "SÃ©curitÃ©" (Fac, PrivÃ©) si ton 1er choix Ã©choue.').
info('StratÃ©gie', 'Regarde les dÃ©bouchÃ©s RÃ‰ELS (Offres d\'emploi sur LinkedIn) avant de choisir.').
info('StratÃ©gie', 'Ne suis pas tes amis. Choisis ce qui TE correspond.').
info('StratÃ©gie', 'Pense aux villes "OpportunitÃ©" (BÃ©ni Mellal, Safi...) si ta note est juste.').

% Vie Etudiante & Ã‰quilibre
info('Vie Pro', 'Les stages sont obligatoires pour un bon CV. Cherche dÃ¨s la 1Ã¨re annÃ©e.').
info('Vie Pro', 'Anglais = Salaire. Passe le TOEIC ou TOEFL si tu peux.').
info('Vie Pro', 'RÃ©seaute : rencontre Ã©tudiants, anciens, profs. Participe aux clubs universitaires.').

% SantÃ© & Bien-Ãªtre
info('SantÃ©', 'Dors suffisamment, fais de l\'exercice, mange Ã©quilibrÃ©.').
info('SantÃ©', 'GÃ¨re le stress : respiration, sport, mÃ©ditation ou loisirs.').

% Budget & Bourses
info('Budget', 'Bourses : Minhaty, Erasmus (Europe), Fulbright (USA). Renseigne-toi tÃ´t.').
info('Budget', 'Logement : Les citÃ©s universitaires sont prioritaires pour ceux qui habitent loin.').

% Planification & Objectifs
info('Objectifs', 'Fixe objectifs prÃ©cis : moyenne Ã  atteindre, stages, compÃ©tences.').
info('Objectifs', 'Ã‰value rÃ©guliÃ¨rement tes progrÃ¨s aprÃ¨s chaque examen.').
info('Objectifs', 'Ajuste ta mÃ©thode de travail si nÃ©cessaire.').
info('Objectifs', 'PrÃ©vois Plan B : rattrapage, cours supplÃ©mentaires si besoin.').

% -------------------------------------------------------
% 6. DEFINITIONS (SystÃ¨me LMD)
% -------------------------------------------------------
definition('LMD', 'SystÃ¨me Licence (3 ans) -> Master (+2 ans) -> Doctorat (+3 ans). Standard mondial.').
definition('CPGE', 'Classes PrÃ©pas (2 ans intensifs). PrÃ©pare aux concours des Grandes Ecoles d\'ingÃ©nieurs (CNC).').
definition('BTS', 'Brevet Technicien SupÃ©rieur (2 ans). Formation courte, pratique, bonne insertion pro.').
definition('DUT', 'DiplÃ´me Universitaire Technologie (2 ans). Souvent en EST. Plus acadÃ©mique que le BTS.').
definition('Master', 'Bac+5. SpÃ©cialisation nÃ©cessaire pour les postes de cadres/responsabilitÃ©.').
definition('IngÃ©nieur', 'Titre protÃ©gÃ© Bac+5. Formation technique et managÃ©riale de haut niveau.').
definition('ENSA', 'Ecole Nationale des Sciences AppliquÃ©es (5 ans). Formation d\'ingÃ©nieur d\'Ã©tat. AccÃ¨s post-bac ou bac+2.').
definition('ENCG', 'Ecole Nationale de Commerce et de Gestion (5 ans). Formation management/commerce. AccÃ¨s par concours TAFEM.').
definition('EST', 'Ecole SupÃ©rieure de Technologie (2 ans). DÃ©livre le DUT. Formation technique courte.').
definition('FST', 'FacultÃ© des Sciences et Techniques. SystÃ¨me LMD hybride (Tronc commun + SpÃ©cialitÃ©). AccÃ¨s sur dossier.').
definition('OFPPT', 'Office de la Formation Professionnelle. Formations courtes (2 ans) type Technicien SpÃ©cialisÃ©. Pratique et insertion rapide.').
definition('CPGE', 'Classes PrÃ©pas aux Grandes Ecoles (2 ans). Voie d\'excellence pour intÃ©grer les meilleures Ã©coles d\'ingÃ©nieurs (Maroc/France).').

% -------------------------------------------------------
% API LOGIQUE (Predicats appelÃ©s par Python)
% -------------------------------------------------------

% Recommandation simple
recommander_orientation(Bac, Domaine, Ecole) :-
    debouche(Bac, Domaine, Ecole, _).

% Extraction de conseils par thÃ¨me
conseil(Theme, Texte) :- info(Theme, Texte).

% =======================================================
% 7. STRATEGIE AVANCEE (Nouvelle Logique)
% =======================================================

% Types d'Ã©tablissements & Pros/Cons
info_type(public_ouvert, 
    'FiliÃ¨res ouvertes (Facs, Droit, Eco). Pas de sÃ©lection.',
    'âœ… Gratuit, Large choix, Accessible tous niveaux.',
    'âš ï¸� Effectifs chargÃ©s, Moins de suivi, Peu de stages.').

info_type(public_regule, 
    'FiliÃ¨res sÃ©lectives (MÃ©decine, ENSA, ENCG). Concours.',
    'âœ… DiplÃ´me prestigieux, Excellent insertion pro, Gratuit.',
    'âš ï¸� TrÃ©s forte concurrence, Stress, SÃ©lection dure.').

info_type(prive, 
    'Ecoles privÃ©es (UIR, EMSI, HEM...). Payant.',
    'âœ… AccÃ¨s plus souple, Programmes modernes, Stages intÃ©grÃ©s.',
    'âš ï¸� CoÃ»t Ã©levÃ©, VÃ©rifier la reconnaissance du diplÃ´me.').

% Logique de StratÃ©gie (strategie_profil/3)
% Usage: strategie_profil(Note, Bac, Conseil).

% Cas 1 : Excellente moyenne (>15)
strategie_profil(Note, Bac, 'ðŸŒŸ Profil EXCELLENT : Visez les filiÃ¨res RÃ‰GULÃ‰ES (Public).\nðŸ‘‰ MÃ©decine, ENSA, ENCG, CPGE.\nðŸ‘‰ Visez les grandes villes (Rabat, Casa) mais gardez un Plan B.') :-
    Note >= 15.

% Cas 2 : Bonne moyenne (13-15)
strategie_profil(Note, Bac, 'ðŸ“ˆ Profil BON : StratÃ©gie de "Contournement".\nðŸ‘‰ Visez les filiÃ¨res rÃ©gulÃ©es dans les VILLES MOYENNES (Safi, Khouribga, El Jadida) oÃ¹ la concurrence est moindre.\nðŸ‘‰ Pensez aux FST qui sont un excellent compromis.') :-
    Note >= 13, Note < 15.

% Cas 3 : Moyenne Moyenne (11-13)
strategie_profil(Note, _, 'ðŸ¤” Profil MOYEN : Choix Tactique nÃ©cessaire.\nðŸ‘‰ 1. UniversitÃ©s Publiques (FiliÃ¨res Ouvertes) pour exceller et tenter des passerelles.\nðŸ‘‰ 2. Ecoles PrivÃ©es (si budget) pour un encadrement plus serrÃ©.\nðŸ‘‰ 3. EST/BTS pour un diplÃ´me court et pro.') :-
    Note >= 11, Note < 13.

% Cas 4 : Moyenne Juste (<11)
strategie_profil(Note, _, 'âš ï¸� Profil JUSTE : Ne prenez pas de risques.\nðŸ‘‰ PrivilÃ©giez un BTS/DTS (OFPPT) pour un mÃ©tier rapide.\nðŸ‘‰ Ou une Ã©cole PrivÃ©e qui mise sur la pratique.\nðŸ‘‰ Evitez les facs surchargÃ©es si vous manquez d\'autonomie.') :-
    Note < 11.

% Helpers
get_info_type(T, D, A, I) :- info_type(T, D, A, I).
get_strategie_profil(N, B, C) :- strategie_profil(N, B, C).

% =======================================================
% 8. PROFILS BAC DETAILLES (Nouveau)
% =======================================================
% detail_bac(Bac, Ideales, Avantages, Limites, Conseil).

detail_bac('PC', 
    'IngÃ©nierie (ENSA, EMI...), Informatique/IT, Sciences fondamentales.',
    'âœ… AccÃ¨s Ã  presque toutes les filiÃ¨res scientifiques. Bonne base pour concours.',
    'âš ï¸� Concurrence Ã©levÃ©e en ingÃ©nierie.',
    'ðŸ’¡ IdÃ©al si motivÃ© par les sciences exactes. Moyenne >= 13-14 recommandÃ©e pour le public sÃ©lectif.').

detail_bac('SVT',
    'MÃ©decine, Pharmacie, Dentaire, Biologie, ParamÃ©dical.',
    'âœ… Voie royale pour la SantÃ©. Profil polyvalent.',
    'âš ï¸� Difficile pour l\'ingÃ©nierie mÃ©canique/info pure dans le public.',
    'ðŸ’¡ Moyenne >= 14-15 impÃ©rative pour MÃ©decine. Sinon, viser le PrivÃ© ou les filiÃ¨res Bio.').

detail_bac('SM',
    'Maths, Statistique, Data Science, IngÃ©nierie Top Niveau, Architecture.',
    'âœ… TrÃ¨s polyvalent. AccÃ¨s privilÃ©giÃ© aux PrÃ©pas (MPSI) et Grandes Ecoles.',
    'âš ï¸� Rythme intense.',
    'ðŸ’¡ Excellent pour combiner sciences et Ã©conomie/finance de haut niveau.').

detail_bac('ECO',
    'Economie, Gestion, Commerce (ENCG/ISCAE), Droit, Finance.',
    'âœ… DÃ©bouchÃ©s nombreux en entreprise. FiliÃ¨res bancaires.',
    'âš ï¸� Difficile pour l\'ingÃ©nierie et les sciences dures.',
    'ðŸ’¡ Viser les Ã©coles de commerce sÃ©lectives si bonne note. Sinon, Fac d\'Eco/Droit.').

detail_bac('LITT',
    'Lettres, Langues, Communication, Journalisme, Sciences Humaines, Droit.',
    'âœ… AccÃ¨s aux mÃ©tiers de la culture, mÃ©dias et enseignement.',
    'âš ï¸� Difficile pour l\'informatique et les sciences.',
    'ðŸ’¡ Explorer les Ã©coles privÃ©es pour les programmes modernes (Com, Digital Media).').

% Helper pour Python
get_detail_bac(Bac, I, A, L, C) :- detail_bac(Bac, I, A, L, C).
    
% =======================================================
% 9. PROFILS DOMAINE DETAILLES (Nouveau)
% =======================================================
% detail_domaine(Domaine, Metiers, Ecoles, Conseil).

detail_domaine(medecine,
    'MÃ©decin, Pharmacien, Dentiste, Recherche biomÃ©dicale.',
    'UniversitÃ©s (Rabat, Casa...), FMP, FMD.',
    'ðŸ’¡ Moyenne Bac >= 14-15 pour le Public. Villes moyennes plus accessibles.').

detail_domaine(ingenierie,
    'IngÃ©nieur Civil, MÃ©canique, Indus, Data Scientist.',
    'ENSA, EMI, ENSIAS, UM6P. (Toutes villes).',
    'ðŸ’¡ Bac PC ou SM recommandÃ©. Moyenne >= 13-15 selon ville.').

detail_domaine(informatique,
    'DÃ©veloppeur, Data Scientist, CybersÃ©curitÃ©, Consultant.',
    'EMSI, SUPINFO, UIR, ENSIAS, INPT.',
    'ðŸ’¡ Bac PC/SM (ou ES expert Maths). PrivÃ© efficace pour insertion rapide. âš ï¸� Forte demande du marchÃ© mais besoin de mise Ã  jour constante.').

detail_domaine(commerce,
    'Manager, Analyste Financier, Auditeur, Marketing, RH.',
    'ENCG, ISCAE, HEM, ESCA, UIR.',
    'ðŸ’¡ Bac ES ou SM recommandÃ©. Anglais crucial.').

detail_domaine(shs,
    'Enseignant, Psychologue, Journaliste, RH, Administration.',
    'FacultÃ©s des Lettres & Sciences Humaines (FLSH), Droit.',
    'ðŸ’¡ Bac LITT ou ES. Penser au Master pour se spÃ©cialiser.').

detail_domaine(archi,
    'Architecte, Urbaniste, Designer, Styliste.',
    'ENA, Beaux-Arts, Ecoles privÃ©es d\'Architecture.',
    'ðŸ’¡ Bac LITT ou ES (profil artistique). Portfolio recommandÃ©.').

detail_domaine(tourisme,
    'Manager HÃ´telier, Logistique, Agence de Voyage, EvÃ©nementiel.',
    'ISITT (Tanger), Ecoles privÃ©es de Tourisme.',
    'ðŸ’¡ Bac ES ou SM. Stages pratiques indispensables.').

% Helpers
get_detail_domaine(D, M, E, C) :- detail_domaine(D, M, E, C).
% Overload for Info which has 4 args in Description logic above but Prolog needs constant arity implies we mostly stick to 3 descriptive fields.
% Let's standardize on 3 fields: Metiers, Ecoles, Conseil.
% Added 4th arg for IT above by mistake in draft? No, let's keep it simple.
% Retrying IT without 4th arg to match others or update predicate.
% I will use 3 args for content: Metiers, Ecoles, Conseil.
% If I need extra 'Avantage', I'll squeeze in Conseil or split.
% User input had "Avantages" separate in previous turn but here inputs for domains are: Debouches, Ecoles, Conseil.
% IT input had "Conseil: Bac PC... Options privÃ©es...".
% I'll merge advice.

% Corrected logic (Standard Arity 3 for display simplicity + Key):
% detail_domaine(Key, Metiers, Ecoles, Conseil).

% =======================================================
% 10. CHOIX DE LANGUE D'ENSEIGNEMENT
% =======================================================
% choix_langue(Langue, Description, Avantages, Inconvenients, Conseil).

choix_langue(francais,
    'Langue dominante dans les filiÃ¨res scientifiques, techniques, mÃ©dicales et commerciales.',
    'âœ… FacilitÃ© d\'intÃ©gration universitÃ©s publiques/privÃ©es. Reconnaissance internationale (Europe francophone). AccÃ¨s large aux filiÃ¨res sÃ©lectives.',
    'âš ï¸� Niveau faible nÃ©cessite renforcement linguistique.',
    'ðŸ’¡ Continuer en franÃ§ais si niveau >= B2. TrÃ¨s recommandÃ© pour sciences et techniques.').

choix_langue(anglais,
    'Langue d\'enseignement dans IT, business international, sciences de l\'ingÃ©nieur (UIR, UM6P, EMSI).',
    'âœ… Ouverture internationale. OpportunitÃ©s stage Ã  l\'Ã©tranger. Obligatoire pour recherche scientifique et numÃ©rique.',
    'âš ï¸� Moins de cours dans universitÃ©s publiques traditionnelles. Niveau B2/C1 requis.',
    'ðŸ’¡ Opter pour anglais si IT, data science, commerce international ou Ã©tudes Ã  l\'Ã©tranger.').

choix_langue(arabe,
    'Principalement pour filiÃ¨res littÃ©raires, droit, sciences islamiques, filiÃ¨res sociales.',
    'âœ… Plus facile si excellent niveau arabe. AdaptÃ© lettres, droit national, sociologie, histoire.',
    'âš ï¸� Limite internationalisation. Moins adaptÃ© sciences et techniques.',
    'ðŸ’¡ Choisir arabe si motivÃ© par filiÃ¨res littÃ©raires/sociales/juridiques nationales.').

% Helper
get_choix_langue(L, D, A, I, C) :- choix_langue(L, D, A, I, C).

% =======================================================
% 11. CONCOURS & EXAMENS D'ADMISSION
% =======================================================
% concours_admission(Type, Exigences, Conseil).

concours_admission(medecine,
    'SÃ©lection sur dossier acadÃ©mique (moyenne bac, notes scientifiques). Concours Ã©crit/oral dans certaines universitÃ©s (Casa, FÃ¨s).',
    'ðŸ’¡ PrÃ©pare intensivement SVT, physique-chimie, maths. Stages scientifiques renforcent le dossier.').

concours_admission(ingenierie_public,
    'Concours post-bac basÃ© sur dossier + tests logique et mathÃ©matiques. Tests maths avancÃ©es, physique, franÃ§ais/anglais.',
    'ðŸ’¡ Bac PC/SM recommandÃ©. RÃ©visions ciblÃ©es maths, physique, logique. EntraÃ®ne-toi avec annales.').

concours_admission(ecoles_privees,
    'Tests admission internes : logique, maths, anglais, franÃ§ais. Entretien oral/motivationnel (HEM, UM6P).',
    'ðŸ’¡ MÃªme avec bonne moyenne, prÃ©pare test et entretien. Pratique exercices logique et simulations entretien.').

concours_admission(commerce,
    'Test Ã©crit aptitude : maths, logique, anglais/franÃ§ais. Entretien individuel ou Ã©tude de cas.',
    'ðŸ’¡ PrÃ©pare tests numÃ©riques, logique, culture gÃ©nÃ©rale. Ateliers ou cours prÃ©paratoires recommandÃ©s.').

% StratÃ©gie gÃ©nÃ©rale concours
info('Concours', 'Identifie toutes les Ã©coles visÃ©es et leurs exigences spÃ©cifiques.').
info('Concours', 'Planifie prÃ©paration concours parallÃ¨lement aux rÃ©visions bac.').
info('Concours', 'Simule examens avec annales et tests en ligne.').
info('Concours', 'PrÃ©vois Plan B : Ã©coles ouvertes ou moins sÃ©lectives en cas de non-admission.').

% Helper
get_concours_admission(T, E, C) :- concours_admission(T, E, C).

% =======================================================
% 12. ETUDES COURTES VS LONGUES
% =======================================================
% duree_etudes(Type, Description, Avantages, Inconvenients, Conseil).

duree_etudes(courtes,
    'DurÃ©e 2-3 ans (BTS, DUT, Licence pro). Objectif : compÃ©tences pratiques rapides.',
    'âœ… Insertion rapide marchÃ© travail. Moins exigeant (moyenne bac). Tester domaine. Frais moins Ã©levÃ©s.',
    'âš ï¸� DiplÃ´me moins valorisÃ© pour postes responsabilitÃ©. Moins de recherche/acadÃ©mique. Master parfois nÃ©cessaire.',
    'ðŸ’¡ IdÃ©al pour insertion rapide ou si moyenne limite accÃ¨s filiÃ¨res longues. Bien choisir spÃ©cialitÃ© selon dÃ©bouchÃ©s et stages.').

duree_etudes(longues,
    'DurÃ©e 5-8 ans (IngÃ©nieur 5 ans, MÃ©decine 7 ans). Objectif : niveau avancÃ© et spÃ©cialisÃ©.',
    'âœ… DiplÃ´mes trÃ¨s valorisÃ©s. Reconnaissance nationale/internationale. Postes responsabilitÃ©. PossibilitÃ© Master/Doctorat.',
    'âš ï¸� DurÃ©e longue (engagement). Concurrence Ã©levÃ©e. Stress et charge travail importante.',
    'ðŸ’¡ Choisir si forte motivation, aptitudes acadÃ©miques solides, plan carriÃ¨re clair. Ã‰valuer capacitÃ© gÃ©rer Ã©tudes exigeantes.').

% CritÃ¨res de choix
info('DurÃ©e Ã‰tudes', 'Moyenne Ã©levÃ©e + Bac PC/SM â†’ Ã©tudes longues scientifiques/ingÃ©nierie possibles.').
info('DurÃ©e Ã‰tudes', 'Moyenne moyenne â†’ Ã©tudes courtes pour sÃ©curiser insertion.').
info('DurÃ©e Ã‰tudes', 'RapiditÃ© insertion â†’ Ã©tudes courtes. SpÃ©cialisation/responsabilitÃ© â†’ Ã©tudes longues.').
info('DurÃ©e Ã‰tudes', 'Ã‰tudes longues demandent organisation, endurance, persÃ©vÃ©rance.').
info('DurÃ©e Ã‰tudes', 'Plan A (longues) si moyenne/motivation suffisantes. Plan B (courtes) avec possibilitÃ© Master plus tard.').

% Helper
get_duree_etudes(T, D, A, I, C) :- duree_etudes(T, D, A, I, C).

% =======================================================
% 13. STAGES & EXPERIENCES PRATIQUES PAR FILIERE
% =======================================================
% stages_filiere(Filiere, Stages, Avantages).

stages_filiere(medecine,
    'Stages hospitaliers/cliniques dÃ¨s 2áµ‰-3áµ‰ annÃ©e. TP laboratoire (bio, chimie, pharmacologie). Internats/stages fin Ã©tudes.',
    'âœ… PrÃ©paration directe marchÃ© travail. ExpÃ©rience pratique indispensable pour carriÃ¨re.').

stages_filiere(ingenierie,
    'PFE (Projet Fin Ã‰tudes) obligatoire. Stages entreprise dÃ¨s 3áµ‰-4áµ‰ annÃ©e. Labos et TP par spÃ©cialitÃ©.',
    'âœ… CompÃ©tences techniques/professionnelles. Embauche possible via rÃ©seau entreprises partenaires.').

stages_filiere(informatique,
    'Projets pratiques dÃ¨s 1Ê³áµ‰ annÃ©e. Stages entreprise/start-up/labo recherche. Hackathons et projets collaboratifs.',
    'âœ… ExpÃ©rience rÃ©elle dev/cyber/data. Insertion professionnelle rapide aprÃ¨s diplÃ´me.').

stages_filiere(commerce,
    'Stages entreprise/banques/assurances/conseil. TP : Ã©tudes marchÃ©, analyses financiÃ¨res. Alternances (HEM, ESCA, UIR).',
    'âœ… Facilite insertion pro. DÃ©veloppe compÃ©tences rÃ©elles et rÃ©seau professionnel.').

stages_filiere(shs,
    'Travaux terrain, enquÃªtes, projets recherche. Stages ONG/collectivitÃ©s/mÃ©dias/associations. MÃ©thodologie recherche appliquÃ©e.',
    'âœ… Mise en pratique concepts thÃ©oriques. CompÃ©tences organisationnelles et analytiques.').

stages_filiere(arts,
    'Projets studio/labo crÃ©atif. Stages agences/studios design/cabinets architecture. Expositions et concours.',
    'âœ… Portfolio professionnel prÃªt. ExpÃ©rience concrÃ¨te pour entreprises crÃ©atives.').

stages_filiere(tourisme,
    'Stages obligatoires hÃ´tels/agences/transport. Projets : organisation Ã©vÃ©nements, gestion circuits touristiques.',
    'âœ… Acquisition rapide expÃ©rience pro. RÃ©seautage entreprises locales/internationales.').

% Conseils gÃ©nÃ©raux stages
info('Stages', 'VÃ©rifie avant inscription : quelles Ã©coles intÃ¨grent rÃ©ellement des stages.').
info('Stages', 'Priorise filiÃ¨res avec alternance ou projets pratiques pour insertion rapide.').
info('Stages', 'Planifie tÃ´t : stages dÃ¨s 1Ê³áµ‰ annÃ©e pour acquÃ©rir maximum expÃ©rience.').
info('Stages', 'RÃ©seautage et mentorat : profite des stages pour contacts professionnels futurs.').

% Helper
get_stages_filiere(F, S, A) :- stages_filiere(F, S, A).

% =======================================================
% 14. FINANCEMENT & BOURSES
% =======================================================
% financement(Type, Description, Conseil).

financement(public,
    'Frais trÃ¨s faibles (quelques centaines DH/semestre). IdÃ©al budget limitÃ©.',
    'ðŸ’¡ Accessible moyens modestes. PossibilitÃ© aides sociales universitaires.').

financement(bourses_gouvernementales,
    'Bourses mÃ©rite (notes bac/excellence) et bourses sociales (revenus faibles). Allocation mensuelle ou frais rÃ©duits.',
    'ðŸ’¡ VÃ©rifier critÃ¨res et dates limites chaque annÃ©e sur site ministÃ¨re/universitÃ©.').

financement(bourses_privees,
    'Ã‰coles privÃ©es (EMSI, UIR, HEM) : bourses partielles/totales selon mÃ©rite/besoins. Plans paiement Ã©chelonnÃ©. Fondations (OCP, BMCE, UM6P).',
    'ðŸ’¡ Bourses basÃ©es sur mÃ©rite, projet acadÃ©mique ou situation sociale.').

financement(international,
    'Erasmus+, Fulbright, Chevening, DAAD, Campus France. Couvrent frais scolaritÃ©, logement, voyage.',
    'ðŸ’¡ VÃ©rifier critÃ¨res linguistiques/acadÃ©miques. PrÃ©parer un an Ã  l\'avance (dossier, tests, motivation).').

financement(personnel,
    'Travail Ã©tudiant (tutorat, freelance). PrÃªts Ã©tudiants banques marocaines (taux rÃ©duits). Ã‰conomies famille.',
    'ðŸ’¡ Planifier budget. Combiner plusieurs sources : bourse + travail + aide familiale.').

% Conseils gÃ©nÃ©raux financement
info('Financement', 'Planification : identifier toutes sources financement avant inscription.').
info('Financement', 'Dossier solide pour bourses mÃ©rite : bonnes notes, lettres motivation, projet clair.').
info('Financement', 'Suivi dates : respecter Ã©chÃ©ances candidatures et documents.').
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
date_concours('Inscription OFPPT', 'Avril - Juin (1Ã¨re session)').
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
procedure('Inscription Fac', '1. PrÃ©-inscription sur site universitÃ©. 2. DÃ©pÃ´t dossier (Bac original, RelevÃ© notes, CIN, Photos). 3. ReÃ§u inscription.').
procedure('Dossier Minhaty', '1. Inscription sur minhaty.ma. 2. DÃ©pÃ´t dossier physique (Attestation revenu parents, Certificat rÃ©sidence...) auprÃ¨s des autoritÃ©s locales / LycÃ©e.').
procedure('Legalisation', 'Toujours lÃ©galiser les copies du Bac et RelevÃ©s de notes Ã  la commune (Moqatia). Garder plusieurs copies d\'avance.').

get_procedure(T, D) :- procedure(T, D).

% =======================================================
% 19. LOGEMENT ETUDIANT
% =======================================================
% logement(Type, Description, Conseil).
logement('Cite Universitaire', 'Logement public subventionnÃ©. ~40-50 DH/mois. PrioritÃ© aux boursiers et Ã©loignÃ©s.', 'ðŸ’¡ Demande Ã  faire via l\'Office National (ONOUHC). Places limitÃ©es.').
logement('Internat', 'Disponible dans certaines prÃ©pas (CPGE) et lycÃ©es d\'excellence.', 'ðŸ’¡ Renseigne-toi directement auprÃ¨s de l\'Ã©tablissement.').
logement('Location Privee', 'Chambre ou appartement partagÃ©. CoÃ»t variable (1000-3000 DH).', 'ðŸ’¡ Cherche des colocations pour rÃ©duire frais. Proche transport/Ã©cole.').
logement('Bayt Al Maarifa', 'RÃ©sidences Ã©tudiantes privÃ©es/publiques de bon standing.', 'ðŸ’¡ Plus cher mais sÃ©curisÃ© et Ã©quipÃ©.').

get_logement(T, D, C) :- logement(T, D, C).

% =======================================================
% 20. FORMATION PROFESSIONNELLE (OFPPT)
% =======================================================
% formation_pro(Niveau, Description, Conseil).
formation_pro('Technicien Specialise', 'Bac requis. 2 ans. DiplÃ´me TS. AccÃ¨s aux Licences Pro possible.', 'ðŸ’¡ Top filiÃ¨res : DÃ©v Digital, Gestion Entreprise, Diagnostic Auto.').
formation_pro('Technicien', 'Niveau Bac (sans bac). 2 ans. MÃ©tiers techniques.', 'ðŸ’¡ ElectricitÃ©, MÃ©canique, Cuisine. Insertion rapide.').
formation_pro('Qualification', 'Niveau 3Ã¨me collÃ©giale. MÃ©tiers manuels.', 'ðŸ’¡ Plomberie, Soudure, RÃ©paration.').

get_formation_pro(N, D, C) :- formation_pro(N, D, C).

%     B A S E   D E   C O N N A I S S A N C E S   ( V e r s i o n   2 ) 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   1 .   S Ã 0 R I E S   D E   B A C C A L A U R Ã 0 A T 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 s e r i e _ b a c ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   B ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   p h y s i q u e s ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   a g r i c o l e s ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   Ã © c o n o m i q u e s ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   d e   g e s t i o n   c o m p t a b l e ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   e t   t e c h n o l o g i e s   Ã © l e c t r i q u e s ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   e t   t e c h n o l o g i e s   m Ã © c a n i q u e s ' ) . 
 
 s e r i e _ b a c ( ' A r t s   a p p l i q u Ã © s ' ) . 
 
 s e r i e _ b a c ( ' L e t t r e s ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   h u m a i n e s ' ) . 
 
 s e r i e _ b a c ( ' L a n g u e   a r a b e ' ) . 
 
 s e r i e _ b a c ( ' S c i e n c e s   d e   l a   c h a r i a ' ) . 
 
 s e r i e _ b a c ( ' B a c   P r o   I n d u s t r i e l ' ) . 
 
 s e r i e _ b a c ( ' B a c   P r o   S e r v i c e s ' ) . 
 
 s e r i e _ b a c ( ' B a c   P r o   A g r i c u l t u r e ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   2 .   S E C T E U R S   D E   F O R M A T I O N 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 s e c t e u r _ f o r m a t i o n ( ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' A g r i c u l t u r e ,   Ã © l e v a g e   e t   m Ã © d e c i n e   v Ã © t Ã © r i n a i r e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' A r c h i t e c t u r e   e t   T r a v a u x   P u b l i c s ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S e c t e u r   m i l i t a i r e   e t   p a r a m i l i t a i r e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S e c t e u r   d u   t r a v a i l   s o c i a l ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' T o u r i s m e   e t   h Ã ´ t e l l e r i e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' A r t s ,   C u l t u r e   e t   P a t r i m o i n e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' A u d i o v i s u e l   e t   C i n Ã © m a ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S p o r t   e t   Ã 0 d u c a t i o n   P h y s i q u e ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' L a n g u e s ,   L e t t r e s   e t   S c i e n c e s   H u m a i n e s ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S e c t e u r   d e   l ' ' Ã © d u c a t i o n ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' S c i e n c e s   r e l i g i e u s e s ' ) . 
 
 s e c t e u r _ f o r m a t i o n ( ' D Ã © v e l o p p e m e n t   D i g i t a l   e t   I A ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   3 .   Ã 0 T A B L I S S E M E N T S   P U B L I C S   ( S t a n d a r d i s Ã © s   p a r   A c r o n y m e s ) 
 
 %   F o r m a t :   e t a b l i s s e m e n t ( A c r o n y m e ,   V i l l e ,   D i p l o m e ,   D u r e e ,   A c c e s ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   - - -   I n g Ã © n i e r i e   ( E N S A ,   E N S A M ,   F S T )   - - - 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' T a n g e r ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' A g a d i r ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' O u j d a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' M a r r a k e c h ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' S a f i ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' F Ã ¨ s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' K h o u r i b g a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' K Ã © n i t r a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' T Ã © t o u a n ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' E l   J a d i d a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' A l   H o c e i m a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' B e r r c h i d ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A ' ,   ' B e n i   M e l l a l ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A M ' ,   ' M e k n Ã ¨ s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A M ' ,   ' C a s a b l a n c a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S A M ' ,   ' R a b a t ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' M o h a m m e d i a ' ,   ' D E U S T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' M o h a m m e d i a ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   5 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' S e t t a t ' ,   ' D E U S T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' F Ã ¨ s ' ,   ' D E U S T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' M a r r a k e c h ' ,   ' D E U S T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' F S T ' ,   ' T a n g e r ' ,   ' D E U S T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 %   - - -   N o u v e l l e s   Ã 0 c o l e s   d ' I n g Ã © n i e u r s   S p Ã © c i a l i s Ã © e s   - - - 
 
 e t a b l i s s e m e n t ( ' E N I A D ' ,   ' B e r k a n e ' ,   ' I n g Ã © n i e u r   I A ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N S C ' ,   ' K Ã © n i t r a ' ,   ' I n g Ã © n i e u r   C h i m i e ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E S I T H ' ,   ' C a s a b l a n c a ' ,   ' I n g Ã © n i e u r   T e x t i l e ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E S I T H ' ,   ' C a s a b l a n c a ' ,   ' L i c e n c e   P r o ' ,   3 ,   ' s e l e c t i o n ' ) . 
 
 %   - - -   C o m m e r c e   ( E N C G ,   I S C A E )   - - - 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' S e t t a t ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' T a n g e r ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' A g a d i r ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' M a r r a k e c h ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' O u j d a ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' K Ã © n i t r a ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' E l   J a d i d a ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' F Ã ¨ s ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' C a s a b l a n c a ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' D a k h l a ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' B e n i   M e l l a l ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N C G ' ,   ' M e k n Ã ¨ s ' ,   ' D i p l Ã ´ m e   E N C G ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I S C A E ' ,   ' C a s a b l a n c a ' ,   ' D i p l Ã ´ m e   G r a n d e   Ã 0 c o l e ' ,   3 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 %   - - -   M Ã © d e c i n e   &   S a n t Ã ©   - - - 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' R a b a t ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' C a s a b l a n c a ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' M a r r a k e c h ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' F Ã ¨ s ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' O u j d a ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' T a n g e r ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' A g a d i r ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' R a b a t ' ,   ' D o c t o r a t   e n   P h a r m a c i e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M P ' ,   ' C a s a b l a n c a ' ,   ' D o c t o r a t   e n   P h a r m a c i e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M D ' ,   ' R a b a t ' ,   ' D o c t o r a t   D e n t a i r e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' F M D ' ,   ' C a s a b l a n c a ' ,   ' D o c t o r a t   D e n t a i r e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I S P I T S ' ,   ' M u l t i - v i l l e s ' ,   ' L i c e n c e   I n f i r m i e r ' ,   3 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I 3 S ' ,   ' S e t t a t ' ,   ' L i c e n c e   S c .   S a n t Ã © ' ,   3 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 %   - - -   F a c u l t Ã © s   ( A c c Ã ¨ s   D i r e c t )   - - - 
 
 e t a b l i s s e m e n t ( ' F a c u l t Ã ©   d e s   S c i e n c e s ' ,   ' R a b a t ' ,   ' D E U G ' ,   2 ,   ' d i r e c t ' ) . 
 
 e t a b l i s s e m e n t ( ' F a c u l t Ã ©   d e s   S c i e n c e s ' ,   ' R a b a t ' ,   ' L i c e n c e   F o n d a m e n t a l e ' ,   3 ,   ' d i r e c t ' ) . 
 
 e t a b l i s s e m e n t ( ' F a c u l t Ã ©   d e s   S c i e n c e s ' ,   ' C a s a b l a n c a ' ,   ' L i c e n c e   F o n d a m e n t a l e ' ,   3 ,   ' d i r e c t ' ) . 
 
 e t a b l i s s e m e n t ( ' F S J E S ' ,   ' M u l t i - v i l l e s ' ,   ' L i c e n c e   D r o i t / Ã 0 c o ' ,   3 ,   ' d i r e c t ' ) . 
 
 e t a b l i s s e m e n t ( ' F L S H ' ,   ' M u l t i - v i l l e s ' ,   ' L i c e n c e   L e t t r e s ' ,   3 ,   ' d i r e c t ' ) . 
 
 %   - - -   P r Ã © p a s   &   A u t r e s   - - - 
 
 e t a b l i s s e m e n t ( ' C P G E ' ,   ' M u l t i - v i l l e s ' ,   ' C P G E ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' E S T ' ,   ' M u l t i - v i l l e s ' ,   ' D U T ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' B T S ' ,   ' M u l t i - v i l l e s ' ,   ' B T S ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 e t a b l i s s e m e n t ( ' O F P P T ' ,   ' M u l t i - v i l l e s ' ,   ' T e c h n i c i e n   S p Ã © c i a l i s Ã © ' ,   2 ,   ' s e l e c t i o n ' ) . 
 
 %   - - -   S e c t e u r   M i l i t a i r e   - - - 
 
 e t a b l i s s e m e n t ( ' A R M ' ,   ' M e k n Ã ¨ s ' ,   ' O f f i c i e r   ( B a c + 5 ) ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E R A ' ,   ' M a r r a k e c h ' ,   ' O f f i c i e r   P i l o t e ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E R N ' ,   ' C a s a b l a n c a ' ,   ' O f f i c i e r   M a r i n e ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E R S S M ' ,   ' R a b a t ' ,   ' M Ã © d e c i n   M i l i t a i r e ' ,   7 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 %   - - -   A r t s   &   S p o r t   - - - 
 
 e t a b l i s s e m e n t ( ' I N B A ' ,   ' T Ã © t o u a n ' ,   ' D i p l Ã ´ m e   B e a u x - A r t s ' ,   4 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I S A D A C ' ,   ' R a b a t ' ,   ' D i p l Ã ´ m e   A r t   D r a m a t i q u e ' ,   4 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I R F C / J S ' ,   ' S a l Ã © ' ,   ' L i c e n c e   P r o   S p o r t ' ,   3 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 %   - - -   A r c h i t e c t u r e   &   U r b a n i s m e   - - - 
 
 e t a b l i s s e m e n t ( ' E N A ' ,   ' R a b a t ' ,   ' A r c h i t e c t e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N A ' ,   ' F Ã ¨ s ' ,   ' A r c h i t e c t e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' E N A ' ,   ' M a r r a k e c h ' ,   ' A r c h i t e c t e ' ,   6 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 e t a b l i s s e m e n t ( ' I N A U ' ,   ' R a b a t ' ,   ' D i p l Ã ´ m e   U r b a n i s m e ' ,   5 ,   ' s e l e c t i o n _ c o n c o u r s ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   4 .   F I L I Ã ÆR E S   D E   F O R M A T I O N   ( L i e n   B a c   - >   F o r m a t i o n ) 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   = = =   P o u r   B a c   S c i e n c e s   M a t h s   A   &   B   = = = 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   I n f o r m a t i q u e ' ,   ' E N S A ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   C i v i l ' ,   ' E H T P ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' C l a s s e s   P r Ã © p a s   M P S I ' ,   ' C P G E ' ,   ' 2   a n s ' ,   ' C P G E ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ,   ' A r c h i t e c t u r e   e t   T r a v a u x   P u b l i c s ' ,   ' A r c h i t e c t u r e ' ,   ' E N A ' ,   ' 6   a n s ' ,   ' A r c h i t e c t e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   A ' ,   ' S e c t e u r   m i l i t a i r e   e t   p a r a m i l i t a i r e ' ,   ' O f f i c i e r   I n g Ã © n i e u r ' ,   ' A R M ' ,   ' 5   a n s ' ,   ' O f f i c i e r ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   B ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   I n d u s t r i e l ' ,   ' E N S A ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   m a t h Ã © m a t i q u e s   B ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' P i l o t a g e ' ,   ' E R A ' ,   ' 5   a n s ' ,   ' O f f i c i e r   P i l o t e ' ) . 
 
 %   = = =   P o u r   B a c   S c i e n c e s   P h y s i q u e s   ( P C )   = = = 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   M Ã © c a t r o n i q u e ' ,   ' E N S A ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   M Ã © c a n i q u e ' ,   ' E N S A M ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' I n t e l l i g e n c e   A r t i f i c i e l l e ' ,   ' E N I A D ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   I A ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' C l a s s e s   P r Ã © p a s   P C S I ' ,   ' C P G E ' ,   ' 2   a n s ' ,   ' C P G E ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ,   ' S o i n s   I n f i r m i e r s ' ,   ' I S P I T S ' ,   ' 3   a n s ' ,   ' L i c e n c e   I n f i r m i e r ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ,   ' K i n Ã © s i t h Ã © r a p i e ' ,   ' I S P I T S ' ,   ' 3   a n s ' ,   ' L i c e n c e   K i n Ã © ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   p h y s i q u e s ' ,   ' S e c t e u r   m i l i t a i r e   e t   p a r a m i l i t a i r e ' ,   ' O f f i c i e r   M a r i n e ' ,   ' E R N ' ,   ' 5   a n s ' ,   ' O f f i c i e r   M a r i n e ' ) . 
 
 %   = = =   P o u r   B a c   S V T   = = = 
 
 f i l i e r e ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ,   ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ,   ' M Ã © d e c i n e   G Ã © n Ã © r a l e ' ,   ' F M P ' ,   ' 7   a n s ' ,   ' D o c t o r a t   e n   M Ã © d e c i n e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ,   ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ,   ' M Ã © d e c i n e   D e n t a i r e ' ,   ' F M D ' ,   ' 6   a n s ' ,   ' D o c t o r a t   D e n t a i r e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ,   ' S e c t e u r   m Ã © d i c a l   e t   p a r a m Ã © d i c a l ' ,   ' P h a r m a c i e ' ,   ' F M P ' ,   ' 6   a n s ' ,   ' D o c t o r a t   e n   P h a r m a c i e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ,   ' A g r i c u l t u r e ,   Ã © l e v a g e   e t   m Ã © d e c i n e   v Ã © t Ã © r i n a i r e ' ,   ' A g r o n o m i e ' ,   ' I A V   H a s s a n   I I ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   A g r o n o m e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   l a   V i e   e t   d e   l a   T e r r e ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   d e s   P r o c Ã © d Ã © s ' ,   ' E N S A ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 %   = = =   P o u r   B a c   Ã 0 c o n o m i e   &   G e s t i o n   = = = 
 
 f i l i e r e ( ' S c i e n c e s   Ã © c o n o m i q u e s ' ,   ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ,   ' C o m m e r c e   I n t e r n a t i o n a l ' ,   ' E N C G ' ,   ' 5   a n s ' ,   ' D i p l Ã ´ m e   E N C G ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   Ã © c o n o m i q u e s ' ,   ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ,   ' M a n a g e m e n t ' ,   ' E N C G ' ,   ' 5   a n s ' ,   ' D i p l Ã ´ m e   E N C G ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   Ã © c o n o m i q u e s ' ,   ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ,   ' L i c e n c e   Ã 0 c o n o m i e ' ,   ' F S J E S ' ,   ' 3   a n s ' ,   ' L i c e n c e ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   Ã © c o n o m i q u e s ' ,   ' C l a s s e s   P r Ã © p a s   E C T ' ,   ' C P G E ' ,   ' 2   a n s ' ,   ' C P G E ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   g e s t i o n   c o m p t a b l e ' ,   ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ,   ' A u d i t   e t   C o n t r Ã ´ l e ' ,   ' E N C G ' ,   ' 5   a n s ' ,   ' D i p l Ã ´ m e   E N C G ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   d e   g e s t i o n   c o m p t a b l e ' ,   ' Ã 0 c o n o m i e ,   g e s t i o n   e t   l o g i s t i q u e ' ,   ' E x p e r t i s e   C o m p t a b l e ' ,   ' I S C A E ' ,   ' 3   a n s ' ,   ' D i p l Ã ´ m e   G r a n d e   Ã 0 c o l e ' ) . 
 
 %   = = =   P o u r   B a c   L e t t r e s   &   H u m a i n e s   = = = 
 
 f i l i e r e ( ' L e t t r e s ' ,   ' L a n g u e s ,   L e t t r e s   e t   S c i e n c e s   H u m a i n e s ' ,   ' Ã 0 t u d e s   A n g l a i s e s ' ,   ' F L S H ' ,   ' 3   a n s ' ,   ' L i c e n c e ' ) . 
 
 f i l i e r e ( ' L e t t r e s ' ,   ' C o m m u n i c a t i o n   e t   m Ã © d i a s ' ,   ' J o u r n a l i s m e ' ,   ' I S I C ' ,   ' 3   a n s ' ,   ' L i c e n c e   I n f o - C o m ' ) . 
 
 f i l i e r e ( ' L e t t r e s ' ,   ' T o u r i s m e   e t   h Ã ´ t e l l e r i e ' ,   ' A n i m a t i o n   T o u r i s t i q u e ' ,   ' I S I T T ' ,   ' 3   a n s ' ,   ' D i p l Ã ´ m e   C y c l e   N o r m a l ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   h u m a i n e s ' ,   ' S e c t e u r   d u   t r a v a i l   s o c i a l ' ,   ' A c t i o n   S o c i a l e ' ,   ' I N A S ' ,   ' 3   a n s ' ,   ' D i p l Ã ´ m e   I N A S ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   h u m a i n e s ' ,   ' L a n g u e s ,   L e t t r e s   e t   S c i e n c e s   H u m a i n e s ' ,   ' P s y c h o l o g i e ' ,   ' F L S H ' ,   ' 3   a n s ' ,   ' L i c e n c e ' ) . 
 
 %   = = =   P o u r   B a c   T e c h n i q u e   ( Ã 0 l e c / M Ã © c a )   = = = 
 
 f i l i e r e ( ' S c i e n c e s   e t   t e c h n o l o g i e s   Ã © l e c t r i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   Ã 0 l e c t r i q u e ' ,   ' E N S E T ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   e t   t e c h n o l o g i e s   Ã © l e c t r i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' Ã 0 l e c t r o m Ã © c a n i q u e ' ,   ' B T S ' ,   ' 2   a n s ' ,   ' B T S ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   e t   t e c h n o l o g i e s   m Ã © c a n i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' G Ã © n i e   M Ã © c a n i q u e ' ,   ' E N S A M ' ,   ' 5   a n s ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ) . 
 
 f i l i e r e ( ' S c i e n c e s   e t   t e c h n o l o g i e s   m Ã © c a n i q u e s ' ,   ' S c i e n c e s ,   t e c h n o l o g i e   e t   i n d u s t r i e ' ,   ' M a i n t e n a n c e   I n d u s t r i e l l e ' ,   ' E S T ' ,   ' 2   a n s ' ,   ' D U T ' ) . 
 
 %   = = =   P o u r   B a c   A r t s   A p p l i q u Ã © s   = = = 
 
 f i l i e r e ( ' A r t s   a p p l i q u Ã © s ' ,   ' B e a u x - A r t s   e t   D e s i g n ' ,   ' A r t s   P l a s t i q u e s ' ,   ' I N B A ' ,   ' 4   a n s ' ,   ' D i p l Ã ´ m e   B e a u x - A r t s ' ) . 
 
 f i l i e r e ( ' A r t s   a p p l i q u Ã © s ' ,   ' B e a u x - A r t s   e t   D e s i g n ' ,   ' A r c h i t e c t u r e   d ' ' I n t Ã © r i e u r ' ,   ' E S B A ' ,   ' 4   a n s ' ,   ' D i p l Ã ´ m e   B e a u x - A r t s ' ) . 
 
 f i l i e r e ( ' A r t s   a p p l i q u Ã © s ' ,   ' A r c h i t e c t u r e   e t   T r a v a u x   P u b l i c s ' ,   ' A r c h i t e c t u r e ' ,   ' E N A ' ,   ' 6   a n s ' ,   ' A r c h i t e c t e ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   5 .   P L A T E F O R M E S   D ' A C C Ã ÆS 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 p l a t e f o r m e ( ' F S T ' ,   ' w w w . t a w j i h i . m a ' ) . 
 
 p l a t e f o r m e ( ' E N S A ' ,   ' w w w . e n s a - c o n c o u r s . m a ' ) . 
 
 p l a t e f o r m e ( ' E N C G ' ,   ' w w w . t a f e m . m a ' ) . 
 
 p l a t e f o r m e ( ' C P G E ' ,   ' w w w . c p g e . a c . m a ' ) . 
 
 p l a t e f o r m e ( ' E S T ' ,   ' w w w . t a w j i h i . m a ' ) . 
 
 p l a t e f o r m e ( ' F M P ' ,   ' w w w . c u r s u s s u p . g o v . m a ' ) . 
 
 p l a t e f o r m e ( ' F M D ' ,   ' w w w . c u r s u s s u p . g o v . m a ' ) . 
 
 p l a t e f o r m e ( ' I S P I T S ' ,   ' i s p i t s . s a n t e . g o v . m a ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   6 .   S P Ã 0 C I A L I T Ã 0 S   P A R   Ã 0 T A B L I S S E M E N T   ( E x e m p l e s ) 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 s p e c i a l i t e ( ' F a c u l t Ã ©   d e s   S c i e n c e s ' ,   ' M a t h Ã © m a t i q u e s ' ) . 
 
 s p e c i a l i t e ( ' F a c u l t Ã ©   d e s   S c i e n c e s ' ,   ' P h y s i q u e ' ) . 
 
 s p e c i a l i t e ( ' F S T ' ,   ' I n f o r m a t i q u e ' ) . 
 
 s p e c i a l i t e ( ' F S T ' ,   ' G Ã © n i e   C i v i l ' ) . 
 
 s p e c i a l i t e ( ' E N S A ' ,   ' G Ã © n i e   I n f o r m a t i q u e ' ) . 
 
 s p e c i a l i t e ( ' E N S A ' ,   ' G Ã © n i e   I n d u s t r i e l ' ) . 
 
 s p e c i a l i t e ( ' E N S A M ' ,   ' G Ã © n i e   M Ã © c a n i q u e ' ) . 
 
 s p e c i a l i t e ( ' C P G E ' ,   ' M P S I ' ) . 
 
 s p e c i a l i t e ( ' C P G E ' ,   ' P C S I ' ) . 
 
 s p e c i a l i t e ( ' C P G E ' ,   ' E C T ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   7 .   D Ã 0 B O U C H Ã 0 S   P R O F E S S I O N N E L S 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 d e b o u c h e _ a s s o c i e ( ' G Ã © n i e   I n f o r m a t i q u e ' ,   ' D Ã © v e l o p p e u r ,   A r c h i t e c t e   L o g i c i e l ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' M Ã © d e c i n e   G Ã © n Ã © r a l e ' ,   ' M Ã © d e c i n   G Ã © n Ã © r a l i s t e ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' M Ã © d e c i n e   D e n t a i r e ' ,   ' D e n t i s t e ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' P h a r m a c i e ' ,   ' P h a r m a c i e n   d ' ' o f f i c i n e   o u   i n d u s t r i e l ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' G Ã © n i e   C i v i l ' ,   ' I n g Ã © n i e u r   B T P ,   C h e f   d e   c h a n t i e r ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' C o m m e r c e   I n t e r n a t i o n a l ' ,   ' M a n a g e r   E x p o r t ,   A c h e t e u r ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' A u d i t   e t   C o n t r Ã ´ l e ' ,   ' A u d i t e u r   f i n a n c i e r ,   C o n t r Ã ´ l e u r   d e   g e s t i o n ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' J o u r n a l i s m e ' ,   ' J o u r n a l i s t e ,   R Ã © d a c t e u r   w e b ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' S o i n s   I n f i r m i e r s ' ,   ' I n f i r m i e r   p o l y v a l e n t ' ) . 
 
 d e b o u c h e _ a s s o c i e ( ' A r c h i t e c t u r e ' ,   ' A r c h i t e c t e   u r b a n i s t e ' ) . 
 
 %     R Ã ÆG L E S   D ' O R I E N T A T I O N   P O S T - B A C   -   M A R O C 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   1 .   O r i e n t a t i o n   G Ã © n Ã © r a l e 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   1 :   O r i e n t a t i o n   v e r s   l e s   f i l i Ã ¨ r e s   s c i e n t i f i q u e s 
 
 o r i e n t a t i o n _ s c i e n t i f i q u e ( E t a b l i s s e m e n t ,   D i p l o m e ,   V i l l e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   V i l l e ,   D i p l o m e ,   _ ,   _ ) , 
 
 m e m b e r ( D i p l o m e ,   [ ' D E U G ' ,   ' L i c e n c e   F o n d a m e n t a l e ' ,   ' D E U S T ' ,   ' I n g Ã © n i e u r   d ' ' Ã 0 t a t ' ,   ' I n g Ã © n i e u r   I A ' ,   ' I n g Ã © n i e u r   C h i m i e ' ] ) . 
 
 %   R Ã ¨ g l e   2 :   O r i e n t a t i o n   m Ã © d e c i n e   p o u r   B a c   S c i e n c e s 
 
 o r i e n t a t i o n _ m e d e c i n e ( E t a b l i s s e m e n t ,   D i p l o m e ,   V i l l e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   V i l l e ,   D i p l o m e ,   _ ,   ' s e l e c t i o n _ c o n c o u r s ' ) , 
 
 m e m b e r ( D i p l o m e ,   [ ' D o c t o r a t   e n   M Ã © d e c i n e ' ,   ' D o c t o r a t   e n   P h a r m a c i e ' ,   ' D o c t o r a t   D e n t a i r e ' ] ) . 
 
 %   R Ã ¨ g l e   3 :   O r i e n t a t i o n   p r Ã © p a s   s c i e n t i f i q u e s 
 
 o r i e n t a t i o n _ p r e p a s ( E t a b l i s s e m e n t )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   ' C P G E ' ,   _ ,   ' s e l e c t i o n ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   2 .   R Ã ¨ g l e s   d ' A c c Ã ¨ s 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   4 :   A c c Ã ¨ s   d i r e c t   p o u r   l e s   f a c u l t Ã © s 
 
 a c c e s _ d i r e c t ( E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   D i p l o m e ,   _ ,   ' d i r e c t ' ) . 
 
 %   R Ã ¨ g l e   5 :   A c c Ã ¨ s   p a r   s Ã © l e c t i o n / c o n c o u r s 
 
 a c c e s _ c o n c o u r s ( E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   D i p l o m e ,   _ ,   A c c e s ) , 
 
 m e m b e r ( A c c e s ,   [ ' s e l e c t i o n ' ,   ' s e l e c t i o n _ c o n c o u r s ' ,   ' c o n c o u r s _ n a t i o n a l ' ] ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   3 .   R Ã ¨ g l e s   p a r   D u r Ã © e   d e   F o r m a t i o n 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   6 :   F o r m a t i o n s   l o n g u e s   ( â 0 ¥ 5   a n s ) 
 
 f o r m a t i o n _ l o n g u e ( E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   D i p l o m e ,   D u r e e ,   _ ) , 
 
 D u r e e   > =   5 . 
 
 %   R Ã ¨ g l e   7 :   F o r m a t i o n s   c o u r t e s   ( 2 - 3   a n s ) 
 
 f o r m a t i o n _ c o u r t e ( E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   D i p l o m e ,   D u r e e ,   _ ) , 
 
 D u r e e   = <   3 . 
 
 %   R Ã ¨ g l e   8 :   F o r m a t i o n s   m o y e n n e s   ( 4   a n s ) 
 
 f o r m a t i o n _ m o y e n n e ( E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   D i p l o m e ,   4 ,   _ ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   4 .   R Ã ¨ g l e s   d e   S p Ã © c i a l i t Ã ©   &   R e c h e r c h e   A v a n c Ã © e 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   9 :   V Ã © r i f i c a t i o n   d e   s p Ã © c i a l i t Ã ©   d i s p o n i b l e 
 
 s p e c i a l i t e _ d i s p o n i b l e ( E t a b l i s s e m e n t ,   S p e c i a l i t e )   : - 
 
 s p e c i a l i t e ( E t a b l i s s e m e n t ,   S p e c i a l i t e ) . 
 
 %   R Ã ¨ g l e   1 0 :   F i l i Ã ¨ r e s   a c c e s s i b l e s   p a r   s Ã © r i e   d e   b a c 
 
 f i l i e r e _ a c c e s s i b l e s ( B a c ,   F i l i e r e ,   S e c t e u r ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e )   : - 
 
 s e r i e _ b a c ( B a c ) , 
 
 f i l i e r e ( B a c ,   S e c t e u r ,   F i l i e r e ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e ) . 
 
 %   R Ã ¨ g l e   1 1 :   F i l i Ã ¨ r e s   p a r   s e c t e u r   d ' i n t Ã © r Ã ª t 
 
 f i l i e r e _ p a r _ s e c t e u r ( B a c ,   S e c t e u r ,   F i l i e r e ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e )   : - 
 
 s e r i e _ b a c ( B a c ) , 
 
 s e c t e u r _ f o r m a t i o n ( S e c t e u r ) , 
 
 f i l i e r e ( B a c ,   S e c t e u r ,   F i l i e r e ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e ) . 
 
 %   R Ã ¨ g l e   1 2 :   F i l i Ã ¨ r e s   p a r   d u r Ã © e   s p Ã © c i f i q u e 
 
 f i l i e r e _ p a r _ d u r e e ( B a c ,   D u r e e ,   F i l i e r e ,   S e c t e u r ,   E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 f i l i e r e ( B a c ,   S e c t e u r ,   F i l i e r e ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e ) . 
 
 %   R Ã ¨ g l e   1 3 :   Ã 0 t a b l i s s e m e n t s   p a r   t y p e   d ' a c c Ã ¨ s 
 
 e t a b l i s s e m e n t _ p a r _ a c c e s ( N o m ,   V i l l e ,   D i p l o m e ,   D u r e e ,   A c c e s )   : - 
 
 e t a b l i s s e m e n t ( N o m ,   V i l l e ,   D i p l o m e ,   D u r e e ,   A c c e s ) . 
 
 %   R Ã ¨ g l e   1 4 :   F i l i Ã ¨ r e s   p a r   Ã © t a b l i s s e m e n t 
 
 f i l i e r e s _ e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   B a c ,   F i l i e r e ,   S e c t e u r ,   D u r e e ,   D i p l o m e )   : - 
 
 f i l i e r e ( B a c ,   S e c t e u r ,   F i l i e r e ,   E t a b l i s s e m e n t ,   D u r e e ,   D i p l o m e ) . 
 
 %   R Ã ¨ g l e   1 5 :   F i l i Ã ¨ r e s   a v e c   a c c Ã ¨ s   d i r e c t   ( s a n s   c o n c o u r s ) 
 
 f i l i e r e _ a c c e s _ d i r e c t ( B a c ,   F i l i e r e ,   E t a b l i s s e m e n t )   : - 
 
 f i l i e r e ( B a c ,   _ ,   F i l i e r e ,   E t a b l i s s e m e n t ,   _ ,   _ ) , 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   _ ,   _ ,   _ ,   ' d i r e c t ' ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   5 .   R Ã ¨ g l e s   d e   C o n s e i l   e t   R e c o m m a n d a t i o n 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   1 7 :   C o n s e i l s   d ' o r i e n t a t i o n   b a s Ã © s   s u r   l e s   n o t e s 
 
 c o n s e i l _ o r i e n t a t i o n ( B a c ,   N o t e _ M a t h s ,   N o t e _ P h y s i q u e ,   R e c o m m a n d a t i o n )   : - 
 
 s e r i e _ b a c ( B a c ) , 
 
 ( N o t e _ M a t h s   > =   1 5 ,   N o t e _ P h y s i q u e   > =   1 4   - > 
 
 R e c o m m a n d a t i o n   =   ' I n g Ã © n i e r i e ,   M Ã © d e c i n e   o u   A r c h i t e c t u r e   r e c o m m a n d Ã © e s   ( C P G E / E N S A / E N A ) ' ; 
 
 N o t e _ M a t h s   > =   1 5   - > 
 
 R e c o m m a n d a t i o n   =   ' S c i e n c e s   e x a c t e s ,   I n g Ã © n i e r i e   e t   T e c h n o l o g i e s   ( E N S A / F S T ) ' ; 
 
 N o t e _ P h y s i q u e   > =   1 4   - > 
 
 R e c o m m a n d a t i o n   =   ' S c i e n c e s   d e   l a   v i e ,   M Ã © d i c a l   e t   P a r a m Ã © d i c a l   ( F M P / I S P I T S ) ' ; 
 
 R e c o m m a n d a t i o n   =   ' T o u t e s   l e s   f i l i Ã ¨ r e s   u n i v e r s i t a i r e s   e t   t e c h n i q u e s   s o n t   a c c e s s i b l e s   s e l o n   v o s   i n t Ã © r Ã ª t s ' ) . 
 
 %   R Ã ¨ g l e   1 8 :   R e c o m m a n d a t i o n   p a r   p r o f i l   Ã © t u d i a n t 
 
 r e c o m m a n d a t i o n _ p r o f i l ( B a c ,   I n t e r e t ,   F i l i e r e ,   E t a b l i s s e m e n t )   : - 
 
 s e r i e _ b a c ( B a c ) , 
 
 s e c t e u r _ f o r m a t i o n ( I n t e r e t ) , 
 
 f i l i e r e ( B a c ,   I n t e r e t ,   F i l i e r e ,   E t a b l i s s e m e n t ,   _ ,   _ ) . 
 
 %   R Ã ¨ g l e   1 9 :   C o m p a r a i s o n   d e   f i l i Ã ¨ r e s   p a r   d u r Ã © e 
 
 c o m p a r e r _ d u r e e ( F i l i e r e 1 ,   F i l i e r e 2 ,   R e s u l t a t )   : - 
 
 f i l i e r e ( _ ,   _ ,   F i l i e r e 1 ,   _ ,   D u r e e 1 ,   _ ) , 
 
 f i l i e r e ( _ ,   _ ,   F i l i e r e 2 ,   _ ,   D u r e e 2 ,   _ ) , 
 
 ( D u r e e 1   <   D u r e e 2   - >   R e s u l t a t   =   ' p l u s _ c o u r t e ' ; 
 
 D u r e e 1   >   D u r e e 2   - >   R e s u l t a t   =   ' p l u s _ l o n g u e ' ; 
 
 R e s u l t a t   =   ' m e m e _ d u r e e ' ) . 
 
 %   R Ã ¨ g l e   2 0 :   D Ã © b o u c h Ã © s   p r o f e s s i o n n e l s   ( D Y N A M I Q U E ) 
 
 %   C e t t e   r Ã ¨ g l e   v a   m a i n t e n a n t   c h e r c h e r   d a n s   l a   b a s e   d e   f a i t s   u n i f i Ã © e 
 
 d e b o u c h e s _ f i l i e r e ( F i l i e r e ,   D e b o u c h e )   : - 
 
 d e b o u c h e _ a s s o c i e ( F i l i e r e ,   D e b o u c h e ) . 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   6 .   R Ã ¨ g l e s   U t i l i t a i r e s 
 
 %   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
 %   R Ã ¨ g l e   2 1 :   V Ã © r i f i c a t i o n   d e   c o m p a t i b i l i t Ã ©   b a c - f i l i Ã ¨ r e 
 
 c o m p a t i b l e _ b a c _ f i l i e r e ( B a c ,   F i l i e r e )   : - 
 
 f i l i e r e ( B a c ,   _ ,   F i l i e r e ,   _ ,   _ ,   _ ) . 
 
 %   R Ã ¨ g l e   2 2 :   Ã 0 t a b l i s s e m e n t s   d a n s   u n e   v i l l e   d o n n Ã © e 
 
 e t a b l i s s e m e n t s _ v i l l e ( V i l l e ,   E t a b l i s s e m e n t ,   D i p l o m e )   : - 
 
 e t a b l i s s e m e n t ( E t a b l i s s e m e n t ,   V i l l e ,   D i p l o m e ,   _ ,   _ ) . 
 
 %   R Ã ¨ g l e   2 3 :   T o u t e s   l e s   o p t i o n s   p o u r   u n   b a c   d o n n Ã ©   ( R e t o u r n e   u n e   l i s t e   u n i q u e ) 
 
 o p t i o n s _ b a c ( B a c ,   O p t i o n s )   : - 
 
 f i n d a l l ( F i l i e r e ,   f i l i e r e ( B a c ,   _ ,   F i l i e r e ,   _ ,   _ ,   _ ) ,   F i l i e r e s L i s t ) , 
 
 l i s t _ t o _ s e t ( F i l i e r e s L i s t ,   O p t i o n s ) . 
 
 %   R Ã ¨ g l e   2 4 :   R e c h e r c h e   f l o u e   ( I n s e n s i b l e   Ã     l a   c a s s e ) 
 
 r e c h e r c h e _ f l o u e _ e t a b l i s s e m e n t ( R e q u e t e ,   R e s u l t a t )   : - 
 
 e t a b l i s s e m e n t ( R e s u l t a t ,   _ ,   _ ,   _ ,   _ ) , 
 
 s u b _ a t o m _ i c a s e c h k ( R e s u l t a t ,   _ ,   R e q u e t e ) . 
 
 