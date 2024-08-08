% BASE DE CONOCIMIENTOS: PERSONAS

% Usamos la propiedad "persona" para representar la existencia de una persona independientemente
% de su profesion, gustos o habilidades (nos permite modelar a sebastien)
persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastienFaure).

trabajo(bakunin, aviacionMilitar).
trabajo(ravachol, inteligenciaMilitar).
trabajo(emmaGoldman, profesoraDeJudo).
trabajo(emmaGoldman, cineasta).
trabajo(judithButler, profesoraDeJudo).
trabajo(judithButler, inteligenciaMilitar).
trabajo(elisaBachofen, ingenieraMecanica).

habilidad(bakunin, conducirAutos).
habilidad(ravachol, tiroAlBlanco).
habilidad(rosaDubovsky, construirPuentes).
habilidad(rosaDubovsky, mirarPeppaPig).
habilidad(emmaGoldman, Habilidad):-
    habilidad(judithButler, Habilidad).
habilidad(emmaGoldman, Habilidad):-
    habilidad(elisaBachofen, Habilidad).
habilidad(judithButler, judo).
habilidad(elisaBachofen, armarBombas).
habilidad(juanSuriano, judo).
habilidad(juanSuriano, armarBombas).
habilidad(juanSuriano, ringRaje).

gusto(ravachol, juegosDeAzar).
gusto(ravachol, ajedrez).
gusto(ravachol, tiroAlBlanco).
gusto(rosaDubovsky, construirPuentes).
gusto(rosaDubovsky, mirarPeppaPig).
gusto(rosaDubovsky, fisicaCuantica).
gusto(emmaGoldman, Gusto):-
    gusto(judithButler, Gusto).
gusto(judithButler, judo).
gusto(judithButler, carrerasDeAutomovilismo).
gusto(elisaBachofen, fuego).
gusto(elisaBachofen, destruccion).
gusto(juanSuriano, judo).
gusto(juanSuriano, armarBombas).
gusto(juanSuriano, ringRaje).

antecedente(bakunin, roboDeAeronaves).
antecedente(bakunin, fraude).
antecedente(bakunin, tenenciaDeCafenia).
antecedente(ravachol, falsificacionDeVacunas).
antecedente(ravachol, fraude).
antecedente(judithButler, falsificacionDeCheques).
antecedente(judithButler, fraude).
antecedente(juanSuriano, falsicacionDeDinero).
antecedente(juanSuriano, fraude).

% BASE DE CONOCIMIENTOS: VIVIENDAS

vivienda(laSeverino).
vivienda(comisaria48).
vivienda(casaDePapel).
vivienda(casaDelSolNaciente).

viveEn(bakunin, laSeverino).
viveEn(elisaBachofen, laSeverino).
viveEn(rosaDubovsky, laSeverino).
viveEn(ravachol, comisaria48).
viveEn(emmaGoldman, casaDePapel).
viveEn(juanSuriano, casaDePapel).
viveEn(judithButler, casaDePapel).

% cuartoSecreto(mts de largo, mts de ancho, vivienda)
cuartoSecreto(4, 8, laSeverino).
cuartoSecreto(5, 3, casaDePapel).
cuartoSecreto(4, 7 ,casaDePapel).
% tunelSecreto(mts de largo, estado, vivienda)
tunelSecreto(8, construido, laSeverino).
tunelSecreto(5, construido, laSeverino).
tunelSecreto(1, enConstruccion, laSeverino).
tunelSecreto(9, construido, casaDePapel).
tunelSecreto(2, construido, casaDePapel).
tunelSecreto(3, enConstruccion, casaDelSolNaciente).

cantidadDePasadizos(1, laSeverino).
cantidadDePasadizos(2, casaDePapel).
cantidadDePasadizos(1, casaDelSolNaciente).

%PUNTO 3

vivendaConPotencialRebelde(Vivienda):-
    viveAlgunDesidente(Vivienda),
    superficieDeActividadClandestina(SuperficieTotal,Vivienda),
    SuperficieTotal > 50.

