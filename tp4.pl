% partie syntaxique:
% partie lexicale:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Analyse Syntaxique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phrase avec preposition
ph(semantique(SemantiqueNom, SemantiqueVerbe, SemantiquePreposition)) -->
  groupe_nom(Nombre, _, SemantiqueNom),
  groupe_verbe(Nombre, SemantiqueNom, SemantiqueVerbe, SemantiquePreposition).

% Phrase sans preposition
ph(semantique(SemantiqueNom, SemantiqueVerbe)) -->
  groupe_nom(Nombre, _, SemantiqueNom),
  groupe_verbe(Nombre, SemantiqueNom, SemantiqueVerbe).

% Groupe nom {Determinant Nom}
groupe_nom(Nombre, Genre, SemantiqueNom) -->
  determinant(Nombre, Genre),
  nom(Nombre, Genre, SemantiqueNom).

% Nom propre
groupe_nom(sing, Genre, SemantiqueNom) -->
  nomp(Genre, SemantiqueNom).

% Nom seul
groupe_nom(Nombre, Genre, SemantiqueNom) -->
  nom(Nombre, Genre, SemantiqueNom).

% Verbe intransitif (pas de groupe nom apres)
groupe_verbe(Nombre, Agent, SemantiqueVerbe) -->
  verbe_intransitif(Nombre, Agent, SemantiqueVerbe).

% Verbe transitif (contient un groupe nom apres le verbe)
groupe_verbe(Nombre, Agent, SemantiqueVerbe) -->
  verbe_transitif(Nombre, Agent, Objet, SemantiqueVerbe),
  groupe_nom(_, _, Objet).

% Verbe transitif avec preposition.
groupe_verbe(Nombre, Agent, SemantiqueVerbe, SemantiquePreposition) -->
  verbe_transitif(Nombre, Agent, Objet, SemantiqueVerbe),
  groupe_nom(_, _, Objet),
  preposition(NombrePrep, Objet, ObjetPrep, SemantiquePreposition),
  groupe_nom(NombrePrep, _, ObjetPrep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Analyse Lexicale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determinant avec nombre et genre.
determinant(Nombre, Genre) -->
  [Determinant],
  {est_det(Determinant, Nombre, Genre)}.

% Nom commun avec un nombre et genre.
% Seulement utilise pour la preposition.
nom(Nombre, Genre, SemantiqueNom) --> 
  [Nom],
  {est_nom(Nom, Nombre, Genre, SemantiqueNom)}.

% Nom propre avec le genre seulement.
nomp(Genre, SemantiqueNomPropre) -->
  [NomPropre],
  {est_np(NomPropre, Genre, SemantiqueNomPropre)}.

% Verbe intransitif ou l'objet est absent.
verbe_intransitif(Nombre, Agent, SemantiqueVerbe) --> 
  [Verbe],
  {est_verbe_intransitif(Verbe, Nombre, Agent, SemantiqueVerbe)}.

% Verbe transitif ou l'objet fait partie de la semantique
verbe_transitif(Nombre, Agent, Objet, SemantiqueVerbe) --> 
  [Verbe],
  {est_verbe_transitif(Verbe, Nombre, Agent, Objet, SemantiqueVerbe)}.

% Preposition 
preposition(Nombre, Agent, Objet, SemantiquePrep) -->
  [Preposition],
  {est_preposition(Preposition, Nombre, Agent, Objet, SemantiquePrep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Analyse Semantique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
anime(jean).
anime(personne).
anime(etudiant).
anime(machine).
comestible(pomme).

comestible(X) :- fruit(X).
comestible(X) :- jus(X).
fruit(X) :- pomme(X).
fruit(X) :- orange(X).

anime(X) :- personne(X).
etudiant(X) :- personne(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Dictionnaire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
est_np(jean, masc, jean).
est_np(marie, fem, marie).
est_np(claude, masc, claude).

est_nom(fruit, sing, masc, fruit).
est_nom(fruits, plur, masc, fruit).
est_nom(pomme, sing, fem, pomme).
est_nom(pommes, plur, fem, pomme).
est_nom(orange, sing, fem, orange).
est_nom(oranges, plur, fem, orange).
est_nom(jus, sing, _, jus).
est_nom(personne, sing, fem, personne).
est_nom(personnes, plur, fem, personne).
est_nom(etudiant, sing, masc, etudiant).
est_nom(etudiants, plur, masc, etudiant).
est_nom(machine, sing, fem, machine).
est_nom(machines, plur, fem, machine).
est_nom(chanson, sing, fem, chanson).
est_nom(chansons, plur, fem, chanson).

est_verbe_transitif(demande, sing, X, Y, demander(X, Y)) :-
  anime(X).
est_verbe_transitif(demandent, plur, X, Y, demander(X, Y)) :-
  anime(X).
est_verbe_transitif(mange, sing, X, Y, manger(X,Y)) :-
  anime(X),
  comestible(Y).
est_verbe_transitif(mangent, plur, X, Y, manger(X,Y)) :-
  anime(X),
  comestible(Y).
est_verbe_transitif(aiment, plur, X, Y, aimer(X,Y)) :-
  anime(X).
est_verbe_transitif(aime, sing, X, Y, aimer(X,Y)) :-
  anime(X).
est_verbe_intransitif(mange, sing, X, manger(X)) :-
  anime(X).
est_verbe_intransitif(mangent, plur, X, manger(X)) :-
  anime(X).

est_det(un, sing, masc).
est_det(une, sing, fem).
est_det(des, plur, _).
est_det(les, plur, _).

est_preposition(a, sing, X, Y, receveur(X, Y)).
est_preposition(aux, plur, X, Y, receveur(X, Y)).
est_preposition(de, sing, X, Y, constituant(X, Y)).
est_preposition(des, plur, X, Y, constituant(X, Y)).
