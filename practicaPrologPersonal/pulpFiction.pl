personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

/*.1 esPeligroso/1. Nos dice si un personaje es peligroso. Eso ocurre cuando:
-realiza alguna actividad peligrosa: ser matón, o robar licorerías. 
-tiene empleados peligrosos
*/
esPeligroso(Personaje):-
    trabajaPara(Personaje,Empleado),
    esPeligroso(Empleado).

esPeligroso(Personaje):-
    personaje(Personaje,Actividad),
    esActividadPeligrosa(Actividad).

esActividadPeligrosa(mafioso(maton)).
esActividadPeligrosa(ladron(LugaresRobados)):-
    member(licorerias,LugaresRobados).

/*2. duoTemible/2 que relaciona dos personajes cuando son peligrosos y
 además son pareja o amigos. Considerar que Tarantino también nos dió
  los siguientes hechos:
*/

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje,OtroPersonaje):-
    personaje(Personaje,_),
    personaje(OtroPersonaje,_),
    sonPeligrosos(Personaje,OtroPersonaje),
    sonConocidos(Personaje,OtroPersonaje).

sonPeligrosos(Personaje,OtroPersonaje):-
    Personaje \= OtroPersonaje,
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje).

sonConocidos(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
sonConocidos(Personaje,OtroPersonaje):-
    pareja(Personaje,OtroPersonaje).

/*3.  estaEnProblemas/1: un personaje está en problemas cuando 
el jefe es peligroso y le encarga que cuide a su pareja
o bien, tiene que ir a buscar a un boxeador. 
Además butch siempre está en problemas. 

Ejemplo:
? estaEnProblemas(vincent)
yes. %porque marsellus le pidió que cuide a mia, y porque tiene que ir a buscar a butch

La información de los encargos está codificada en la base de la siguiente forma: 
*/
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(Personaje):-
    personaje(Personaje,_),
    personaje(Boxeador,boxeador),
    encargo(_,Personaje,buscar(Boxeador,_)).

estaEnProblemas(Personaje):-
    personaje(Personaje,_),
    trabajaPara(Jefe,Personaje),
    debeCuidarALaPareja(Jefe,Personaje).

debeCuidarALaPareja(Jefe,Personaje):-
    pareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

/*4.  sanCayetano/1:  es quien a todos los que tiene cerca les da trabajo (algún encargo). 
Alguien tiene cerca a otro personaje si es su amigo o empleado. 
*/

sanCayetano(Personaje):-
    encargo(Personaje,_,_),
    forall(leDaTrabajo(Personaje,OtroPersonaje),loTieneCerca(Personaje,OtroPersonaje)).

loTieneCerca(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
loTieneCerca(Personaje,OtroPersonaje):-
    trabajaPara(Personaje,OtroPersonaje).

leDaTrabajo(Personaje,OtroPersonaje):-
    encargo(Personaje,OtroPersonaje,_).

/*5 masAtareado/1. Es el más atareado aquel que tenga más 
encargos que cualquier otro personaje.*/

/*6  personajesRespetables/1: genera la lista de todos los personajes respetables. 
Es respetable cuando su actividad tiene un nivel de respeto mayor a 9. Se sabe que:
-Las actrices tienen un nivel de respeto de la décima parte de su cantidad de peliculas.
-Los mafiosos que resuelven problemas tienen un nivel de 10 de respeto, los matones 1 y 
los capos 20.
-Al resto no se les debe ningún nivel de respeto. */

personajesRespetables(PersonajesRespetables):-
    findall(Personaje,esRespetable(Personaje), PersonajesRespetables).
    
esRespetable(Personaje):-
    personaje(Personaje,_),
    cantidadDeRespeto(Personaje,Cantidad),
    Cantidad > 9.

cantidadDeRespeto(Personaje,Cantidad):-
    personaje(Personaje,Actividad),
    actividadRespetada(Actividad,Cantidad).

actividadRespetada(actriz(Peliculas),Cantidad):-
    length(Peliculas,CantidadDePeliculas),
    Cantidad is CantidadDePeliculas/10.
actividadRespetada(mafioso(resuelveProblemas),10).
actividadRespetada(mafioso(maton),1).
actividadRespetada(mafioso(capo),20).
actividadRespetada(_,0). 

/*hartoDe/2: un personaje está harto de otro, 
cuando todas las tareas asignadas al primero requieren
 interactuar con el segundo (cuidar, buscar o ayudar) o un amigo del segundo. Ejemplo:

? hartoDe(winston, vincent).
true % winston tiene que ayudar a vincent, y a jules, que es amigo de vincent. 
*/
hartoDe(Personaje,OtroPersonaje):-
    encargo(_,Personaje,_),
    forall(tarasDePersonaje(Personaje,OtroPersonaje),interactuan(Personaje,OtroPersonaje)).

