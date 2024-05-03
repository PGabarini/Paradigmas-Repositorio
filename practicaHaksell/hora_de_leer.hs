{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use infix" #-}

type Autor = String
type Titulo = String
type CantidadDePaginas  = Int
type Libro = (Titulo,Autor, CantidadDePaginas )

type Biblioteca = [Libro]

elVisitante :: Libro
elVisitante = ("elVisitante","Stephen King",592)

shingekiCap1 :: Libro
shingekiCap1 = ("ShingekiCap1","Hajime Isayama",40)

shingekiCap3 :: Libro
shingekiCap3 = ("ShingekiCap3","Hajime Isayama",40)

shingekiCap127 :: Libro
shingekiCap127 = ("ShingekiCap127","Hajime Isayama",40)

fundacion :: Libro
fundacion = ("Fundacion","Isaac Asimov",230)

sandManCap5 :: Libro
sandManCap5 = ("SandManCap5","Neil Gaiman",35)

sandManCap10 :: Libro
sandManCap10 = ("SandManCap10","Neil Gaiman",35)

sandManCap12 :: Libro
sandManCap12 = ("SandManCap12","Neil Gaiman",35)

eragon :: Libro
eragon = ("Eragon","Christopher Paolini",544)

eldest :: Libro
eldest = ("Eldest","Christopher Paolini",704)

brisingnr :: Libro
brisingnr = ("Brisignr","Christopher Paolini",700)

legado :: Libro
legado = ("Legado","Christopher Paolini",811)

--BIBLIOTECAS

miBiblioteca :: Biblioteca
miBiblioteca = [elVisitante,shingekiCap1,shingekiCap3,shingekiCap127,fundacion,sandManCap5,sandManCap10,
                 sandManCap12,eragon,eldest,brisingnr,legado]

sagaEragon :: Biblioteca
sagaEragon = [eragon,eldest,brisingnr,legado]

miBibliotecaLigera :: Biblioteca
miBibliotecaLigera = [shingekiCap1,shingekiCap3,shingekiCap127,sandManCap5,sandManCap10,sandManCap12]

--PUNTO 1
promedioDePaginas :: Biblioteca -> Int
promedioDePaginas unaBiblioteca = div (cantPaginasDeLaBiblioteca unaBiblioteca) (cantidadDeLibrosDeUnaBiblioteca unaBiblioteca)

cantPaginasDeLaBiblioteca :: Biblioteca -> Int 
cantPaginasDeLaBiblioteca unaBiblioteca = (sumatoriaDePaginas.map cantidadDePaginasEnUnLibro)  unaBiblioteca

cantidadDePaginasEnUnLibro :: Libro -> Int
cantidadDePaginasEnUnLibro (_,_,cantidadDePaginasDelLibro) = cantidadDePaginasDelLibro

cantidadDeLibrosDeUnaBiblioteca :: [Libro] -> Int
cantidadDeLibrosDeUnaBiblioteca unaBiblioteca = length unaBiblioteca

sumatoriaDePaginas :: [Int] -> Int
sumatoriaDePaginas unasPaginas = sum unasPaginas

--PUNTO 2
esLecturaObligatoria :: Libro -> Bool
esLecturaObligatoria unLibro = esLibroDe "Stephen King" unLibro || unLibro == fundacion || esSagaEragon unLibro

esSagaEragon :: Libro -> Bool
esSagaEragon unLibro = elem unLibro sagaEragon

--PUNTO 3
esBibliotecaFantasiosa :: Biblioteca -> Bool
esBibliotecaFantasiosa unaBiblioteca = tieneLibroDeCristopher unaBiblioteca || tieneLibroDeNeil unaBiblioteca

tieneLibroDeCristopher :: Biblioteca -> Bool
tieneLibroDeCristopher unaBiblioteca = any (esLibroDe "Christopher Paolini") unaBiblioteca

tieneLibroDeNeil :: Biblioteca -> Bool
tieneLibroDeNeil unaBiblioteca = any (esLibroDe "Neil Gaiman") unaBiblioteca

esLibroDe :: Autor ->Libro -> Bool
esLibroDe unAutor (_,autor,_) = autor == unAutor 

--PUNTO 4
nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca unaBiblioteca = concat (sacarVocales (titulosDeLaBiblioteca unaBiblioteca))

titulosDeLaBiblioteca :: [Libro] -> [String]
titulosDeLaBiblioteca unaBiblioteca = map tituloDelLibro unaBiblioteca

tituloDelLibro :: Libro -> String
tituloDelLibro (titulo,_,_) = titulo 

sacarVocales :: [String] -> [String]
sacarVocales unosTitulos = filter esVocal unosTitulos

esVocal :: String -> Bool
esVocal unTitulo = not (elem 'a' unTitulo || elem 'e' unTitulo || elem 'i' unTitulo || elem 'o' unTitulo || elem 'u' unTitulo )

--PUNTO 5
esBibliotecaLigera :: Biblioteca -> Bool
esBibliotecaLigera unaBiblioteca = not (any tieneEllibroMenosDe40Paginas unaBiblioteca)

tieneEllibroMenosDe40Paginas :: Libro -> Bool
tieneEllibroMenosDe40Paginas (_,_,paginasDelLibro) = paginasDelLibro > 41

--PUNTO 6
{-
genero :: Libro -> String
genero unLibro | esComic unLibro = "Comic"
                |esDeTerror unLibro = "Es de Terror"
                |esManga unLibro = "Es un Manga"
                | otherwise = "Sin genero"
-}
