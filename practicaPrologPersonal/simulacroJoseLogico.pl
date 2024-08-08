%Salir de la Terminal "halt."
%BASE DE CONOCIMIENTO:
% esPersonaje/1 nos permite saber qué personajes tendrá el juego

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
esPersonaje(bumi).
esPersonaje(suki).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi, tierra).
%suki NO CONTROLA ningun Elemento.

%visito(Personaje, LugarQueVisito).
% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(suki, nacionDelFuego(prisionDeMaximaSeguridad, 200)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

%PUNTO1:
esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento) ,controla(Personaje ,Elemento)).

%PUNTO2:
noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje, Elemento)).

esMaestroPrincipiante(Personaje):-
    controla(Personaje, Elemento),
    esElementoBasico(Elemento),
    ningunoElementoAvanzado(Elemento).

ningunoElementoAvanzado(Elemento):-
    not(elementoAvanzadoDe(_, Elemento)).

esMaestroAvanzado(Personaje):-
    controla(Personaje, Elemento),
    not(ningunoElementoAvanzado(Elemento)).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

%PUNTO3:
sigueA(aang, zuko).

sigueA(Perseguido, Perseguidor):-
    esPersonaje(Perseguido),
    esPersonaje(Perseguidor),
    forall(visito(Perseguido, Lugar), visito(Perseguidor, Lugar)).

%PUNTO4:
esDignoDeConocer(temploAire(PuntoCardinal)):-
    visito(_ , temploAire(PuntoCardinal)).
esDignoDeConocer(tribuAgua(norte)).
%ningún lugar de la nación del fuego es digno de ser conocido
esDignoDeConocer(reinoTierra(NombreDelLugar, Estructura)):-
    visito(_, reinoTierra(NombreDelLugar, Estructura)),
    not(member(muro, Estructura)).

%PUNTO5:
%definir si un lugar esPopular, lo cual sucede cuando fue visitado por más de 4 personajes. 
esPopular(Lugar):-
    visito(_, Lugar),
    findall(Personaje, visito(Personaje, Lugar), ListaLugaresDelPersonaje),
    length(ListaLugaresDelPersonaje, Cantidad),
    Cantidad >= 4.