superficieDeActividadClandestina(SuperficieTotal,Vivienda):-
    superficieDeCuartos(SuperficieDeCuartos,Vivienda),
    superficieDeTuneles(SuperficieDeTuneles,Vivienda),
    superficieDePasadizos(SuperficieDePasadizos,Vivienda),
    SuperficieTotal is SuperficieDeCuartos+SuperficieDeTuneles+SuperficieDePasadizos.

viveAlgunDesidente(Vivienda):-
    vivienda(Vivienda),
    viveEn(Persona,Vivienda),
    esPosibleDisidente(Persona).

superficieDeCuartos(SuperficieDeCuartos,Vivienda):-
    listaDeSuperficiesDeCuartos(Lista,Vivienda),
    sum_list(Lista,SuperficieDeCuartos).
listaDeSuperficiesDeCuartos(Lista,Vivienda):-
    cuartoSecreto(_,_,Vivienda),
    findall(SuperficieDeCuarto,superficieDelCuarto(SuperficieDeCuarto,Vivienda),Lista).
superficieDelCuarto(SuperficieDeCuarto,Vivienda):-
    cuartoSecreto(MetrosDeLargo,MetrosDeAncho,Vivienda),
    SuperficieDeCuarto is MetrosDeLargo*MetrosDeAncho.
superficieDeCuartos(0,Vivienda).


superficieDeTuneles(SuperficieDeTuneles,Vivienda):-
    largoDeTuneles(LargoTotalDeTuneles,Vivienda),
    SuperficieDeTuneles is 2*LargoTotalDeTuneles.
largoDeTuneles(LargoTotalDeTuneles,Vivienda):-
    tunelSecreto(_,construido,Vivienda),
    findall(LongitudDeTunel,tunelSecreto(LongitudDeTunel,construido,Vivienda),ListaDeTuneles),
    sum_list(ListaDeTuneles,LargoTotalDeTuneles).
superficieDeTuneles(0,Vivienda).

superficieDePasadizos(SuperficieDePasadizos,Vivienda):-
    cantidadDePasadizos(SuperficieDePasadizos,Vivienda).
superficieDePasadizos(0,Vivienda).
%PUNTO 4
aquiNoHayQuienViva(Vivienda):-
  not(viveEn(_,Vivienda)).

aquiNoHayQuienViva(Vivienda):-
    vivienda(Vivienda),
    viveEn(Persona,Vivienda),
    forall(viveEn(OtraPersona,Vivienda),hayGustosEnComun(Persona,OtraPersona)).

hayGustosEnComun(Persona,OtraPersona):-
    gusto(Persona,Gusto),
    gusto(OtraPersona,OtroGusto),
    Gusto = OtroGusto.

/*
viveEn(emmaGoldman, casaDePapel).
viveEn(juanSuriano, casaDePapel).
viveEn(judithButler, casaDePapel).

gusto(juanSuriano, judo).
gusto(juanSuriano, armarBombas).
gusto(juanSuriano, ringRaje).

gusto(emmaGoldman, Gusto):-
    gusto(judithButler, Gusto).

gusto(judithButler, judo).
gusto(judithButler, carrerasDeAutomovilismo).
*/
%PUNTO 5

esPosibleDisidente(Persona):-
    tieneHabilidadTerrorista(Persona),
    tieneGustoRaro(Persona),
    esCriminal(Persona).

tieneHabilidadTerrorista(Persona):-
    habilidad(Persona,Habilidad),
    habilidadTerrorista(Habilidad).

tieneGustoRaro(Persona):-
    not(gusto(Persona,_)).
tieneGustoRaro(Persona):-
    forall( habilidad(Persona,Habilidad),gusto(Persona,Habilidad)).
  
esCriminal(Persona):-
    antecedente(Persona,_).
esCriminal(Persona):-
    viveEn(Persona,Vivienda),
    viveEn(OtraPersona,Vivienda),
    antecedente(OtraPersona,_).


habilidadTerrorista(armarBombas).
habilidadTerrorista(tiroAlBlanco).
habilidadTerrorista(mirarPeppaPig).

%PUNTO 6

%PUNTO 7
