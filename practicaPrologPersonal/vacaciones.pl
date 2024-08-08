/*Sabemos que Dodain se va a Pehuenia, San Martín (de los Andes), 
Esquel, Sarmiento, Camarones y Playas Doradas. 
Alf, en cambio, se va a Bariloche, San Martín de los Andes y El Bolsón.
 Nico se va a Mar del Plata, como siempre. 
 Y Vale se va para Calafate y El Bolsón.

Además Martu se va donde vayan Nico y Alf. 
*/

persona(dodain).
persona(alf).
persona(nico).
persona(vale).
persona(martu).
persona(juan).
persona(carlos).

viajaA(dodain,[pehuenia,sanMartin,esquel,sarmiento,camaroes,playasDoradas]).
/*
viajaA(dodain,pehuenia).
viajaA(dodain,sanMartin).
viajaA(dodain,esquel).
viajaA(dodain,sarmiento).
viajaA(dodain,camaroes).
viajaA(dodain,playasDoradas).*/
viajaA(alf,[bariloche,sanMartin,elBolson]).
/*
viajaA(alf,bariloche).
viajaA(alf,sanMartin).
viajaA(alf,elBolson).*/

viajaA(nico,[marDelPlata]).
/*
viajaA(nico,marDelPlata).*/
viajaA(vale,[calafate,elBolson]).
/*
viajaA(vale,calafate).
viajaA(vale,elBolson).*/

viajaA(martu,Lugar):-
    viajaA(alf,Lugares),
    viajaA(nico,OtrosLugares),
    union(Lugares,OtrosLugares,Lugar).
/*
Agregue hechos a la base de conocimientos de ejemplo para dejar en claro
 cómo modelaría las atracciones. Por ejemplo: 
 Esquel tiene como atracciones
  un parque nacional (Los Alerces) y dos excursiones (Trochita y Trevelin).
 Villa Pehuenia tiene como atracciones un cerro (Batea Mahuida de 2.000 m) 
 y dos cuerpos de agua (Moquehue, donde se puede pescar y tiene 14 grados 
 de temperatura promedio y Aluminé, donde se puede pescar y tiene 19 grados
  de temperatura promedio).*/

%parqueNacional(Nombre).
%cerro(Nombre,Altura).
%cuerpoDeAgua(Cuerpo,PescaSiONo,TemPromedioAgua).
%playa(mareaPromedio).
%excursion(Nombre).

atraccion(esquel,parqueNacional(losAlerces)).
atraccion(esquel,excursion(trochita)).
atraccion(esquel,excursion(travelin)).

atraccion(villaPehuenia,cerro(bateaMahuida,2001)).
atraccion(villaPehuenia,cuerpoDeAgua(moquehue,sePuedePesca,14)).
atraccion(villaPehuenia,cuerpoDeAgua(alumine,sePuedePesca,22)).

/*Queremos saber qué vacaciones fueron copadas para una persona.
 Esto ocurre cuando todos los lugares a visitar tienen por lo menos una atracción copada. 
un cerro es copado si tiene más de 2000 metros
un cuerpoAgua es copado si se puede pescar o la temperatura es mayor a 20
una playa es copada si la diferencia de mareas es menor a 5
una excursión que tenga más de 7 letras es copado
cualquier parque nacional es copado
El predicado debe ser inversible. 
*/

esAtraccionCopada(Atraccion):-
    atraccion(_,Atraccion),
    esCopada(Atraccion).

esCopada(parqueNacional(_)).

esCopada(cerro(_,Metros)):-
    Metros >2000.

esCopada(excursion(_)).  

esCopada(cuerpoDeAgua(_,sePuedePesca,Temperatura)):-
    Temperatura > 20.

esCopada(playa(DiferenciaDeMarea)):-
    DiferenciaDeMarea < 5.

/*Cuando dos personas distintas no coinciden en ningún lugar como destino 
decimos que no se cruzaron. Por ejemplo, Dodain no se cruzó con Nico 
ni con Vale (sí con Alf en San Martín de los Andes). Vale no se cruzó con 
Dodain ni con Nico (sí con Alf en El Bolsón). 
El predicado debe ser completamente inversible.*/
/*
noSeCruzaron(Persona,OtraPersona):-
    persona(Persona),
    persona(OtraPersona),
    not((viajaA(Persona,Lugar),viajaA(OtraPersona,Lugar))).*/

noSeCruzaron(Persona,OtraPersona):-
    viajaA(Persona,Lugares),
    viajaA(OtraPersona,OtrosLugares),
    Persona \=OtraPersona,
    not((member(Destino, Lugares),member(Destino, OtrosLugares))).
    /*
    intersection(Lugares,OtrosLugares,Coincidencias),
    length(Coincidencias,Cantidad),
    Cantidad <1.*/



costoDeVida(sarmiento,100).
costoDeVida(esquel,150).
costoDeVida(pehuenia,180).
costoDeVida(sanMartin,150).
costoDeVida(camaroes,135).
costoDeVida(playasDoradas,170).
costoDeVida(bariloche,140).
costoDeVida(calafate,240).
costoDeVida(elBolson,145).
costoDeVida(marDelPlata,140).

/*
Queremos saber si unas vacaciones fueron gasoleras para una persona. 
Esto ocurre si todos los destinos son gasoleros, es decir, tienen 
un costo de vida menor a 160. Alf, Nico y Martu hicieron vacaciones gasoleras.
El predicado debe ser inversible.
*/
sonVacacionesGasoleras(Persona):-
    viajaA(Persona,_),
    forall(viajaA(Persona,Lugar),esLugarGasolero(Lugar)).

esLugarGasolero(Lugar):-
    costoDeVida(Lugar,Costo),
    Costo < 160.