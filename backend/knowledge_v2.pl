
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
