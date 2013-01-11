% partie syntaxique:
ph(p(GroupeNom, GroupeVerbe)) -->
  groupe_nom(GroupeNom, Nombre, _, ClasseAgent),
  groupe_verbe(GroupeVerbe, Nombre, ClasseAgent).

groupe_nom(gn(Determinant, Nom), Nombre, Genre, Classe) -->
  determinant(Determinant, Nombre, Genre),
  nom(Nom, Nombre, Genre, Classe).
groupe_nom(gn(Nom_Propre), sing, Genre, anime) -->
  nomp(Nom_Propre, Genre).
groupe_nom(gn(GroupeNom1, Preposition, Nom), Nombre, Genre, Classe) -->
  groupe_nom(GroupeNom1, Nombre, Genre, Classe),
  preposition(Preposition, PrepNombre),
  nom(Nom, PrepNombre, _, _).
groupe_nom(gn(GroupeNom1, Preposition, Nom), Nombre, Genre, Classe) -->
  groupe_nom(GroupeNom1, Nombre, Genre, Classe),
  preposition(Preposition, _),
  nomp(Nom, _).

groupe_verbe(gv(Verbe), Nombre, ClasseAgent) -->
  verbe_intransitif(Verbe, Nombre, ClasseAgent).
groupe_verbe(gv(Verbe, GroupeNom), Nombre, ClasseAgent) -->
  verbe_transitif(Verbe, Nombre, ClasseAgent, ClasseObjet),
  groupe_nom(GroupeNom, _, _, ClasseObjet).

% partie lexicale:
determinant(d(Determinant), Nombre, Genre) -->
  [Determinant],
  {est_det(Determinant, Nombre, Genre)}.
nom(n(Nom), Nombre, Genre, Classe) --> 
  [Nom],
  {est_nom(Nom, Nombre, Genre, Classe)}.
nomp(np(NomPropre), Genre) -->
  [NomPropre],
  {est_np(NomPropre, Genre)}.
verbe_intransitif(v(Verbe), Nombre, ClasseAgent) --> 
  [Verbe],
  {est_verbe_intransitif(Verbe, Nombre, ClasseAgent)}.
verbe_transitif(v(Verbe), Nombre, ClasseAgent, ClasseObjet) --> 
  [Verbe],
  {est_verbe_transitif(Verbe, Nombre, ClasseAgent, ClasseObjet)}.
preposition(prep(Preposition), Nombre) -->
  [Preposition],
  {est_preposition(Preposition, Nombre)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Dictionnaire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

est_np(Nom, Genre) :-
  personne(Nom, Genre).
personne(jean, masc).
personne(marie, fem).
personne(claude, masc).

est_nom(Nom, Nombre, Genre, Classe) :-
  nom(Nom, Nombre, Genre, Classe).
nom(fruit, sing, masc, comestible).
nom(pomme, sing, fem, comestible).
nom(orange, sing, fem, comestible).
nom(jus,sing, masc, comestible).
nom(personne, sing, fem, anime).
nom(etudiant, sing, masc, anime).
nom(machine, sing, fem, _).
nom(chanson, sing, fem, rien).

est_verbe_transitif(Verbe, Nombre, ClasseAgent, ClasseObjet) :-
  verbe_transitif(Verbe, Nombre, ClasseAgent, ClasseObjet).
verbe_transitif(demande, sing, anime, _).
verbe_transitif(donne, sing, anime, _).
verbe_transitif(mange, sing, anime, comestible).
verbe_transitif(marche, sing, anime, _).

est_verbe_intransitif(Verbe, Nombre, ClasseAgent) :-
  verbe_intransitif(Verbe, Nombre, ClasseAgent).
verbe_intransitif(marche, sing, anime).
verbe_intransitif(chante, sing, anime).


est_det(Determinant, Genre, Nombre) :-
  det(Determinant, Genre, Nombre).
det(un, sing, masc).
det(une, sing, fem).
det(des, plur, _).
det(les, plur, _).

est_preposition(Preposition, Nombre) :-
  preposition(Preposition, Nombre).
preposition(a, sing).
preposition(de, sing).
preposition(des, plur).
