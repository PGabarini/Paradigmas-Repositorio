kiosquero(dodian).
kiosquero(lucas).
kiosquero(juanC).
kiosquero(juanFdS).
kiosquero(leoC).
kiosquero(maru).
kiosquero(vale).

atiende(dodian,lunes,9,15).
atiende(dodian,miercoles,9,15).
atiende(dodian,viernes,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabados,18,22).
atiende(juanC,domingos,18,22).

atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(maru,miercoles,23,24).

atiende(vale,Dia,HoraEntrada,HoraSalida):-
  atiende(dodian,Dia,HoraEntrada,HoraSalida).

atiende(vale,Dia,HoraEntrada,HoraSalida):-
  atiende(juanC,Dia,HoraEntrada,HoraSalida).

/*Punto 2: quién atiende el kiosko... (2 puntos)
Definir un predicado que permita relacionar un día y hora con una persona, 
en la que dicha persona atiende el kiosko. Algunos ejemplos:
si preguntamos quién atiende los lunes a las 14, son dodain, leoC y vale
si preguntamos quién atiende los sábados a las 18, son juanC y vale
si preguntamos si juanFdS atiende los jueves a las 11, nos debe decir que sí.
si preguntamos qué días a las 10 atiende vale, nos debe decir los lunes, miércoles y viernes.

El predicado debe ser inversible para relacionar personas y días.
*/

quienAtiende(Kiosquero,Dia,Horario):-
  kiosquero(Kiosquero),
  atiende(Kiosquero,Dia,HoraEntrada,HoraSalida),
  between(HoraEntrada, HoraSalida, Horario).
  
  /*Definir un predicado que permita saber si una persona en un día y 
  horario determinado está atendiendo ella sola. 
  En este predicado debe utilizar not/1, y debe ser inversible para relacionar personas.*/

  esForeverAlone(Kiosquero,Dia,Horario):-
    quienAtiende(Kiosquero,Dia,Horario),
    not((quienAtiende(OtroKiosquero,Dia,Horario),OtroKiosquero \= Kiosquero)).

  /*Dado un día, queremos relacionar qué personas podrían estar atendiendo el 
  kiosko en algún momento de ese día.+
   Por ejemplo, si preguntamos por el miércoles, tiene que darnos esta combinatoria:*/

posibilidadDeAtencion(Dia,Kiosqueros):-
  kiosquero(Kiosquero),
  findall(Kiosquero,quienAtiende(Kiosquero,Dia,_),ListaDeKiosueros),
  list_to_set(ListaDeKiosQueros,Kiosqueros).




%venta(Vendero,Dia,Mes,Producto)
venta(dodain,fecha(10, 8),golosinas(1200)).
venta(dodain,10,8,cigarrillos(jockey)).
venta(dodain,10,8,golosinas(50)).

venta(dodain,12,8,bebidas(true, 8)).
venta(dodain,12,8,bebidas(false, 1)).
venta(dodain,12,8,golosinas(10)).

/*Queremos saber si una persona vendedora es suertuda, esto ocurre si para todos los días en 
los que vendió, la primera venta que hizo fue importante. Una venta es importante:
en el caso de las golosinas, si supera los $ 100.
en el caso de los cigarrillos, si tiene más de dos marcas.
en el caso de las bebidas, si son alcohólicas o son más de 5.

El predicado debe ser inversible: martu y dodain son personas suertudas.
*/










