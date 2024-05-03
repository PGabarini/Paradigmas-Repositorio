{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Use notElem" #-}
{-
type Autor = String
type Titulo = String
type CantidadDePaginas  = Int-}

data Libro = UnLibro { titulo :: String, autor :: String, paginas ::Int } deriving (Show,Eq)

type Biblioteca = [Libro]

elVisitante :: Libro
elVisitante = UnLibro "elVisitante" "Stephen King" 592

shingekiCap1 :: Libro
shingekiCap1 = UnLibro "ShingekiCap1" "Hajime Isayama" 40

shingekiCap3 :: Libro
shingekiCap3 = UnLibro "ShingekiCap3" "Hajime Isayama" 40

shingekiCap127 :: Libro
shingekiCap127 = UnLibro "ShingekiCap12" "Hajime Isayama" 40

fundacion :: Libro
fundacion = UnLibro "Fundacion" "Isaac Asimov" 230

sandManCap5 :: Libro
sandManCap5 = UnLibro "SandManCap5" "Neil Gaiman" 35

sandManCap10 :: Libro
sandManCap10 = UnLibro "SandManCap10" "Neil Gaiman" 35

sandManCap12 :: Libro
sandManCap12 = UnLibro "SandmanCap12" "Neil Gaiman" 35

eragon :: Libro
eragon = UnLibro "Eragon" "Christopher Paolini" 544

eldest :: Libro
eldest = UnLibro "Eldest" "Christopher Paolini" 704

brisingnr :: Libro
brisingnr = UnLibro "Brisignr" "Christopher Paolini" 700

legado :: Libro
legado = UnLibro "Legado" "Christopher Paolini" 811

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
cantidadDePaginasEnUnLibro = paginas

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

esLibroDe :: String ->Libro -> Bool
esLibroDe unAutor unLibro = unAutor == autor unLibro

--PUNTO 4
nombreDeBiblioteca :: Biblioteca -> String
nombreDeBiblioteca unaBiblioteca = concat (nombresDeUnaBibliotecaSinVocales unaBiblioteca)

nombresDeUnaBibliotecaSinVocales :: Biblioteca -> [String]
nombresDeUnaBibliotecaSinVocales unaBiblioteca = map sacarVocales (titulosDeUnaBilioteca unaBiblioteca)

titulosDeUnaBilioteca :: Biblioteca -> [String]
titulosDeUnaBilioteca unaBilioteca = map tituloDelLibro unaBilioteca

tituloDelLibro :: Libro -> String
tituloDelLibro = titulo

sacarVocales :: String -> String
sacarVocales unosTitulos = filter esVocal unosTitulos

esVocal :: Char -> Bool
esVocal unTitulo = not (elem unTitulo ['a','e','i','o','u','A','E','I','O','U'])

--PUNTO 5
esBibliotecaLigera :: Biblioteca -> Bool
esBibliotecaLigera unaBiblioteca = not (any tieneEllibroMenosDe40Paginas unaBiblioteca)

tieneEllibroMenosDe40Paginas :: Libro -> Bool
tieneEllibroMenosDe40Paginas unLibro = paginas unLibro > 41

--PUNTO 6
genero :: Libro -> String
genero unLibro | esComic unLibro = "Comic"
                |esDeTerror unLibro = "Es de Terror"
                |esManga unLibro = "Es un Manga"
                | otherwise = "Sin genero"

esComic :: Libro -> Bool
esComic unLibro = paginas unLibro <40

esDeTerror :: Libro -> Bool
esDeTerror unLibro = autor unLibro == "Stephen King"

esManga :: Libro -> Bool
esManga unLibro = elem (autor unLibro) autoresJaponeses

autoresJaponeses :: [String]
autoresJaponeses = ["Hajime Isayama"]