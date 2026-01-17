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
:- discontiguous detail_bac/5.
:- discontiguous detail_domaine/4.
:- discontiguous info_type/4.
:- discontiguous strategie_profil/3.
:- discontiguous check_compatibilite/4.

% =======================================================
% BASE DE CONNAISSANCES - PFE EXPERT (CLEAN VERSION)
% =======================================================

% -------------------------------------------------------
% 1. ORIENTATION & STRATEGIE (Regles Decisionnelles)
% -------------------------------------------------------

% A. RECOMMANDATIONS PAR BAC (debouche/4)
debouche('PC', 'Ingenierie', 'ENSA / FST', 'Recommande. Concours ou dossier. (Maths/Physique importants)').
debouche('PC', 'Ingenierie d''Excellence', 'UM6P / EMI', 'Si moyenne > 15 ou via CNC.').
debouche('PC', 'CPGE (Prepas)', 'MPSI / PCSI', 'Voie royale pour les grandes ecoles. Moyenne > 15 conseillee.').
debouche('SM', 'Top Ingenierie', 'EMI / ENSIAS', 'Via CPGE ou CNC. Profil tres recherche.').
debouche('SM', 'Informatique & Data', 'ENSIAS / INPT', 'Excellent choix pour les matheux.').
debouche('SM', 'Architecture', 'ENA', 'Concours specifique.').
debouche('SVT', 'Medecine & Pharmacie', 'FMP / FMD', 'Filiere de predilection. Moyenne > 13 conseillee.').
debouche('SVT', 'Sante (Paramedical)', 'ISPITS / IFCS', 'Via concours. Bonnes perspectives.').
debouche('SVT', 'Biologie / Agro', 'FST / APESA', 'Cycle ingenieur agronome IAV possible.').
debouche('ECO', 'Commerce & Gestion', 'ENCG', 'Top ecole publique (Via TAFEM).').
debouche('ECO', 'Management', 'ISCAE', 'Apres prepa ou licence. Tres prestigieux.').
debouche('ECO', 'Droit / Eco', 'Facultes', 'Filieres ouvertes. Maitrise du francais/arabe requise.').

% B. REGLES D'ELIGIBILITE MEDECINE
peut_faire_medecine(Bac, Note, '✅ Admissible (Favorable)') :-
    (Bac = 'SVT'), Note >= 13.
peut_faire_medecine(Bac, Note, '⚠️ Admissible mais dossier juste (Risque)') :-
    (Bac = 'PC'; Bac = 'SM'), Note >= 12.
peut_faire_medecine(_, _, '❌ Moyenne insuffisante (<12) ou Bac inadapte. Tentez le Prive.').

% C. STRATEGIE SELON MOYENNE (conseil_note/2)
conseil_note(High, 'Viser l''Excellence : Medecine, ENSA Rabat, EMI, Architecture.') :- High >= 15.
conseil_note(Med, 'Viser Strategique : ENSA (Villes moins demandees : Safi, Khouribga), FST, EST.') :- Med >= 13, Med < 15.
conseil_note(Low, 'Viser Securite : Facultes, BTS, ISTA, ou Ecoles Privees (si budget).') :- Low < 13.

% D. COMPATIBILITE BAC-FILIERE (Nouveau - Avertissements)
% compatibilite_bac_filiere(Bac, Filiere, Statut, Message).
% This is now handled by check_compatibilite/4 at the end of file for robustness.

% -------------------------------------------------------
% 2. CARTOGRAPHIE & VILLES (Geographie)
% -------------------------------------------------------

% Villes a forte concurrence
ville_concurrence('Casablanca').
ville_concurrence('Rabat').
ville_concurrence('Marrakech').
ville_concurrence('Fes').
ville_concurrence('Tanger').

% Villes "Opportunite"
ville_chance('Beni Mellal').
ville_chance('Safi').
ville_chance('Khouribga').
ville_chance('El Jadida').
ville_chance('Taza').
ville_chance('Errachidia').
ville_chance('Al Hoceima').

% Localisation des Etablissements Publics
localisation('Universite Hassan II', 'Casablanca').
localisation('Universite Hassan II', 'Mohammedia').
localisation('Universite Mohammed V', 'Rabat').
localisation('Universite Cadi Ayyad', 'Marrakech').
localisation('Universite Ibn Zohr', 'Agadir').
localisation('Universite Abdelmalek Essaadi', 'Tetouan').
localisation('ENSA', 'Agadir').
localisation('ENSA', 'Fes').
localisation('ENSA', 'Marrakech').
localisation('ENSA', 'Tanger').
localisation('ENSA', 'Tetouan').
localisation('ENSA', 'Khouribga').
localisation('ENSA', 'Safi').
localisation('ENSA', 'El Jadida').
localisation('ENSA', 'Berrechid').
localisation('ENSA', 'Beni Mellal').
localisation('ENSA', 'Oujda').
localisation('ENSA', 'Al Hoceima').
localisation('ENSAM', 'Meknes').
localisation('ENSAM', 'Casablanca').
localisation('ENSAM', 'Rabat').
localisation('ENSIAS', 'Rabat').
localisation('EMI', 'Rabat').
localisation('FST', 'Fes').
localisation('FST', 'Settat').
localisation('FST', 'Mohammedia').
localisation('FST', 'Beni Mellal').
localisation('FST', 'Errachidia').
localisation('UM6P', 'Benguerir').
localisation('Universite Al Akhawayn', 'Ifrane').

% Localisation du Prive
localisation('EMSI', 'Casablanca').
localisation('EMSI', 'Rabat').
localisation('EMSI', 'Marrakech').
localisation('EMSI', 'Fes').
localisation('UIR', 'Rabat').
localisation('SUPINFO', 'Casablanca').
localisation('HEM', 'Casablanca').
localisation('ESCA', 'Casablanca').
localisation('UIASS', 'Rabat').
localisation('UPSAT', 'Casablanca').

