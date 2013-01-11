% partie syntaxique:
ph(p(GroupNom, GroupeVerbe)) --> group_nom(GroupeNom, Nombre,Genre), groupe_verbe(GroupeVerb,Nombre).
groupe_nom(gn(Determinant, Nom), Nombre, Genre) --> determinant(Determinant, Nombre, Genre), nom(Nom, Nombre, Genre).
groupe_nom(gn(Nom_Propre), sing, Genre) --> nomp(Nom_Propre, Genre).
groupe_verbe(gv(Verbe,GroupeNom), Nombre) --> verbe(Verbe, Nombre), groupe_nom(GroupeNom, _, _).
groupe_verbe(gv(Verbe), Nombre) --> verbe(Verbe, Nombre).

% partie lexicale:
determinant(d(Determinant), Nombre, Genre) --> [Determinant], {est_det(Determinant, Nombre, Genre)}.
nom(n(Nom), Nombre, Genre) --> [Nom], {est_nom(Nom, Nombre, Genre)}.
nomp(np(NomPropre), Genre) --> [NomPropre], {est_np(NomPropre, Genre)}.
verbe(v(Verbe), Nombre) --> [Verbe], {est_verbe(Verbe, Nom)}.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Dictionnaire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


personne(jean).
personne(marie).
personne(claude).

nom(fruit, comestible) :- nom(pomme, comestible).
nom(fruit, comestible) :- nom(orange, comestible).
nom(pomme, comestible).
nom(orange, comestible).
nom(jus, comestible).

nom(personne, anime) :- nom(etudiant, anime).
nom(etudiant, anime).

nom(machine, _).
nom(chanson, rien).
