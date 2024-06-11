data Autor = UnAutor{nombre :: String,
                    obras :: [Obra]
                    } deriving Show

data Obra = UnaObra {titulo :: String,
                    anioPubliocacion :: Int} deriving (Show,Eq)

pato :: Obra
pato = UnaObra "Había una vez un pato...." 1997

versionCrudaDeUnTexto :: Obra -> Obra
versionCrudaDeUnTexto unaObra =  modificarTituloDeObra (filter (not.esLetraNoCruda)) unaObra

modificarTituloDeObra :: (String->String) -> Obra ->Obra
modificarTituloDeObra unaFuncion unaObra = unaObra {titulo = unaFuncion.titulo $ unaObra}

esLetraNoCruda :: Char -> Bool
esLetraNoCruda caracter = elem caracter letrasNoCrudas

letrasNoCrudas :: String
letrasNoCrudas = ".,*[]!?¡íóáéú"

--

copiaLiteral :: Obra -> Obra -> Bool
copiaLiteral unaObra posibleObraCopia = fuePublicadaDespues unaObra posibleObraCopia && tienenIgualVersionCruda unaObra posibleObraCopia

fuePublicadaDespues :: Obra -> Obra -> Bool
fuePublicadaDespues unaObra otraObra =  anioPubliocacion unaObra < anioPubliocacion otraObra

tienenIgualVersionCruda :: Obra -> Obra -> Bool
tienenIgualVersionCruda unaObra otraObra = versionCrudaDeUnTexto unaObra == versionCrudaDeUnTexto otraObra

--

empiezaIgual ::Int-> Obra -> Obra -> Bool
empiezaIgual unNumero (UnaObra titulo1 _) (UnaObra titulo2 _) = length titulo1 < length titulo2 && primeraLetrasIguales unNumero titulo1 titulo2

primeraLetrasIguales :: Int->String ->String ->Bool
primeraLetrasIguales unNumero unTitulo otroTitulo = take unNumero unTitulo == take unNumero otroTitulo

--

leAgregaronIntro :: Int-> Obra -> Obra -> Bool
leAgregaronIntro unNumero (UnaObra titulo1 _) (UnaObra titulo2 _) = primeraLetrasIguales unNumero (reverse titulo1) (reverse titulo2)
--

data Bot = UnBot {fabricante :: String,
                    formasDeDeteccion :: [FormaDeDeteccion]}

type FormaDeDeteccion = Obra ->Obra -> Bool

esPlagio :: Bot -> Obra -> Obra -> Bool
esPlagio unBot unaObra otraObra = any (detectaAlgunPlagio unaObra otraObra) (formasDeDeteccion unBot)

detectaAlgunPlagio :: Obra ->Obra -> FormaDeDeteccion->Bool
detectaAlgunPlagio unaObra otraObra formaDeDeteccion = formaDeDeteccion  unaObra otraObra

--

esCadenaDePlagiadores :: [Autor] ->Bot -> Bool
esCadenaDePlagiadores [] _ = False
esCadenaDePlagiadores [ _] _ = False
esCadenaDePlagiadores [primAutor , segunAutor] unBot = hayAlgunPlagio unBot (obras primAutor) (obras segunAutor)
esCadenaDePlagiadores (primerAutor : segundoAutor : demasAutores) unBot = 
          hayAlgunPlagio unBot (obras primerAutor) (obras segundoAutor) && esCadenaDePlagiadores (segundoAutor:demasAutores) unBot

hayAlgunPlagio :: Bot -> [Obra] ->[Obra] -> Bool
hayAlgunPlagio unBot unasObras otrasObras = any (esPlagio unBot (head unasObras)) otrasObras

--
obraInfinita ::Obra
obraInfinita = UnaObra tituloInfinito 2000

tituloInfinito :: String 
tituloInfinito =concatMap (generatitulo "aaa ") [1..20] 

generatitulo :: String -> Int ->String
generatitulo u num = u ++ show num