% -------------------------------------------------------
% 3. ECOLES PRIVEES (Details & Frais)
% -------------------------------------------------------
detail_ecole('EMSI', 'Ingenierie (Prive)', 'Genie Info, Indus, Civil', '28 000 - 38 000 DH/an').
detail_ecole('UIR', 'Universite Semi-Public', 'Aero, Info, Business, Sc.Po', '65 000 - 95 000 DH/an').
detail_ecole('SUPINFO', 'IT (Prive)', 'Full Stack, Cloud, Cyber', '45 000 - 60 000 DH/an').
detail_ecole('HEM', 'Business (Prive)', 'Management, Marketing', '35 000 - 60 000 DH/an').
detail_ecole('ESCA', 'Business (Prive)', 'Finance, Audit', '45 000 - 70 000 DH/an').
detail_ecole('UIASS', 'Sante (Semi-Prive)', 'Medecine, Dentaire', '80 000 - 130 000 DH/an').
detail_ecole('UPSAT', 'Sante (Prive)', 'Medecine, Pharma', '70 000 - 110 000 DH/an').
detail_ecole('ISITT Prive', 'Tourisme', 'Management Hotelier', '20 000 - 30 000 DH/an').

% -------------------------------------------------------
% 4. STATISTIQUES & CHIFFRES CLES
% -------------------------------------------------------
stat('Global', 'Etudiants Maroc', '1.25 Million').
stat('Global', 'Filieres', '+1000 accreditees').
stat('Places', 'Medecine (Total)', '~4 800 places').
stat('Places', 'Medecine (Casa)', '~200 places').
stat('Places', 'ENSA (Total)', '~4 000 places').
stat('Places', 'ENSA (Casa)', '~350 places').
stat('Places', 'ENSA (Beni Mellal)', '~150 places').
stat('Selectivite', 'Medecine', '1 admis pour 22 candidats').
stat('Selectivite', 'ENSA', '1 admis pour 21 candidats').
stat('Salaires', 'Ingenieur Debutant', '8 000 - 12 000 DH/mois').
stat('Salaires', 'Medecin Public', '12 000 - 15 000 DH/mois').

% -------------------------------------------------------
% 5. CONSEILS & METHODOLOGIE (info/2)
% -------------------------------------------------------
info('Organisation', 'Fais un planning realiste. Ne charge pas trop tes journees.').
info('Organisation', 'Utilise la methode Pomodoro (25min travail / 5min pause).').
info('Organisation', 'Dors au moins 7h/nuit. Le cerveau memorise en dormant.').
info('Organisation', 'Cree un agenda hebdomadaire avec horaires fixes pour etudes et revisions.').

info('Methode', 'Revise avec des fiches de synthese (formules, dates, definitions).').
info('Methode', 'Pratique sur les ANNALES des annees precedentes. C''est crucial.').
info('Methode', 'Explique ton cours a voix haute (Technique Feynman) pour verifier ta comprehension.').

info('Examens', 'Revise regulierement pour eviter le stress de derniere minute.').
info('Examens', 'Priorise les matieres cles mais ne neglige pas les "faciles" qui ameliorent la moyenne.').
info('Examens', 'Divise les chapitres par semaine pour un plan d''etude progressif.').

info('Assiduite', 'Assiste a TOUS les cours et TD/TP. L''absence cree des lacunes.').
info('Assiduite', 'Participe activement aux travaux pratiques et projets.').

info('Ressources', 'Utilise bibliotheques, plateformes en ligne, notes partagees par anciens.').
info('Ressources', 'Rejoins tutorats ou groupes d''etudes pour renforcer tes connaissances.').

info('Competences', 'Francais et anglais indispensables. Renforce ton niveau via cours ou apps.').
info('Competences', 'Maitrise Excel, Word, PowerPoint et logiciels specifiques a ta filiere.').

info('Medecine', 'Revisions continues pour cours volumineux. Groupes de travail pour anatomie/physiologie.').
info('Commerce', 'Pratique cas reels, etudes de marche, exercices financiers.').

info('Strategie', 'Plan A / Plan B : Toujours avoir une filiere "Securite" (Fac, Prive) si ton 1er choix echoue.').
info('Strategie', 'Regarde les debouches REELS (Offres d''emploi sur LinkedIn) avant de choisir.').
info('Strategie', 'Pense aux villes "Opportunite" (Beni Mellal, Safi...) si ta note est juste.').

info('Vie Pro', 'Les stages sont obligatoires pour un bon CV. Cherche des la 1ere annee.').
info('Vie Pro', 'Anglais = Salaire. Passe le TOEIC ou TOEFL si tu peux.').

info('Budget', 'Bourses : Minhaty, Erasmus (Europe), Fulbright (USA). Renseigne-toi tot.').
info('Budget', 'Logement : Les cites universitaires sont prioritaires pour ceux qui habitent loin.').

% -------------------------------------------------------
% 6. DEFINITIONS (Systeme LMD)
% -------------------------------------------------------
definition('LMD', 'Systeme Licence (3 ans) -> Master (+2 ans) -> Doctorat (+3 ans). Standard mondial.').
definition('CPGE', 'Classes Prepas (2 ans intensifs). Prepare aux concours des Grandes Ecoles d''ingenieurs (CNC).').
definition('BTS', 'Brevet Technicien Superieur (2 ans). Formation courte, pratique, bonne insertion pro.').
definition('DUT', 'Diplome Universitaire Technologie (2 ans). Souvent en EST. Plus academique que le BTS.').
definition('Master', 'Bac+5. Specialisation necessaire pour les postes de cadres/responsabilite.').
definition('Ingenieur', 'Titre protege Bac+5. Formation technique et manageriale de haut niveau.').
definition('ENSA', 'Ecole Nationale des Sciences Appliquees (5 ans). Formation d''ingenieur d''etat. Acces post-bac ou bac+2.').
definition('ENCG', 'Ecole Nationale de Commerce et de Gestion (5 ans). Formation management/commerce. Acces par concours TAFEM.').
definition('EST', 'Ecole Superieure de Technologie (2 ans). Delivre le DUT. Formation technique courte.').
definition('FST', 'Faculte des Sciences et Techniques. Systeme LMD hybride (Tronc commun + Specialite). Acces sur dossier.').
definition('OFPPT', 'Office de la Formation Professionnelle. Formations courtes (2 ans) type Technicien Specialise. Pratique et insertion rapide.').

% -------------------------------------------------------
% API LOGIQUE (Predicats appeles par Python)
% -------------------------------------------------------

% Recommandation simple
recommander_orientation(Bac, Domaine, Ecole) :- detail_bac(Bac, Ideales, _, _, _), sub_string(Ideales, _, _, _, Domaine), Ecole = 'Voir detail'.

