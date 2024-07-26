escribio(elsa,socorro).
escribio(nail,sandman).
escribio(nail,buenosPresagios).
escribio(nail,nasheJ).
escribio(terry,buenosPresagios).

esComic(sandman).
esComic(nasheJ).

esArtistaDelNovenoArte(Autor):-
    escribio(Autor,Obra),
    esComic(Obra).

