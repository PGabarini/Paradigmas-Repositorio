import Text.Show.Functions()

type Atraccion = String

data Ciudad = UnaCiudad {
    nombre :: String,
    añoDeFundacion :: Int,
    atracciones :: [Atraccion],
    costoDeVida :: Float
} deriving Show

--Ciudades
vedia :: Ciudad
vedia = UnaCiudad "Vedia" 1900 [] 90 

baradero :: Ciudad
baradero = UnaCiudad "Baradero" 1615 ["Parque del Este", "Museo Alejandro Barbich"] 150

nullish :: Ciudad
nullish = UnaCiudad "Nullish" 1800 [] 140

caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito", "Faro Costanera"] 120

maipu :: Ciudad
maipu = UnaCiudad "Maipú" 1878 ["Fortín Kakel"] 115

azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190

--Funciones

valorDeUnaCiudad :: Ciudad -> Float
valorDeUnaCiudad unaCiudad
    | añoDeFundacion unaCiudad < 1800    = fromIntegral.(*5).abs.subtract 1800 $ añoDeFundacion unaCiudad
    | esCiudadSinAtracciones unaCiudad   = 2 * costoDeVida unaCiudad
    | otherwise                          = 3 * costoDeVida unaCiudad

esCiudadSinAtracciones:: Ciudad -> Bool
esCiudadSinAtracciones(UnaCiudad _ _ [] _) = True
esCiudadSinAtracciones _ = False  

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada unaCiudad = any (isVowel.head) $ atracciones unaCiudad

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

esSobria :: Ciudad -> Int -> Bool
esSobria unaCiudad cantidadLetras = all ((>cantidadLetras).length) $ atracciones unaCiudad

tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro = (<5).length.nombre

sumarAtraccion :: Atraccion -> Ciudad -> Ciudad
sumarAtraccion unaAtracción unaCiudad = modificarCostoDeVidaPorcentual (20) (modificarAtraccion (unaAtracción :) unaCiudad)

modificarCostoDeVida :: (Float -> Float) -> Ciudad -> Ciudad
modificarCostoDeVida unaFuncion unaCiudad = unaCiudad {costoDeVida = unaFuncion.costoDeVida $ unaCiudad}

modificarCostoDeVidaPorcentual :: Float -> Ciudad -> Ciudad
modificarCostoDeVidaPorcentual porcentaje unaCiudad = modificarCostoDeVida (+ costoDeVida unaCiudad * porcentaje/100) unaCiudad

atravesarCrisis :: Ciudad -> Ciudad
atravesarCrisis unaCiudad = modificarCostoDeVidaPorcentual (-10) . cerrarUltimaAtraccion $ unaCiudad

cerrarUltimaAtraccion :: Ciudad -> Ciudad
cerrarUltimaAtraccion unaCiudad = modificarAtraccion (drop 1) unaCiudad

modificarAtraccion:: ([Atraccion] -> [Atraccion]) -> Ciudad -> Ciudad
modificarAtraccion unaFuncion unaCiudad = unaCiudad {atracciones = unaFuncion.atracciones $ unaCiudad}

reevaluarCiudad :: Int -> Ciudad -> Ciudad
reevaluarCiudad cantidadDeLetras unaCiudad
    | esSobria unaCiudad cantidadDeLetras = modificarCostoDeVidaPorcentual 10 unaCiudad
    | otherwise = modificarCostoDeVida (subtract 3) unaCiudad

remodelarCiudad :: Float -> Ciudad -> Ciudad
remodelarCiudad unPorcentaje unaCiudad = agregarNombre "New " .modificarCostoDeVidaPorcentual unPorcentaje $ unaCiudad

agregarNombre :: String -> Ciudad -> Ciudad
agregarNombre nombreAConcatenar unaCiudad = modificarNombre (nombreAConcatenar ++) unaCiudad

modificarNombre :: (String -> String) -> Ciudad -> Ciudad
modificarNombre unaFuncion unaCiudad = unaCiudad {nombre = unaFuncion.nombre $ unaCiudad}

{-
PUNTO 4:
reevaluarCiudad 15 . atravesarCrisis . remodelarCiudad 25 . sumarAtraccion "Aeroclub Vedia" $ vedia
-}

--Comienzo de la entrega 2

type Evento = Ciudad -> Ciudad

data Año = UnAño {numero :: Int , eventos :: [Evento] }

año2022 :: Año
año2022 = UnAño 2022 [atravesarCrisis,remodelarCiudad 5, reevaluarCiudad 7]

año2015 :: Año
año2015 = UnAño 2015 []

pasoDeUnAño :: Año -> Ciudad -> Ciudad
pasoDeUnAño unAño unaCiudad = foldr ($) unaCiudad (eventos unAño)

algoMejor :: Ciudad -> (Ciudad -> Float) -> Evento-> Bool
algoMejor unaCiudad unCriterio unEvento  =  unCriterio unaCiudad < (unCriterio.unEvento $ unaCiudad)

cantidadDeAtracciones :: Ciudad -> Float
cantidadDeAtracciones unaCiudad = fromIntegral.length.atracciones $ unaCiudad
{-
Criterios 

costoDeVida :: Ciudad -> Float
valorDeUnaCiudad :: Ciudad -> Float
cantidadDeAtracciones :: Ciudad -> Float

--
atracciones :: Ciudad -> [String]

-}
{-costoDeVidaQueSuba :: Año -> Ciudad -> Ciudad
costoDeVidaQueSuba unAño unaCiudad = pasoDeUnAño (unAño {eventos = filter (algoMejor unaCiudad "Costo de vida") $ eventos unAño}) unaCiudad
-}

{-
costoDeVidaQueBaje :: Año -> Ciudad -> Ciudad
costoDeVidaQueBaje unAño unaCiudad = pasoDeUnAño (unAño {eventos = filter (not.algoMejor unaCiudad "Costo de vida") $ eventos unAño}) unaCiudad
-}

costoDeVidaQueSuba :: Año -> Ciudad -> Ciudad
costoDeVidaQueSuba unAño unaCiudad = pasoDeUnAño (añoConEventosCon (algoMejor unaCiudad costoDeVida) unAño ) unaCiudad

costoDeVidaQueBaje :: Año -> Ciudad -> Ciudad
costoDeVidaQueBaje unAño unaCiudad = pasoDeUnAño (añoConEventosCon (not.algoMejor unaCiudad costoDeVida) unAño ) unaCiudad

valorQueSuba ::Año -> Ciudad -> Ciudad
valorQueSuba unAño unaCiudad = pasoDeUnAño (añoConEventosCon (algoMejor unaCiudad costoDeVida) unAño ) unaCiudad

añoConEventosCon ::  (Evento -> Bool) -> Año -> Año
añoConEventosCon unaCondicion unAño  = unAño {eventos = filter unaCondicion $ eventos unAño}
{-}
eventosOrdenados :: Año -> Ciudad -> Bool
eventosOrdenados   (UnAño _ []) _ = True
eventosOrdenados   (UnAño _ [_]) _ = True
{-eventosOrdenados  unAño unaCiudad = ((costoDeVida unaCiudad) < (costoDeVida $ (head.eventos $ unAño)  unaCiudad)) && (eventosOrdenados ((drop 1) (eventos  unAño)) unaCiudad)
-}
eventosOrdenados unAño unaCiudad = foldr (&&) (eventos unAño) (algoMejor unaCiudad "Costo de vida")

costoDeVidaCreciente :: Ciudad ->Evento -> Bool
costoDeVidaCreciente  unaCiudad unEvento =  (costoDeVida unaCiudad) < (costoDeVida $ unEvento unaCiudad)
-}