% Extraction de conseils par theme
conseil(Theme, Texte) :- info(Theme, Texte).

% -------------------------------------------------------
% 7. STRATEGIE AVANCEE (Check_Compatibilite + Details)
% -------------------------------------------------------

% Types d'etablissements & Pros/Cons
info_type(public_ouvert, 
    'Filieres ouvertes (Facs, Droit, Eco). Pas de selection.',
    '✅ Gratuit, Large choix, Accessible tous niveaux.',
    '⚠️ Effectifs charges, Moins de suivi, Peu de stages.').

info_type(public_regule, 
    'Filieres selectives (Medecine, ENSA, ENCG). Concours.',
    '✅ Diplome prestigieux, Excellent insertion pro, Gratuit.',
    '⚠️ Tres forte concurrence, Stress, Selection dure.').

info_type(prive, 
    'Ecoles privees (UIR, EMSI, HEM...). Payant.',
    '✅ Acces plus souple, Programmes modernes, Stages integres.',
    '⚠️ Cout eleve, Verifier la reconnaissance du diplome.').


% Logique de Strategie (strategie_profil/3)
% Usage: strategie_profil(Note, Bac, Conseil).

% Cas 1 : Excellente moyenne (>15)
strategie_profil(Note, _, '🌟 Profil EXCELLENT : Visez les filieres REGULEES (Public).\n👉 Medecine, ENSA, ENCG, CPGE.\n👉 Visez les grandes villes (Rabat, Casa) mais gardez un Plan B.') :-
    Note >= 15, !.

% Cas 2 : Bonne moyenne (13-15)
strategie_profil(Note, _, '📈 Profil BON : Strategie de "Contournement".\n👉 Visez les filieres regulees dans les VILLES MOYENNES (Safi, Khouribga, El Jadida) ou la concurrence est moindre.\n👉 Pensez aux FST qui sont un excellent compromis.') :-
    Note >= 13, Note < 15, !.

% Cas 3 : Moyenne Moyenne (11-13)
strategie_profil(Note, _, '🤔 Profil MOYEN : Choix Tactique necessaire.\n👉 1. Universites Publiques (Filieres Ouvertes) pour exceller et tenter des passerelles.\n👉 2. Ecoles Privees (si budget) pour un encadrement plus serre.\n👉 3. EST/BTS pour un diplome court et pro.') :-
    Note >= 11, Note < 13, !.

% Cas 4 : Moyenne Juste (<11)
strategie_profil(Note, _, '⚠️ Profil JUSTE : Ne prenez pas de risques.\n👉 Privilegiez un BTS/DTS (OFPPT) pour un metier rapide.\n👉 Ou une ecole Privee qui mise sur la pratique.\n👉 Evitez les facs surchargees si vous manquez d''autonomie.') :-
    Note < 11, !.

% Helpers
get_info_type(T, D, A, I) :- info_type(T, D, A, I).
get_strategie_profil(N, B, C) :- strategie_profil(N, B, C).

% -------------------------------------------------------
% 8. PROFILS BAC DETAILLES
% -------------------------------------------------------
% detail_bac(Bac, Ideales, Avantages, Limites, Conseil).

detail_bac('PC', 
    'Ingenierie (ENSA, EMI...), Informatique/IT, Sciences fondamentales.',
    '✅ Acces a presque toutes les filieres scientifiques. Bonne base pour concours.',
    '⚠️ Concurrence elevee en ingenierie.',
    '💡 Ideal si motive par les sciences exactes. Moyenne >= 13-14 recommandee pour le public selectif.').

detail_bac('SVT',
    'Medecine, Pharmacie, Dentaire, Biologie, Paramedical.',
    '✅ Voie royale pour la Sante. Profil polyvalent.',
    '⚠️ Difficile pour l''ingenierie mecanique/info pure dans le public.',
    '💡 Moyenne >= 14-15 imperative pour Medecine. Sinon, viser le Prive ou les filieres Bio.').

detail_bac('SM',
    'Maths, Statistique, Data Science, Ingenierie Top Niveau, Architecture.',
    '✅ Tres polyvalent. Acces privilegie aux Prepas (MPSI) et Grandes Ecoles.',
    '⚠️ Rythme intense.',
    '💡 Excellent pour combiner sciences et economie/finance de haut niveau.').

detail_bac('ECO',
    'Economie, Gestion, Commerce (ENCG/ISCAE), Droit, Finance.',
    '✅ Debouches nombreux en entreprise. Filieres bancaires.',
    '⚠️ Difficile pour l''ingenierie et les sciences dures.',
    '💡 Viser les ecoles de commerce selectives si bonne note. Sinon, Fac d''Eco/Droit.').

detail_bac('LITT',
    'Lettres, Langues, Communication, Journalisme, Sciences Humaines, Droit.',
    '✅ Acces aux metiers de la culture, medias et enseignement.',
    '⚠️ Difficile pour l''informatique et les sciences.',
    '💡 Explorer les ecoles privees pour les programmes modernes (Com, Digital Media).').

% Helper pour Python
get_detail_bac(Bac, I, A, L, C) :- detail_bac(Bac, I, A, L, C).


% -------------------------------------------------------
% 9. COMPATIBILITE (check_compatibilite/4)
% -------------------------------------------------------
% check_compatibilite(Bac, Filiere, Statut, Message).

% --- MEDECINE ---
check_compatibilite(Bac, medecine, impossible, '⛔ Incompatible : Medecine exige un Bac Scientifique (PC, SVT, SM).') :-
    member(Bac, ['ECO', 'LITT', 'TECH', 'ART']), !.

check_compatibilite(Bac, medecine, excellent, '✅ Excellent : Voie royale pour Medecine.') :-
    member(Bac, ['SVT']), !.

check_compatibilite(Bac, medecine, possible, '✅ Possible : Accessible, mais moins de Biologie au lycee donc un effort en 1ere annee.') :-
    member(Bac, ['SM', 'PC']), !.

% --- INGENIERIE ---
check_compatibilite(Bac, ingenierie, impossible, '⛔ Incompatible : Les ecoles d''ingenieurs publiques demandent un Bac Scientifique.') :-
    member(Bac, ['LITT', 'ART']), !.

check_compatibilite(Bac, ingenierie, difficile, '⚠️ Difficile : Peu de places pour Bac Eco/Technique dans le public, mais possible dans le PRIVE ou via des passerelles (BTS/DUT).') :-
    member(Bac, ['ECO', 'TECH']), !.

