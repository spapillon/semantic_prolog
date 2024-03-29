%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Analyse Syntaxique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phrase avec preposition
analyse([SemantiqueVerbe, SemantiquePreposition]) -->
  groupe_nom(Nombre, _, SemantiqueNom),
  groupe_verbe(Nombre, SemantiqueNom, SemantiqueVerbe, SemantiquePreposition).

% Phrase sans preposition
analyse([SemantiqueVerbe]) -->
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
%                             Analyse Lexicale
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
%                           Analyse Semantique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

anime(X) :- personne(X).

personne(jean).
personne(marie).
personne(claude).

comestible(pomme).
comestible(orange).
comestible(fruit).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Dictionnaire
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Interface
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Boucle d'interface avec l'usager.
interface :-
  repeat,
  read(Input),
  executer(Input), !.

% Force la sortie de la boucle d'interface.
executer(fin).

% Execute une phrase du format d'une question.
executer([est-ce, que| Question]) :-
  analyse_question(Question),
  interface.

% Execute l'analyse semantique de la phrase
% et procede a l'insertion des faits dans la
% base de conaissance.
executer(Input) :-
  ((analyse(Semantique, Input,[]),
  inserer_faits(Semantique));
  (write('Phrase incorrecte'), nl)),
  interface.

% Analyse les faits demandes dans la question.
analyse_question(Question) :-
  analyse(Faits, Question, []),
  recherche_faits(Faits).

% Tous les faits ont etes inseres correctement.
inserer_faits([]) :-
  write('Les faits ont etes correctement inseres'), nl.

% Insere recursivement des faits dans la base de conaissance.
inserer_faits([Fait|Reste]) :-
  asserta(Fait),
  inserer_faits(Reste).

% La listes des faits a ete completee, la reponse a la question
% est oui.
recherche_faits([]) :-
  write(yes), nl.

% Questionne recursivement la base de conaissance et tente
% d'appeler les predicats (faits).  Si on d'eux n'est pas trouve,
% la reponse a la question est non.
recherche_faits([Fait|Reste]) :-
  (call(Fait),
  recherche_faits(Reste);
  write(no), nl).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Definitions dynamiques 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-dynamic(receveur/2).
:-dynamic(aimer/2).
:-dynamic(demander/2).
:-dynamic(manger/2).
:-dynamic(constituant/2).

receveur(nil,nil).
aimer(nil,nil).
demander(nil,nil).
manger(nil,nil).
constituant(nil,nil).
