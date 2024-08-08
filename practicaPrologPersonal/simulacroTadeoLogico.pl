esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

controla(momo,tierra).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

visito(momo, reinoTierra(mardelplata, [zonaAgraria, sectorBajo, sectorMedio])).
visito(aang,chascomus).
visito(iroh,chascomus).
visito(katara,chascomus).
visito(momo,chascomus).
visito(azula,chascomus).

% PUNTO 1

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

% PUNTO 2

noEsMaestro(Personaje):-
distinct(Personaje,esPersonaje(Personaje)).
    not(controlaAlgunElementoBasico(Personaje,_)),
    not(controlaAlgunElementoAvanzado(Personaje,_)).

/*
noEsMaestro(Personaje):-
    not(esMaestroPrincipiante(Personaje)),
    not(esMaestroAvanzado(Personaje)).
*/

esMaestroPrincipiante(Personaje):-
   distinct(Personaje,controlaAlgunElementoBasico(Personaje,_)),
    not(controlaAlgunElementoAvanzado(Personaje,_)).

esMaestroAvanzado(Personaje):-
    distinct(Personaje,controlaAlgunElementoAvanzado(Personaje,_)).

controlaAlgunElementoBasico(Personaje,Elemento):-
    controla(Personaje,Elemento),
    esElementoBasico(Elemento).

controlaAlgunElementoAvanzado(Personaje,Elemento):-
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).

% PUNTO 3

sigueA(zuko,aang).
sigueA(Seguidor,Seguido):-
    esPersonaje(Seguido),
    esPersonaje(Seguidor),
    Seguido \= Seguidor,
    forall(visito(Seguido,Lugar),visito(Seguidor,Lugar)).

% PUNTO 4

esDignoDeConocer(temploAire(PuntoCardinal)):-
    visito(_,temploAire(PuntoCardinal)).
esDignoDeConocer(tribuAgua(norte)).
esDignoDeConocer(reinoTierra(Zona,Lugares)):-
    visito(_,reinoTierra(Zona,Lugares)),
    not(member(muro, Lugares)).
    
% PUNTO 5

esPopular(Lugar):-
    distinct(Lugar,visito(_,Lugar)),
    findall(Personaje,visito(Personaje,Lugar),TodosLosQueVisitaron),
    list_to_set(TodosLosQueVisitaron,PersonajesQueLoVisitaron),
    length(PersonajesQueLoVisitaron, CantidadQueLoVisitaron),
    CantidadQueLoVisitaron > 4.
    
% PUNTO 6

esPersonaje(bumi).
controla(bumi,tierra).
visito(bumi,reinoTierra(baSingSe,[muro, zonaAgraria, sectorBajo, sectorMedio])).

esPersonaje(suki).
visito(suki,prisionDeMaximaSeguridad).