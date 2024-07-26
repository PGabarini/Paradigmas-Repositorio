% BASE DE CONOCIMIENTOS

escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

% Queremos saber si alguien es artista del noveno arte: 
% lo es cuando escribió algún cómic.

/* esArtistaDelNovenoArte(neilGaiman).
esArtistaDelNovenoArte(alanMoore). */

esArtistaDelNovenoArte(Autor):-
    escribio(Autor,Obra),
    esComic(Obra).

/*
1. Queremos saber si determinada obra es un best-seller, es decir, si tiene más de 50.000 copias vendidas.
*/
esBestSeller(Obra):-
    escribio(_,Obra),
    copiasVendidas(Obra,Cantidad),
    Cantidad > 50000.

/*
2. Queremos saber si es reincidente un/a autor/a, que es cuando escribió más de una obra.*/

esReincidente(Autor):-
    escribio(Autor,UnLibro),
    escribio(Autor,OtroLibro),
    UnLibro \= OtroLibro.

/*3.  Queremos saber si conviene contratar a un/a artista, que es cuando es reincidente o 
escribió un bestseller.*/

convieneContratar(Artista):-
    esReincidente(Artista).

convieneContratar(Artista):-
    escribio(Artista,Obra),
    esBestSeller(Obra).

/*4. Queremos saber si a gus le gusta una obra. A Gus le gusta todo lo que escribió Asimov y sandman.*/
leGustaAGus(Obra):-
    escribio(isaacAsimov,Obra).

leGustaAGus(sandman).


/*6. Ver si es un libro: cuando fue escrito pero no es cómic
*/
esLibro(Obra):-
    escribio(_,Obra),
    not(esComic(Obra)).

% copiasVendidas(Obra,Cantidad)
copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios2, 10000).
copiasVendidas(fundacion, 20000).
copiasVendidas(yoRobot, 30000).
copiasVendidas(elFinDeLaEternidad, 30000).
copiasVendidas(laBusquedaDeLosElementos, 40000).
copiasVendidas(martinFierro, 50000).
copiasVendidas(it, 60000).
copiasVendidas(it2, 70000).
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

/* 5. Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su autor/a es Uruguay o Argentina */
nacioEn(horacioQuiroga, uruguay).
nacioEn(jorgeLuisBorges, argentina).
nacioEn(neilGaiman, inglaterra).

esAutorRioplatense(Autor):-
    nacioEn(Autor, uruguay).

esAutorRioplatense(Autor):-
    nacioEn(Autor, argentina).

esObraRioPlatense(Obra):-
    escribio(Autor,Obra),
    esAutorRioplatense(Autor).

% soloEscribioComics/1 nos responde si todas las obras que alguien escribió son cómics.

soloEscribioComics(Autor):-
    forall(escribio(Autor,Obra),esComic(Obra)).

/* tenemos diferentes tipos de obras. 
Novelas de las cuales sabemos si es de terror, drama, suspenso, etc y su cantidad de capitulos
libro de cuentos de los cuales sabemos la cantidad de cuentos que tiene
cientificos de los cuales sabemos la materia de la que es
best sellers de los cuales sabemos el precio total de la obra y la cantidad de paginas
 */

%functores de tipo de libro
%novela(Genero, CantidadDeCapitulos)
%libroDeCuentos(CantidadDeCuentos)
%cientifico(Disciplina)
%bestSeller(PrecioTotal, CantidadDePaginas)
%fantastica(ElementosMágicos)
%libroDeCuentos(CantidadDeCuentos)
%cientifico(Disciplina)
%bestSeller(PrecioTotal, CantidadDePaginas)
%fantastica(ElementosMágicos)

%esDeTipo(obra,tipo)
esDeTipo(it, novela(terror, 11)).
esDeTipo(cuentosDeLaSelva, libroDeCuentos(10)).
esDeTipo(elUniversoEnUnaTabla, cientifico(quimica)).
esDeTipo(elUltimoTeoremaDeFermat, cientifico(matematica)).
esDeTipo(yoRobot, bestSeller(700,253)).

esDeTipo(mistborn,fantastica([metales,dagas,capa])).
    
/*estaBuena/1 nos dice cuando una obra está buena. Esto sucede cuando:
- Es una novela policial y tiene menos de 12 capítulos.
- Es una novela de terror.
- Los libros con más de 10 cuentos siempre son buenos.
- Es una obra científica de fisicaCuantica.
- Es un best seller y el precio por página es menor a $50.
 */
estaBuena(Obra):-
    esDeTipo(Obra,TipoDeObra),
    esDeTipoDeObraBuena(TipoDeObra).

esDeTipoDeObraBuena(novela(policial,CantidadDeCapitulos)):-
    CantidadDeCapitulos<12.

esDeTipoDeObraBuena(novela(terror,_)).

esDeTipoDeObraBuena(libroDeCuentos(Cuentos)):-
    Cuentos>10.

esDeTipoDeObraBuena(cientifico(fisicaCuantica)).

esDeTipoDeObraBuena(bestSeller(PrecioTotal,CantidadDePaginas)):-
    (PrecioTotal/CantidadDePaginas)<50.

/* cantidadDePaginas/2 relaciona a una obra con su cantidad de páginas:
- las novelas tienen 20 páginas por capítulo;
- los libros de cuentos 5 páginas por cuento;
- las obras científicas tienen siempre 1000 páginas;
- de los best sellers ya sabemos su cantidad de páginas.
*/


cantidadDePaginas(Obra,CantidadDePaginas):-
    esDeTipo(Obra,TipoDeObra),
    paginasSegunTipo(TipoDeObra,CantidadDePaginas).

paginasSegunTipo(novela(_,CantidadDeCapitulos),CantidadDePaginas):-
    CantidadDePaginas is CantidadDeCapitulos*20.

paginasSegunTipo(libroDeCuentos(CantidadDeCuentos),CantidadDePaginas):-
    CantidadDePaginas is CantidadDeCuentos *5.

paginasSegunTipo(cientifico(_),1000).

paginasSegunTipo(bestSeller(_,CantidadDePaginas),CantidadDePaginas).