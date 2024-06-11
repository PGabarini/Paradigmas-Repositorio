import Data.Char (isUpper, toUpper)
import Data.Char()

import Text.Show.Functions()

data Barbaro = UnBarbaro 
    { nombre::String , 
     fuerza::Int,
     habilidades :: [Habilidad],
     objetos::[Objeto] }

type Habilidad = String
type Objeto = Barbaro -> Barbaro

--Barbaros
dave :: Barbaro
dave = UnBarbaro "Dave" 100 ["tejer","escribirPoesia"] []

--Objetos
--
espada :: Int -> Objeto
espada pesoEspada unBarbaro = modificarFuerza (+ 2*pesoEspada) unBarbaro

modificarFuerza :: (Int->Int) -> Barbaro -> Barbaro
modificarFuerza unaFuncion unBarbaro = unBarbaro {fuerza= unaFuncion $ fuerza unBarbaro}

--
amuletosMisticos ::  Habilidad -> Barbaro -> Barbaro
amuletosMisticos unaHabilidad unBarbaro = modificarHabilidades (unaHabilidad :) unBarbaro

modificarHabilidades :: ([String]->[String]) -> Barbaro -> Barbaro
modificarHabilidades unaFuncion unBarbaro = unBarbaro {habilidades= unaFuncion.habilidades $ unBarbaro}

--
varitasDefectuosas :: Objeto
{--varitasDefectuosas (UnBarbaro _ _ _ []) = modificarHabilidades ( "hacerMagia":) --}
varitasDefectuosas unBarbaro = modificarHabilidades ( "hacerMagia":)  $ unBarbaro {objetos= []}
--

--
ardilla :: Objeto 
ardilla unBarbaro = unBarbaro
--

--
cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto = unObjeto.otroObjeto 
--

--
megafono :: Objeto
megafono unBarbaro = modificarHabilidades ((map aMayusculas).meterEnLsita.concat) unBarbaro


meterEnLsita :: String -> [String]
meterEnLsita str = [str]

aMayusculas :: String -> String
aMayusculas = map toUpper

--
megafonoBarbico :: Objeto
megafonoBarbico = cuerda ardilla megafono
--

--AVENTURAS

type Evento = Barbaro -> Bool
type Aventura = [Evento]
type Prueba = Barbaro -> Bool

sobreviveAunEvento :: Barbaro ->Evento-> Bool
sobreviveAunEvento  unBarbaro unEvento = unEvento unBarbaro 

sobreviveAlaAventura :: Aventura -> Barbaro -> Bool
sobreviveAlaAventura unaAventura unBarbaro = all (sobreviveAunEvento unBarbaro ) unaAventura

sobrevivientes ::  [Barbaro] -> Aventura ->[Barbaro]
sobrevivientes unosBarbaros unaAventura = filter (sobreviveAlaAventura  unaAventura) unosBarbaros

pasaLaPrueba :: Barbaro->Prueba -> Bool
pasaLaPrueba unBarbaro unaPrueba = unaPrueba unBarbaro
--
invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes (UnBarbaro _ _ ["Escribir Poesía Atroz"] _) = True
invasionDeSuciosDuendes _ = False
--

--
cremalleraDelTiempo :: Evento
cremalleraDelTiempo (UnBarbaro "Faffy" _ _ _) = True
cremalleraDelTiempo (UnBarbaro "Astro" _ _ _) = True
cremalleraDelTiempo _ = False
--

--
ritualDeFechorias :: [Prueba]->Evento
ritualDeFechorias unasPruebas unBarbaro =  any (pasaLaPrueba unBarbaro) unasPruebas

saqueo :: Prueba
saqueo unBarbaro = (elem "robar" $ habilidades unBarbaro) && ((>80) $ fuerza unBarbaro)

caligrafia :: Prueba
caligrafia unBarbaro = (all (esMayuscula.head) $ habilidades unBarbaro)  &&  (all ((<3).length) $ habilidades unBarbaro)

esMayuscula :: Char -> Bool
esMayuscula = isUpper
--

dobles :: Num a => [a] -> [a]
dobles numeros = map (\numero -> numero * 2) numeros