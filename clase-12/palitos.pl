/*animal(Nombre,Clase, Medio)*/
animal(ballena,mamifero,acuatico).
animal(tiburon,pez,acuatico).
animal(lemur,mamifero,terrestre).
animal(golondrina,ave,aereo).
animal(tarantula,insecto,terrestre).
animal(lechuza,ave,aereo).
animal(orangutan,mamifero,terrestre).
animal(tucan,ave,aereo).
animal(puma,mamifero,terrestre).
animal(abeja,insecto,aereo).
animal(leon,mamifero,terrestre).
animal(lagartija,reptil,terrestre).
animal(murcielago,mamifero,aereo).

/* tiene(Quien, Que, Cuantos)*/
tiene(nico, ballena, 1).
tiene(nico, lemur, 2).
tiene(maiu, lemur, 1).
tiene(maiu, tarantula, 1).
tiene(juanDS, golondrina, 1).
tiene(juanDS, lechuza, 1).
tiene(juanR, tiburon, 2).
tiene(nico, golondrina, 1).
tiene(juanDS, puma, 1).
tiene(maiu, tucan, 1).
tiene(juanR, orangutan,1).
tiene(maiu,leon,2).
tiene(juanDS,lagartija,1).
tiene(feche,tiburon,1).

% leGusta(Quien,Cual)
leGusta(nico,Cual):-
    animal(Cual,_,terrestre),
    Cual  \= lemur.
leGusta(maiu,abeja).
leGusta(maiu,Cual):-
    animal(Cual,Clase,_),
    Clase  \= insecto.
leGusta(juanDS,Cual):-
    animal(Cual,_,acuatico).
leGusta(juanDS,Cual):-
    animal(Cual,ave,_).
leGusta(juanR,_).
leGusta(feche,lechuza).

% animalDificil/1: si nadie lo tiene, o bien si una sola persona tiene uno solo.
%nadie lo tiene
animalDificil(UnAnimal):-
    not(tiene(_,UnAnimal,_)).

%solo uno tiene uno
animalDificil(UnAnimal):-
    tiene(Alguien,UnAnimal,1),
    not((tiene(Otro,UnAnimal,_), %no existe otra persona que tenga al animal
    Otro \= Alguien)).


% estaFeliz/1: si le gustan todos los animales que tiene.
estaFeliz(Alguien):- %si lo tiene entonces le gusta (equivalente a: o no lo tiene o le gusta)(¬A v B == A => B)
    tiene(Alguien, _, _),
    forall(tiene(Alguien,Animal,_), leGusta(Alguien,Animal)).

%forall(antecedente,consecuente):- "Si <antecedente>, entonces <consecuente>"
% tieneTodosDe/2: si la persona tiene todos los animales de ese medio o clase.
 tieneTodosDe(Persona,Medio):-
    tiene(Persona, _, _),
    animal(_, _, Medio),
    forall(tiene(Persona,Animal,_), animal(Animal, _, Medio)).

tieneTodosDe(Persona,Clase):-
    tiene(Persona, _, _),
    animal(_, Clase, _),
    forall(tiene(Persona,Animal,_), animal(Animal, Clase, _)).  %REPITO LOGICA


% completoLaColeccion/1: si la persona tiene todos los animales.
completoLaColeccion(Persona):-
    tiene(Persona, _, _), %ligo persona para que evalue siempre desde la misma persona, no ligo animal para que en cada evaluacion, evalue cada animal existente
    forall(animal(Animal, _, _), tiene(Persona,Animal,_))

% delQueMasTiene/2: si la persona tiene más de este animal que del resto.
/*delQueMasTiene(Persona,Animal):-
    %animal(Animal, _, _),
    tiene(Persona, Animal, _),
    forall(tiene(Otro,Animal,_),tieneMas(Persona,Otro,Animal)).

tieneMas(Persona,Otro,Animal):-
    tiene(Persona,Animal,UnaCantidad),
    tiene(Otro,Animal,OtraCantidad),
    UnaCantidad > OtraCantidad,
    Persona \= Otro.*/

delQueMasTiene(Persona,Animal):-
    tiene(Persona,Animal,Cantidad),
    forall( 
        (tiene(Persona, OtroAnimal, CantidadDelOtro), Animal\=OtroAnimal) %Antecedente: Si la persona tiene otro animal distinto de Animal
        Cantidad > CantidadDelOtro).                                      %Consecuente: La Cantidad de Animal es mayor que la del Otro