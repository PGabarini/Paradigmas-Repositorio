%mago(Nombre,Sangre,Caracteristicas,CasaQueOdia).
mago(harry,mestiza,[coraje, amistoso, orgulloso , inteligente],casaSlyterin).
mago(draco,pura,[orgulloso,inteligente],casaHufflepuf).
mago(hermaioni,impura,[orgulloso,inteligente,responsable],sinOdio).

mago(harry).

%mago(harry).
sangre(harry,mestiza).
caracteristica(harry,coraje).
caracteristica(harry,amistoso).
caracteristica(harry,orgulloso).
caracteristica(harry,inteligente).
odiariaIrACasa(harry,casaSlyterin).

sangre(draco,pura).
caracteristica(draco,orgulloso).
caracteristica(draco,inteligente).
odiariaIrACasa(casaHufflepuf).

sangre(hermaioni,impura).
caracteristica(hermaioni,orgulloso).
caracteristica(hermaioni,responsable).
caracteristica(hermaioni,inteligente).
odiariaIrACasa(sinOdio).


%1
puedeEntrarACasa(Mago,casaSlyterin):-
    mago(Mago,Sangre,_,_),
    Sangre \= impura.
puedeEntrarACasa(Mago,Casa):-
    mago(Mago,_,_,_).

%2
esApropiadoDeCaracterParaEntrar(Mago,Casa):-
    mago(Mago,_,Caracteristicas,_),
    cumpleConLaCasa(Caracteristicas,Casa).

cumpleConLaCasa(Caracteristicas,casaGrifyndor):-
    member(coraje,Caracteristicas).

cumpleConLaCasa(Caracteristicas,casaSlyterin):-
    member(orgulloso,Caracteristicas),
    member(inteligente,Caracteristicas).

cumpleConLaCasa(Caracteristicas,casaRevenclaw):-
    member(responsable,Caracteristicas),
    member(inteligente,Caracteristicas).

cumpleConLaCasa(Caracteristicas,casaHufflepuf):-
    member(amistoso,Caracteristicas).

%3
puedeQuedarseEn(Mago,Casa):-
    esApropiadoDeCaracterParaEntrar(Mago,Casa),
    puedeEntrarACasa(Mago,Casa),
    noOdiariaEstarEnLaCasa(Mago,Casa).

noOdiariaEstarEnLaCasa(Mago,Casa):-
    mago(Mago,_,_,LugarQueOdiaria),
    LugarQueOdiaria \=Casa.

puedeQuedarseEn(hermaioni,casaGrifyndor).

/* 4 Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si
 todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. 
No hace falta que sea inversible, se consultará de forma individual.*/
%