check_compatibilite(Bac, ingenierie, excellent, '✅ Excellent : Vous avez le profil ideal (Maths/Physique).') :-
    member(Bac, ['SM', 'PC']), !.

check_compatibilite(Bac, ingenierie, possible, '✅ Possible : Accessible (ENSA/FST), mais attention aux Maths.') :-
    member(Bac, ['SVT']), !.

% --- INFORMATIQUE ---
check_compatibilite(Bac, informatique, impossible, '⛔ Incompatible : Difficile sans bases logiques, mais possible via ecoles prives de code (Bootcamps).') :-
    member(Bac, ['LITT', 'ART']), !.

check_compatibilite(Bac, informatique, possible, '✅ Possible : Accessible via FST, EST ou Prive. Le Bac Eco permet l''informatique de gestion (MIAGE).') :-
    member(Bac, ['ECO']), !.

check_compatibilite(Bac, informatique, excellent, '✅ Excellent : Profil ideal pour le developpement et l''algo.') :-
    member(Bac, ['SM', 'PC']), !.

check_compatibilite(Bac, informatique, possible, '✅ Possible : Accessible notamment via les EST et FST.') :-
    member(Bac, ['SVT']), !.

% --- COMMERCE/GESTION ---
check_compatibilite(_, commerce, possible, '✅ Possible : Les filieres Commerce sont ouvertes a TOUS les Bacs (Scientifiques, Eco, Lettres). Le concours TAFEM est la cle.') :- !.

% --- LETTRES/DROIT ---
check_compatibilite(_, lettres, possible, '✅ Possible : Ouvert a tous les profils.') :- !.

% --- Fallback ---
check_compatibilite(_, _, inconnu, 'Je n''ai pas d''info specifique sur cette combinaison.').

% -------------------------------------------------------
% 10. DETAIL DOMAINE (detail_domaine/4)
% -------------------------------------------------------

detail_domaine(medecine,
    'Medecin, Pharmacien, Dentiste, Recherche biomedicale.',
    'Universites Publiques (FMP, FMD) et Privees (UPM, UIASS).',
    '💡 Bac Scientifique Obligatoire. Concours selectif.').

detail_domaine(ingenierie,
    'Ingenieur Civil, Mecanique, Indus, Data Scientist.',
    'ENSA, EMI, ENSIAS, UM6P. (Toutes villes).',
    '💡 Bac PC ou SM recommande. Prepa (CPGE) est la voie classique.').

detail_domaine(informatique,
    'Developpeur, Data Scientist, Cybersecurite, Consultant.',
    'EMSI, SUPINFO, UIR, ENSIAS, INPT, EST.',
    '💡 Tres forte demande. Diplome moins important que la competence reelle.').

detail_domaine(commerce,
    'Manager, Analyste Financier, Auditeur, Marketing, RH.',
    'ENCG, ISCAE, HEM, ESCA, UIR.',
    '💡 Bac ES ou SM recommande. Anglais crucial.').

detail_domaine(shs,
    'Journaliste, Psychologue, Sociologue, Enseignant.',
    'Facultes de Lettres & Sciences Humaines (FLSH), Droit.',
    '💡 Culture generale et expression ecrite sont les cles.').

detail_domaine(archi,
    'Architecte, Urbaniste, Designer, Styliste.',
    'ENA (Architecture), INBA (Beaux-Arts).',
    '💡 Concours specifique (Dessin + Maths). 6 ans d''etudes.').

get_detail_domaine(D, M, E, C) :- detail_domaine(D, M, E, C).

% -------------------------------------------------------
% 11. FINANCE, LOGEMENT, PROCEDURES
% -------------------------------------------------------

financement(public, 'Frais tres faibles. Ideal budget limite.', 'Accessible tous.').
financement(bourses_gouvernementales, 'Minhaty.', 'Verifier criteres sur minhaty.ma.').

get_financement(T, D, C) :- financement(T, D, C).

procedure('Inscription Fac', '1. Pre-inscription site. 2. Depot dossier.').
procedure('Dossier Minhaty', '1. Inscription minhaty.ma. 2. Depot dossier physique.').
procedure('Legalisation', 'Toujours legaliser copies Bac et Releves.').

get_procedure(T, D) :- procedure(T, D).

logement('Cite Universitaire', 'Logement public. 40-50 DH/mois.', 'Demande ONOUHC.').
logement('Internat', 'CPGE et Lycees Excellence.', 'Se renseigner aupres du lycee.').

get_logement(T, D, C) :- logement(T, D, C).

% -------------------------------------------------------
% 12. DATES & SEUILS
% -------------------------------------------------------
seuil('ENSA', 2023, 13.5).
seuil('Medecine', 2023, 12.0).
seuil('ENCG', 2023, 12.0).

get_seuil(E, A, N) :- seuil(E, A, N).

date_concours('Concours Medecine', 'Juillet (mi-juillet)').
date_concours('Concours ENSA', 'Juillet (fin juillet)').
date_concours('Concours ENCG (TAFEM)', 'Juillet').

get_date_concours(E, D) :- date_concours(E, D).

lien('CursusSup', 'https://www.cursussup.gov.ma').
lien('Minhaty', 'https://www.minhaty.ma').

get_lien(N, U) :- lien(N, U).

% -------------------------------------------------------
% 13. DATA SUPPLEMENTAIRE (Filiere/6)
% -------------------------------------------------------

% SÃ©ries Bac (Clean)
serie_bac('Sciences mathematiques A').
serie_bac('Sciences physiques').
serie_bac('Sciences de la Vie et de la Terre').
serie_bac('Sciences economiques').
serie_bac('Lettres').

% Exemples de filieres (Data echantillon pour le test)
filiere('Sciences mathematiques A', 'Sciences, technologie et industrie', 'CPGE MPSI', 'Lydex', 2, 'Attestation').
filiere('Sciences mathematiques A', 'Developpement Digital et IA', 'Genie Logiciel', 'ENSIAS', 3, 'Ingenieur').

filiere('Sciences physiques', 'Sciences, technologie et industrie', 'Genie Civil', 'EHTP', 3, 'Ingenieur').
filiere('Sciences physiques', 'Secteur medical et paramedical', 'Medecine Generale', 'FMP Rabat', 7, 'Doctorat').

