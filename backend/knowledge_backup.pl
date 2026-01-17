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
