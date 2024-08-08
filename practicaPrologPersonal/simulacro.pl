
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

%1saber qué personaje esElAvatar. El avatar es aquel personaje que controla todos los elementos básicos.

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(ElementoBasico),controla(Personaje,ElementoBasico)).

/*2clasificar a los personajes en 3 grupos:
un personaje noEsMaestro si no controla ningún elemento, ni básico ni avanzado;
un personaje esMaestroPrincipiante si controla algún elemento básico pero ninguno avanzado;
un personaje esMaestroAvanzado si controla algún elemento avanzado. Es */

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje,_)).

esMaestroPrincipiante(Personaje):-
    controla(Personaje,Elemento),
    esElementoBasico(Elemento),
    not(esMaestroAvanzado(Personaje)).

esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).
    

/*3saber si un personaje sigueA otro. Diremos que esto sucede si el segundo
 visitó todos los lugares que visitó el primero. También sabemos que zuko sigue a aang.*/

sigueA(zuko,aang).

sigueA(Seguidor,Seguido):-
    esPersonaje(Seguido),
    esPersonaje(Seguidor),
    Seguidor \= Seguido,
    forall(visito(Seguido,Lugar),visito(Seguidor,Lugar)).

/*4 conocer si un lugar esDignoDeConocer, para lo que sabemos que:
    todos los templos aire son dignos de conocer;
    la tribu agua del norte es digna de conocer;
    ningún lugar de la nación del fuego es digno de ser conocido;
    un lugar del reino tierra es digno de conocer si no tiene muros en su estructura.*/

esDignoDeConocer(temploAire(Nombre)):-  
    visito(_,temploAire(Nombre)).

esDignoDeConocer(tribuAgua(norte)).

esDignoDeConocer(reinoTierra(Nombre,Estructura)):-
    visito(_,reinoTierra(Nombre,Estructura)),
    not(member(muro,Estructura)).

/*definir si un lugar esPopular, lo cual sucede cuando fue visitado por más de 4 personajes. */

esPopular(Lugar):-
    cantidadDeVisitasDiferentes(Lugar,Cantidad),
    Cantidad > 4.

cantidadDeVisitasDiferentes(Lugar,Cantidad):-
    visito(_,Lugar),
    findall(Personaje,(visito(Personaje,Lugar),esPersonaje(Personaje)),ListaDePersonajes),
    list_to_set(ListaDePersonajes,ListaDePersonajesUnicos),
    length(ListaDePersonajesUnicos,Cantidad).

/* Por último nos pidieron modelar la siguiente información en nuestra base de conocimientos 
sobre algunos personajes desbloqueables en el juego:
    bumi es un personaje que controla el elemento tierra y visitó Ba Sing Se en el reino Tierra;
    suki es un personaje que no controla ningún elemento y que visitó una prisión de máxima 
    seguridad en la nación del fuego protegida por 200 soldados. 
*/
/*
esPersonaje(bumi).
controla(tierra).
visito(bumi,reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).

esPersonaje(suki).
visito(suki,nacionDelFuego(prisionDeMaximaSeguridad, 200)).*/