filiere('Sciences de la Vie et de la Terre', 'Secteur medical et paramedical', 'Medecine Dentaire', 'FMD Casa', 6, 'Doctorat').

filiere('Sciences economiques', 'Economie, gestion et logistique', 'Commerce International', 'ENCG Setatt', 5, 'Master').

% -------------------------------------------------------
% 14. FORMATION PRO (OFPPT)
% -------------------------------------------------------
formation_pro('Technicien Specialise', 'Formation Bac+2. Diplome Technicien Specialise (DTS).', 'Acces : Bac. Duree : 2 ans. Debouches : Insertion pro rapide ou Licence Pro.').
formation_pro('Technicien', 'Formation Niveau Bac. Diplome Technicien (DT).', 'Acces : Niveau Bac (2eme annee). Duree : 2 ans.').
formation_pro('Qualification', 'Formation Niveau 3eme College. Diplome Qualification (DQ).', 'Acces : 3eme College. Duree : 2 ans.').

get_formation_pro(N, D, C) :- formation_pro(N, D, C).


% -------------------------------------------------------
% 15. CONCOURS & ADMISSIONS (Nouveau)
% -------------------------------------------------------
concours_admission(medecine, '4 Epreuves QCM (30-45min chacune) : Maths, SVT, Physique, Chimie. (Coef 1).', '?? Seuil 2024 : 13.00/20 (Moyenne Bac). \n?? Astuce : La rapidite est cle. Utilisez des astuces mathematiques, ne calculez pas tout.').
concours_admission(ingenierie_public, 'Concours Commun (ENSA/ENSAM/Mundiapolis...). Epreuves QCM : Maths, Physique, Anglais.', '?? Entrainez-vous sur les concours des annees precedentes (ConcoursMaroc.com). Gestion du temps cruciale.').
concours_admission(commerce, 'TAFEM (ENCG) : QCM vari (Memorisation, Maths, Culture G, Langues).', '?? Le test de memorisation se joue au debut. Soyez attentif et rapide.').
concours_admission(ecoles_privees, 'Selection sur Dossier + Test d''admission (Logique/Anglais) + Entretien.', '?? L''entretien de motivation est le plus important. Preparez votre projet professionnel.').

get_concours_admission(K, E, C) :- concours_admission(K, E, C).


% FIX UTF8
concours_admission(medecine, 'Epreuves QCM (Coef 1) : Maths, SVT, Physique-Chimie.', '?? Seuil 2024 : 13.00/20. \n?? Astuce : Soyez rapide, utilisez des astuces mathematiques (ne calculez pas tout). \n?? 3 Epreuves QCM (Maths et SVT sont cruciales).').

:- discontiguous concours_admission/3.


% =======================================================
% BASE DE CONNAISSANCES V2 (APPENDED)
% =======================================================


% BASE DE CONNAISSANCES (Version 2)

% ------------------------------------------------------------------------------
% 1. SÉRIES DE BACCALAURÉAT
% ------------------------------------------------------------------------------
serie_bac('Sciences mathématiques A').
serie_bac('Sciences mathématiques B').
serie_bac('Sciences physiques').
serie_bac('Sciences de la Vie et de la Terre').
serie_bac('Sciences agricoles').
serie_bac('Sciences économiques').
serie_bac('Sciences de gestion comptable').
serie_bac('Sciences et technologies électriques').
serie_bac('Sciences et technologies mécaniques').
serie_bac('Arts appliqués').
serie_bac('Lettres').
serie_bac('Sciences humaines').
serie_bac('Langue arabe').
serie_bac('Sciences de la charia').
serie_bac('Bac Pro Industriel').
serie_bac('Bac Pro Services').
serie_bac('Bac Pro Agriculture').

% ------------------------------------------------------------------------------
% 2. SECTEURS DE FORMATION
% ------------------------------------------------------------------------------
secteur_formation('Sciences, technologie et industrie').
secteur_formation('Secteur médical et paramédical').
secteur_formation('Économie, gestion et logistique').
secteur_formation('Agriculture, élevage et médecine vétérinaire').
secteur_formation('Architecture et Travaux Publics').
secteur_formation('Secteur militaire et paramilitaire').
secteur_formation('Secteur du travail social').
secteur_formation('Tourisme et hôtellerie').
secteur_formation('Arts, Culture et Patrimoine').
secteur_formation('Audiovisuel et Cinéma').
secteur_formation('Sport et Éducation Physique').
secteur_formation('Langues, Lettres et Sciences Humaines').
secteur_formation('Secteur de l''éducation').
secteur_formation('Sciences religieuses').
secteur_formation('Développement Digital et IA').

% ------------------------------------------------------------------------------
% 3. ÉTABLISSEMENTS PUBLICS (Standardisés par Acronymes)
% Format: etablissement(Acronyme, Ville, Diplome, Duree, Acces).
% ------------------------------------------------------------------------------

