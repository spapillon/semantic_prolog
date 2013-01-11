% partie syntaxique:
ph(p(GroupeNom, GroupeVerbe)) -->
  groupe_nom(GroupeNom, Nombre, _, ClasseAgent),
  groupe_verbe(GroupeVerbe, Nombre, ClasseAgent).
groupe_nom(gn(Determinant, Nom), Nombre, Genre, Classe) -->
  determinant(Determinant, Nombre, Genre),
  nom(Nom, Nombre, Genre, Classe).
groupe_nom(gn(Nom_Propre), sing, Genre, actif) -->
 nomp(Nom_Propre, Genre).
groupe_verbe(gv(Verbe, GroupeNom), Nombre, ClasseAgent) -->
  verbe(Verbe, Nombre, ClasseAgent, ClasseObjet),
  groupe_nom(GroupeNom, _, _, ClasseObjet).
groupe_verbe(gv(Verbe), Nombre, ClasseAgent, ClasseObjet) -->
  verbe(Verbe, Nombre, ClasseAgent, ClassObjet).

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
verbe(v(Verbe), Nombre, ClassAgent, ClassObjet) --> 
  [Verbe],
  {est_verbe(Verbe, Nombre, ClasseAgent, ClasseObjet)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Dictionnaire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

est_np(Nom, sing, Genre) :-
  personne(Nom, Genre).
personne(jean, masc).
personne(marie, fem).
personne(claude, masc).

est_nom(Nom, Genre, Nombre, Classe) :-
  nom(Nom, Genre, Nombre, Classe).
nom(fruit, masc, sing, comestible).
nom(pomme, masc, sing, comestible).
nom(orange, fem, sing, comestible).
nom(jus, masc, sing, comestible).
nom(personne, fem, sing, anime).
nom(etudiant, masc, sing, anime).
nom(machine, fem, sing, _).
nom(chanson, fem, sing, rien).

est_verbe(Verbe, Nombre, ClasseAgent, ClasseObjet) :-
  verbe(Verbe, Nombre, ClasseAgent, ClasseObjet).
verbe(mange, sing, anime, comestible).
verbe(aime, sing, anime, _).
