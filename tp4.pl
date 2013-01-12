% partie syntaxique:
ph(semantique(SemantiqueNom, SemantiqueVerbe)) -->
  groupe_nom(Nombre, _, SemantiqueNom),
  groupe_verbe(Nombre, SemantiqueNom, SemantiqueVerbe).

groupe_nom(Nombre, Genre, SemantiqueNom) -->
  determinant(Nombre, Genre),
  nom(Nombre, Genre, SemantiqueNom).
groupe_nom(sing, Genre, SemantiqueNom) -->
  nomp(Genre, SemantiqueNom).

groupe_verbe(Nombre, Agent, SemantiqueVerbe) -->
  verbe_intransitif(Nombre, Agent, SemantiqueVerbe).
groupe_verbe(Nombre, Agent, SemantiqueVerbe) -->
  verbe_transitif(Nombre, Agent, Objet, SemantiqueVerbe),
  groupe_nom(_, _, Objet).

% partie lexicale:
determinant(Nombre, Genre) -->
  [Determinant],
  {est_det(Determinant, Nombre, Genre)}.
nom(Nombre, Genre, SemantiqueNom) --> 
  [Nom],
  {est_nom(Nom, Nombre, Genre, SemantiqueNom)}.
nomp(Genre, SemantiqueNomPropre) -->
  [NomPropre],
  {est_np(NomPropre, Genre, SemantiqueNomPropre)}.
verbe_intransitif(Nombre, Agent, SemantiqueVerbe) --> 
  [Verbe],
  {est_verbe_intransitif(Verbe, Nombre, Agent, SemantiqueVerbe)}.
verbe_transitif(Nombre, Agent, Objet, SemantiqueVerbe) --> 
  [Verbe],
  {est_verbe_transitif(Verbe, Nombre, Agent, Objet, SemantiqueVerbe)}.
preposition(Nombre, Agent, Objet, SemantiquePrep) -->
  [Preposition],
  {est_preposition(Preposition, Nombre, Agent, Objet, SemantiquePrep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Dictionnaire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
anime(jean).
comestible(pomme).

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
est_nom(chanson, sing, fem, chason).
est_nom(chansons, plur, fem, chason).

est_verbe_transitif(demande, sing, X, Y, demander(X, Y)).
est_verbe_transitif(demandent, plur, X, Y, demander(X, Y)).
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
est_preposition(aux, plus, X, Y, receveur(X, Y)).
est_preposition(de, sing, X, Y, constituant(X, Y)).
est_preposition(des, plur, X, Y, constituant(X, Y)).
