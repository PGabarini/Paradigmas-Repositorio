/*
¿Quién ayuda al Rasta?
[Hechos, reglas, predicados, generación, not]

Armar un programa Prolog que resuelva el siguiente problema lógico:

Quien ayuda a otra persona es porque la quiere y no tiene menos suerte que ella. Además,
 quien ayuda está en el aula.
Rasta, Polito y Santi son los únicos que están en el aula.
Santi quiere a todos los que están en el aula, siempre que no los quiera el Rasta.
Rasta quiere a todos los que están en el aula salvo a Polito.
Quien está en el aula y no es querido por Polito, tiene menos suerte que el Rasta.
Polito quiere a las mismas personas que quiere el Rasta.


El programa debe resolver el problema de quién ayuda al Rasta. 
(Pero debe poder permitir saber en general quién ayuda a quién). 
Dejar en un comentario en el código la consulta utilizada y la respuesta obtenida.
9 ?- quienAyudaA(rasta,Ayudante). 
Ayudante = santi ;
Ayudante = santi ;
Ayudante = santi ;
Ayudante = rasta ;
Ayudante = rasta ;
Ayudante = pollito.

Agregar los mínimos hechos y reglas necesarios para poder consultar:
- Si existe alguien que quiera a Milhouse.
- A quién quiere Santi.
3 ?- quiereA(santi,Persona).
Persona = rasta ;
Persona = pollito.

- El nombre de quien quiera a Rasta.
4 ?- quiereA(Persona,rasta).
Persona = santi ;
Persona = rasta ;
Persona = pollito.

- Todas las personas que se quieren.
5 ?- quiereA(Queredor,Querido).
Queredor = santi,
Querido = rasta ;
Queredor = santi,
Querido = pollito ;
Queredor = rasta,
Querido = santi ;
Queredor = Querido, Querido = rasta ;
Queredor = pollito,
Querido = rasta ;
Queredor = pollito,
Querido = santi.

- Si es cierto que Polito quiere a alguien.
6 ?- quiereA(pollito,_).
true ;
true.

*/
suerte(santi,4).
suerte(rasta,3).
suerte(pollito,2).

estaEnElAula(rasta).
estaEnElAula(pollito).
estaEnElAula(santi).

quiereA(santi,rasta).
quiereA(santi,pollito).

quiereA(rasta,santi).
quiereA(rasta,rasta).

quiereA(pollito,rasta).
quiereA(pollito,santi).

quienAyudaA(Persona1,Persona2):-
    quiereA(Persona2,Persona1),
    estaEnElAula(Persona2),
    noTieneMenosSuerte(Person1,Persona2).

noTieneMenosSuerte(Person1,Persona2):-
    suerte(Persona1,CantidadDeSuerte1),
    suerte(Persona2,CantidadDeSuerte2),
    CantidadDeSuerte2>=CantidadDeSuerte1.
    
