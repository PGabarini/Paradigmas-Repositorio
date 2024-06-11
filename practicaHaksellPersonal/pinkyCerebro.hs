
data Animal = UnAnimal {coeficiente :: Int ,
                        especie :: String ,
                        capacidades :: [Capacidad]}

type Capacidad = String
--
inteligenciaSuperior :: Int -> Animal -> Animal 
inteligenciaSuperior unNumero unAnimal = modificarInteligencia (unNumero+) unAnimal

modificarInteligencia :: (Int->Int) -> Animal -> Animal
modificarInteligencia unaFuncion unAnimal = unAnimal {coeficiente= unaFuncion.coeficiente $ unAnimal}
--
pinkyficar :: Animal -> Animal 
pinkyficar unAnimal = modificarHabilidades (const []) unAnimal
--
modificarHabilidades :: ([Capacidad]->[Capacidad]) -> Animal -> Animal
modificarHabilidades unaFuncion unAnimal = unAnimal {capacidades= unaFuncion.capacidades $ unAnimal}
--
superpoderes :: Animal -> Animal
superpoderes unAnimal | esEspecie "Elefante" unAnimal = modificarHabilidades ("No miedo raton":) unAnimal
                      | esEspecie "Raton" unAnimal && tieneCoeficiente (>100) unAnimal =  modificarHabilidades ("Hablar":) unAnimal
                      | otherwise = unAnimal
esEspecie :: String -> Animal -> Bool
esEspecie unaEspecie (UnAnimal _ especie _)= unaEspecie == especie

tieneCoeficiente :: (Int->Bool) -> Animal -> Bool
tieneCoeficiente unCriterio unAnimal = unCriterio . coeficiente $ unAnimal
--
antropomorfico :: Animal -> Bool
antropomorfico unAnimal = tieneCoeficiente (>80) unAnimal && tieneHabilidad "Hablar" unAnimal

tieneHabilidad :: Capacidad -> Animal -> Bool
tieneHabilidad unaCapacidad unAnimal = elem unaCapacidad (capacidades unAnimal)
--

noTanCuerdo :: Animal -> Bool
noTanCuerdo unAnimal =  (>2).length.capacidadesPinkiescas $ unAnimal

capacidadesPinkiescas :: Animal -> [Capacidad]
capacidadesPinkiescas unAnimal = filter pinkiesco (capacidades unAnimal)

pinkiesco :: Capacidad -> Bool
pinkiesco unaCapacidad = comienzaCon "hacer" unaCapacidad && sigueConPalabraPinkiesca (drop 5 unaCapacidad)

comienzaCon :: String -> Capacidad -> Bool
comienzaCon palabra unaCapacidad=  (==) palabra (take 4 unaCapacidad) 

sigueConPalabraPinkiesca ::  String -> Bool
sigueConPalabraPinkiesca  unaPalabra = (contieneVocal unaPalabra) && ((<5).length $ unaPalabra)

contieneVocal :: String -> Bool
contieneVocal unaPalabra = any esVocal unaPalabra

esVocal :: Char -> Bool
esVocal character = character `elem` "aeiouAEIOU"

--

type Experimento = [Transformacion]
type Transformacion = (Animal -> Animal)

type Criterio = (Animal->Bool)

experimentoExitoso :: Experimento -> Animal -> Criterio -> Bool
experimentoExitoso unExperimento unAnimal unCriterio = unCriterio . aplicarExperimento unExperimento $ unAnimal

aplicarExperimento :: Experimento -> Animal -> Animal
aplicarExperimento unExperimento unAnimal  = foldr ($) unAnimal unExperimento

nasheEjemplo :: Animal
nasheEjemplo = UnAnimal 17 "Raton" ["destggo","hss"]

ratonEjemplo :: Animal
ratonEjemplo = UnAnimal 17 "Raton" ["destruenglonir el mundo","hacer planes desalmados"]

experimentoEjemplo :: Experimento
experimentoEjemplo = [superpoderes, inteligenciaSuperior 10,pinkyficar]

--experimentoExitoso experimentoEjemplo ratonEjemplo antropomorfico

--
informeDeCoeficiente :: [Animal] -> [Capacidad] -> Experimento -> [Int] 
informeDeCoeficiente unosAnimales unasCapacidades unExperimento = map coeficiente . soloAnimalesQueCumplen any unasCapacidades . 
                                                                    aplicarTranformacionesAlGrupo unExperimento $ unosAnimales 

--

informeDeEspecies :: [Animal] -> [Capacidad] -> Experimento -> [String] 
informeDeEspecies unosAnimales unasCapacidades unExperimento=  map especie . soloAnimalesQueCumplen all unasCapacidades . 
                                                                    aplicarTranformacionesAlGrupo unExperimento $ unosAnimales

--


informeDeCapacidades :: [Animal] -> [Capacidad] -> Experimento -> Int
informeDeCapacidades unosAnimales unasCapacidades unExperimento=  length . concatMap capacidades . soloAnimalesQueCumplen all unasCapacidades . 
                                                                    aplicarTranformacionesAlGrupo unExperimento $ unosAnimales                                                                    

{-
soloAnimalesQueCumplen :: String -> [Capacidad] -> [Animal] -> [Animal]
soloAnimalesQueCumplen "Ninguno" unasCapacidades unosAnimales = filter (not . cumpelConcondicionDeCapacidad all unasCapacidades) unosAnimales
soloAnimalesQueCumplen "Todos" unasCapacidades unosAnimales = filter ( cumpelConcondicionDeCapacidad all unasCapacidades) unosAnimales
soloAnimalesQueCumplen "Alguno" unasCapacidades unosAnimales =filter ( cumpelConcondicionDeCapacidad any unasCapacidades) unosAnimales
-}
--

aplicarTranformacionesAlGrupo :: Experimento -> [Animal] -> [Animal]
aplicarTranformacionesAlGrupo unExperimento unosAnimales = map (aplicarExperimento unExperimento) unosAnimales

soloAnimalesQueCumplen :: ((Capacidad->Bool) -> [Capacidad] -> Bool) -> [Capacidad] -> [Animal] -> [Animal]
soloAnimalesQueCumplen unaCondicion unasCapacidades unosAnimales = filter ( cumpelConcondicionDeCapacidad unaCondicion unasCapacidades) unosAnimales

cumpelConcondicionDeCapacidad :: ((Capacidad->Bool) -> [Capacidad] -> Bool) -> [Capacidad] -> Animal -> Bool
cumpelConcondicionDeCapacidad unaCondicion unasCapacidades unAnimal = unaCondicion (`tieneHabilidad` unAnimal) $ unasCapacidades

--

elefanteLoco :: Animal
elefanteLoco = UnAnimal 100 "Elefante" capacidadesElefanteLocoInifinitas

capacidadDeElefanteLoco :: Capacidad
capacidadDeElefanteLoco = "nashe"

capacidadesElefanteLocoInifinitas :: [Capacidad]
capacidadesElefanteLocoInifinitas = repeat capacidadDeElefanteLoco

--
capacidadesInficiniasDeNum :: [Capacidad]
capacidadesInficiniasDeNum = map ( generaCapacidad "hola") [1..] 

generaCapacidad :: Capacidad -> Int -> Capacidad
generaCapacidad unaCapacidad numero = unaCapacidad ++ show numero

--

{-
7.  Generar todas las posibles palabras pinkiescas. Pistas:
generateWordsUpTo, que toma una longitud y genera una lista con todas las posibles palabras de hasta la longitud dada.
generateWords que toma una longitud y genera una lista de palabras donde todas tienen exactamente la longitud dada. 
-}