% --- Ingénierie (ENSA, ENSAM, FST) ---
etablissement('ENSA', 'Tanger', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Agadir', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Oujda', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Marrakech', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Safi', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Fès', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Khouribga', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Kénitra', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Tétouan', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'El Jadida', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Al Hoceima', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Berrchid', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSA', 'Beni Mellal', 'Ingénieur d''État', 5, 'selection_concours').

etablissement('ENSAM', 'Meknès', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSAM', 'Casablanca', 'Ingénieur d''État', 5, 'selection_concours').
etablissement('ENSAM', 'Rabat', 'Ingénieur d''État', 5, 'selection_concours').

etablissement('FST', 'Mohammedia', 'DEUST', 2, 'selection').
etablissement('FST', 'Mohammedia', 'Ingénieur d''État', 5, 'selection').
etablissement('FST', 'Settat', 'DEUST', 2, 'selection').
etablissement('FST', 'Fès', 'DEUST', 2, 'selection').
etablissement('FST', 'Marrakech', 'DEUST', 2, 'selection').
etablissement('FST', 'Tanger', 'DEUST', 2, 'selection').

% --- Nouvelles Écoles d'Ingénieurs Spécialisées ---
etablissement('ENIAD', 'Berkane', 'Ingénieur IA', 5, 'selection_concours').
etablissement('ENSC', 'Kénitra', 'Ingénieur Chimie', 5, 'selection_concours').
etablissement('ESITH', 'Casablanca', 'Ingénieur Textile', 5, 'selection_concours').
etablissement('ESITH', 'Casablanca', 'Licence Pro', 3, 'selection').

% --- Commerce (ENCG, ISCAE) ---
etablissement('ENCG', 'Settat', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Tanger', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Agadir', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Marrakech', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Oujda', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Kénitra', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'El Jadida', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Fès', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Casablanca', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Dakhla', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Beni Mellal', 'Diplôme ENCG', 5, 'selection_concours').
etablissement('ENCG', 'Meknès', 'Diplôme ENCG', 5, 'selection_concours').

etablissement('ISCAE', 'Casablanca', 'Diplôme Grande École', 3, 'selection_concours').

% --- Médecine & Santé ---
etablissement('FMP', 'Rabat', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Casablanca', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Marrakech', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Fès', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Oujda', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Tanger', 'Doctorat en Médecine', 7, 'selection_concours').
etablissement('FMP', 'Agadir', 'Doctorat en Médecine', 7, 'selection_concours').

etablissement('FMP', 'Rabat', 'Doctorat en Pharmacie', 6, 'selection_concours').
etablissement('FMP', 'Casablanca', 'Doctorat en Pharmacie', 6, 'selection_concours').

etablissement('FMD', 'Rabat', 'Doctorat Dentaire', 6, 'selection_concours').
etablissement('FMD', 'Casablanca', 'Doctorat Dentaire', 6, 'selection_concours').

etablissement('ISPITS', 'Multi-villes', 'Licence Infirmier', 3, 'selection_concours').
etablissement('I3S', 'Settat', 'Licence Sc. Santé', 3, 'selection_concours').

% --- Facultés (Accès Direct) ---
etablissement('Faculté des Sciences', 'Rabat', 'DEUG', 2, 'direct').
etablissement('Faculté des Sciences', 'Rabat', 'Licence Fondamentale', 3, 'direct').
etablissement('Faculté des Sciences', 'Casablanca', 'Licence Fondamentale', 3, 'direct').
etablissement('FSJES', 'Multi-villes', 'Licence Droit/Éco', 3, 'direct').
etablissement('FLSH', 'Multi-villes', 'Licence Lettres', 3, 'direct').

% --- Prépas & Autres ---
etablissement('CPGE', 'Multi-villes', 'CPGE', 2, 'selection').
etablissement('EST', 'Multi-villes', 'DUT', 2, 'selection').
etablissement('BTS', 'Multi-villes', 'BTS', 2, 'selection').
etablissement('OFPPT', 'Multi-villes', 'Technicien Spécialisé', 2, 'selection').

% --- Secteur Militaire ---
etablissement('ARM', 'Meknès', 'Officier (Bac+5)', 5, 'selection_concours').
etablissement('ERA', 'Marrakech', 'Officier Pilote', 5, 'selection_concours').
etablissement('ERN', 'Casablanca', 'Officier Marine', 5, 'selection_concours').
etablissement('ERSSM', 'Rabat', 'Médecin Militaire', 7, 'selection_concours').

% --- Arts & Sport ---
etablissement('INBA', 'Tétouan', 'Diplôme Beaux-Arts', 4, 'selection_concours').
etablissement('ISADAC', 'Rabat', 'Diplôme Art Dramatique', 4, 'selection_concours').
etablissement('IRFC/JS', 'Salé', 'Licence Pro Sport', 3, 'selection_concours').

% --- Architecture & Urbanisme ---
etablissement('ENA', 'Rabat', 'Architecte', 6, 'selection_concours').
etablissement('ENA', 'Fès', 'Architecte', 6, 'selection_concours').
etablissement('ENA', 'Marrakech', 'Architecte', 6, 'selection_concours').
etablissement('INAU', 'Rabat', 'Diplôme Urbanisme', 5, 'selection_concours').

% ------------------------------------------------------------------------------
% 4. FILIÈRES DE FORMATION (Lien Bac -> Formation)
% ------------------------------------------------------------------------------

% === Pour Bac Sciences Maths A & B ===
filiere('Sciences mathématiques A', 'Sciences, technologie et industrie', 'Génie Informatique', 'ENSA', '5 ans', 'Ingénieur d''État').
filiere('Sciences mathématiques A', 'Sciences, technologie et industrie', 'Génie Civil', 'EHTP', '5 ans', 'Ingénieur d''État').
filiere('Sciences mathématiques A', 'Sciences, technologie et industrie', 'Classes Prépas MPSI', 'CPGE', '2 ans', 'CPGE').
filiere('Sciences mathématiques A', 'Architecture et Travaux Publics', 'Architecture', 'ENA', '6 ans', 'Architecte').
filiere('Sciences mathématiques A', 'Secteur militaire et paramilitaire', 'Officier Ingénieur', 'ARM', '5 ans', 'Officier').
filiere('Sciences mathématiques B', 'Sciences, technologie et industrie', 'Génie Industriel', 'ENSA', '5 ans', 'Ingénieur d''État').
filiere('Sciences mathématiques B', 'Sciences, technologie et industrie', 'Pilotage', 'ERA', '5 ans', 'Officier Pilote').

% === Pour Bac Sciences Physiques (PC) ===
filiere('Sciences physiques', 'Sciences, technologie et industrie', 'Génie Mécatronique', 'ENSA', '5 ans', 'Ingénieur d''État').
filiere('Sciences physiques', 'Sciences, technologie et industrie', 'Génie Mécanique', 'ENSAM', '5 ans', 'Ingénieur d''État').
filiere('Sciences physiques', 'Sciences, technologie et industrie', 'Intelligence Artificielle', 'ENIAD', '5 ans', 'Ingénieur IA').
filiere('Sciences physiques', 'Sciences, technologie et industrie', 'Classes Prépas PCSI', 'CPGE', '2 ans', 'CPGE').
filiere('Sciences physiques', 'Secteur médical et paramédical', 'Soins Infirmiers', 'ISPITS', '3 ans', 'Licence Infirmier').
filiere('Sciences physiques', 'Secteur médical et paramédical', 'Kinésithérapie', 'ISPITS', '3 ans', 'Licence Kiné').
filiere('Sciences physiques', 'Secteur militaire et paramilitaire', 'Officier Marine', 'ERN', '5 ans', 'Officier Marine').

% === Pour Bac SVT ===
filiere('Sciences de la Vie et de la Terre', 'Secteur médical et paramédical', 'Médecine Générale', 'FMP', '7 ans', 'Doctorat en Médecine').
filiere('Sciences de la Vie et de la Terre', 'Secteur médical et paramédical', 'Médecine Dentaire', 'FMD', '6 ans', 'Doctorat Dentaire').
filiere('Sciences de la Vie et de la Terre', 'Secteur médical et paramédical', 'Pharmacie', 'FMP', '6 ans', 'Doctorat en Pharmacie').
filiere('Sciences de la Vie et de la Terre', 'Agriculture, élevage et médecine vétérinaire', 'Agronomie', 'IAV Hassan II', '5 ans', 'Ingénieur Agronome').
filiere('Sciences de la Vie et de la Terre', 'Sciences, technologie et industrie', 'Génie des Procédés', 'ENSA', '5 ans', 'Ingénieur d''État').

% === Pour Bac Économie & Gestion ===
filiere('Sciences économiques', 'Économie, gestion et logistique', 'Commerce International', 'ENCG', '5 ans', 'Diplôme ENCG').
filiere('Sciences économiques', 'Économie, gestion et logistique', 'Management', 'ENCG', '5 ans', 'Diplôme ENCG').
filiere('Sciences économiques', 'Économie, gestion et logistique', 'Licence Économie', 'FSJES', '3 ans', 'Licence').
filiere('Sciences économiques', 'Classes Prépas ECT', 'CPGE', '2 ans', 'CPGE').
filiere('Sciences de gestion comptable', 'Économie, gestion et logistique', 'Audit et Contrôle', 'ENCG', '5 ans', 'Diplôme ENCG').
filiere('Sciences de gestion comptable', 'Économie, gestion et logistique', 'Expertise Comptable', 'ISCAE', '3 ans', 'Diplôme Grande École').

% === Pour Bac Lettres & Humaines ===
filiere('Lettres', 'Langues, Lettres et Sciences Humaines', 'Études Anglaises', 'FLSH', '3 ans', 'Licence').
filiere('Lettres', 'Communication et médias', 'Journalisme', 'ISIC', '3 ans', 'Licence Info-Com').
filiere('Lettres', 'Tourisme et hôtellerie', 'Animation Touristique', 'ISITT', '3 ans', 'Diplôme Cycle Normal').
filiere('Sciences humaines', 'Secteur du travail social', 'Action Sociale', 'INAS', '3 ans', 'Diplôme INAS').
filiere('Sciences humaines', 'Langues, Lettres et Sciences Humaines', 'Psychologie', 'FLSH', '3 ans', 'Licence').

% === Pour Bac Technique (Élec/Méca) ===
filiere('Sciences et technologies électriques', 'Sciences, technologie et industrie', 'Génie Électrique', 'ENSET', '5 ans', 'Ingénieur d''État').
filiere('Sciences et technologies électriques', 'Sciences, technologie et industrie', 'Électromécanique', 'BTS', '2 ans', 'BTS').
filiere('Sciences et technologies mécaniques', 'Sciences, technologie et industrie', 'Génie Mécanique', 'ENSAM', '5 ans', 'Ingénieur d''État').
filiere('Sciences et technologies mécaniques', 'Sciences, technologie et industrie', 'Maintenance Industrielle', 'EST', '2 ans', 'DUT').

% === Pour Bac Arts Appliqués ===
filiere('Arts appliqués', 'Beaux-Arts et Design', 'Arts Plastiques', 'INBA', '4 ans', 'Diplôme Beaux-Arts').
filiere('Arts appliqués', 'Beaux-Arts et Design', 'Architecture d''Intérieur', 'ESBA', '4 ans', 'Diplôme Beaux-Arts').
filiere('Arts appliqués', 'Architecture et Travaux Publics', 'Architecture', 'ENA', '6 ans', 'Architecte').

% ------------------------------------------------------------------------------
% 5. PLATEFORMES D'ACCÈS
% ------------------------------------------------------------------------------
plateforme('FST', 'www.tawjihi.ma').
plateforme('ENSA', 'www.ensa-concours.ma').
plateforme('ENCG', 'www.tafem.ma').
plateforme('CPGE', 'www.cpge.ac.ma').
plateforme('EST', 'www.tawjihi.ma').
plateforme('FMP', 'www.cursussup.gov.ma').
plateforme('FMD', 'www.cursussup.gov.ma').
plateforme('ISPITS', 'ispits.sante.gov.ma').

% ------------------------------------------------------------------------------
% 6. SPÉCIALITÉS PAR ÉTABLISSEMENT (Exemples)
% ------------------------------------------------------------------------------
specialite('Faculté des Sciences', 'Mathématiques').
specialite('Faculté des Sciences', 'Physique').
specialite('FST', 'Informatique').
specialite('FST', 'Génie Civil').
specialite('ENSA', 'Génie Informatique').
specialite('ENSA', 'Génie Industriel').
specialite('ENSAM', 'Génie Mécanique').
specialite('CPGE', 'MPSI').
specialite('CPGE', 'PCSI').
specialite('CPGE', 'ECT').

% ------------------------------------------------------------------------------
% 7. DÉBOUCHÉS PROFESSIONNELS
% ------------------------------------------------------------------------------
debouche_associe('Génie Informatique', 'Développeur, Architecte Logiciel').
debouche_associe('Médecine Générale', 'Médecin Généraliste').
debouche_associe('Médecine Dentaire', 'Dentiste').
debouche_associe('Pharmacie', 'Pharmacien d''officine ou industriel').
debouche_associe('Génie Civil', 'Ingénieur BTP, Chef de chantier').
debouche_associe('Commerce International', 'Manager Export, Acheteur').
debouche_associe('Audit et Contrôle', 'Auditeur financier, Contrôleur de gestion').
debouche_associe('Journalisme', 'Journaliste, Rédacteur web').
debouche_associe('Soins Infirmiers', 'Infirmier polyvalent').
debouche_associe('Architecture', 'Architecte urbaniste').



%  RÈGLES D'ORIENTATION POST-BAC - MAROC 

% ------------------------------------------------------------------------------
% 1. Orientation Générale
% ------------------------------------------------------------------------------

% Règle 1: Orientation vers les filières scientifiques
orientation_scientifique(Etablissement, Diplome, Ville) :-
    etablissement(Etablissement, Ville, Diplome, _, _),
    member(Diplome, ['DEUG', 'Licence Fondamentale', 'DEUST', 'Ingénieur d''État', 'Ingénieur IA', 'Ingénieur Chimie']).

% Règle 2: Orientation médecine pour Bac Sciences
orientation_medecine(Etablissement, Diplome, Ville) :-
    etablissement(Etablissement, Ville, Diplome, _, 'selection_concours'),
    member(Diplome, ['Doctorat en Médecine', 'Doctorat en Pharmacie', 'Doctorat Dentaire']).

% Règle 3: Orientation prépas scientifiques
orientation_prepas(Etablissement) :-
    etablissement(Etablissement, _, 'CPGE', _, 'selection').

% ------------------------------------------------------------------------------
% 2. Règles d'Accès
% ------------------------------------------------------------------------------

% Règle 4: Accès direct pour les facultés
acces_direct(Etablissement, Diplome) :-
    etablissement(Etablissement, _, Diplome, _, 'direct').

% Règle 5: Accès par sélection/concours
acces_concours(Etablissement, Diplome) :-
    etablissement(Etablissement, _, Diplome, _, Acces),
    member(Acces, ['selection', 'selection_concours', 'concours_national']).

% ------------------------------------------------------------------------------
% 3. Règles par Durée de Formation
% ------------------------------------------------------------------------------

% Règle 6: Formations longues (≥5 ans)
formation_longue(Etablissement, Diplome) :-
    etablissement(Etablissement, _, Diplome, Duree, _),
    Duree >= 5.

% Règle 7: Formations courtes (2-3 ans)
formation_courte(Etablissement, Diplome) :-
    etablissement(Etablissement, _, Diplome, Duree, _),
    Duree =< 3.

% Règle 8: Formations moyennes (4 ans)
formation_moyenne(Etablissement, Diplome) :-
    etablissement(Etablissement, _, Diplome, 4, _).

% ------------------------------------------------------------------------------
% 4. Règles de Spécialité & Recherche Avancée
% ------------------------------------------------------------------------------

% Règle 9: Vérification de spécialité disponible
specialite_disponible(Etablissement, Specialite) :-
    specialite(Etablissement, Specialite).

% Règle 10: Filières accessibles par série de bac
filiere_accessibles(Bac, Filiere, Secteur, Etablissement, Duree, Diplome) :-
    serie_bac(Bac),
    filiere(Bac, Secteur, Filiere, Etablissement, Duree, Diplome).

% Règle 11: Filières par secteur d'intérêt
filiere_par_secteur(Bac, Secteur, Filiere, Etablissement, Duree, Diplome) :-
    serie_bac(Bac),
    secteur_formation(Secteur),
    filiere(Bac, Secteur, Filiere, Etablissement, Duree, Diplome).

% Règle 12: Filières par durée spécifique
filiere_par_duree(Bac, Duree, Filiere, Secteur, Etablissement, Diplome) :-
    filiere(Bac, Secteur, Filiere, Etablissement, Duree, Diplome).

% Règle 13: Établissements par type d'accès
etablissement_par_acces(Nom, Ville, Diplome, Duree, Acces) :-
    etablissement(Nom, Ville, Diplome, Duree, Acces).

% Règle 14: Filières par établissement
filieres_etablissement(Etablissement, Bac, Filiere, Secteur, Duree, Diplome) :-
    filiere(Bac, Secteur, Filiere, Etablissement, Duree, Diplome).

% Règle 15: Filières avec accès direct (sans concours)
filiere_acces_direct(Bac, Filiere, Etablissement) :-
    filiere(Bac, _, Filiere, Etablissement, _, _),
    etablissement(Etablissement, _, _, _, 'direct').

% ------------------------------------------------------------------------------
% 5. Règles de Conseil et Recommandation
% ------------------------------------------------------------------------------

% Règle 17: Conseils d'orientation basés sur les notes
conseil_orientation(Bac, Note_Maths, Note_Physique, Recommandation) :-
    serie_bac(Bac),
    (Note_Maths >= 15, Note_Physique >= 14 ->
        Recommandation = 'Ingénierie, Médecine ou Architecture recommandées (CPGE/ENSA/ENA)';
    Note_Maths >= 15 ->
        Recommandation = 'Sciences exactes, Ingénierie et Technologies (ENSA/FST)';
    Note_Physique >= 14 ->
        Recommandation = 'Sciences de la vie, Médical et Paramédical (FMP/ISPITS)';
    Recommandation = 'Toutes les filières universitaires et techniques sont accessibles selon vos intérêts').

% Règle 18: Recommandation par profil étudiant
recommandation_profil(Bac, Interet, Filiere, Etablissement) :-
    serie_bac(Bac),
    secteur_formation(Interet),
    filiere(Bac, Interet, Filiere, Etablissement, _, _).

% Règle 19: Comparaison de filières par durée
comparer_duree(Filiere1, Filiere2, Resultat) :-
    filiere(_, _, Filiere1, _, Duree1, _),
    filiere(_, _, Filiere2, _, Duree2, _),
    (Duree1 < Duree2 -> Resultat = 'plus_courte';
     Duree1 > Duree2 -> Resultat = 'plus_longue';
     Resultat = 'meme_duree').

% Règle 20: Débouchés professionnels (DYNAMIQUE)
% Cette règle va maintenant chercher dans la base de faits unifiée
debouches_filiere(Filiere, Debouche) :-
    debouche_associe(Filiere, Debouche).

% ------------------------------------------------------------------------------
% 6. Règles Utilitaires
% ------------------------------------------------------------------------------
% Règle 21: Vérification de compatibilité bac-filière
compatible_bac_filiere(Bac, Filiere) :-
    filiere(Bac, _, Filiere, _, _, _).

% Règle 22: Établissements dans une ville donnée
etablissements_ville(Ville, Etablissement, Diplome) :-
    etablissement(Etablissement, Ville, Diplome, _, _).

% Règle 23: Toutes les options pour un bac donné (Retourne une liste unique)
options_bac(Bac, Options) :-
    findall(Filiere, filiere(Bac, _, Filiere, _, _, _), FilieresList),
    list_to_set(FilieresList, Options).

% Règle 24: Recherche floue (Insensible à la casse)
recherche_floue_etablissement(Requete, Resultat) :-
    etablissement(Resultat, _, _, _, _),
    sub_atom_icasechk(Resultat, _, Requete).
