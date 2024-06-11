import Text.Show.Functions()

data Perro = UnPerro {raza :: String,
                      juguetesFavoritos :: [String],
                      tiempoEnGuarderia :: Int,
                      energia :: Int  } deriving Show

data Guarderia = UnaGuarderia {nombre :: String,
                            rutina :: [Actividad]}

data Actividad = UnaActividad { ejercicio :: Ejercicio ,
                                 tiempoActividad :: Int}

type Ejercicio = Perro ->Perro

jugar ::  Ejercicio
jugar  unPerro = modificarEnergia (max 0.subtract 10) unPerro

modificarEnergia :: (Int->Int) -> Perro ->Perro
modificarEnergia unaFuncion unPerro = unPerro { energia = unaFuncion.energia $ unPerro}
--

ladrar :: Int ->Perro -> Perro
ladrar unosLadridos unPerro = modificarEnergia (+div unosLadridos 2) unPerro
--
regalar :: String -> Perro -> Perro
regalar unJuguete unPerro = modificarJuguetes (unJuguete:) unPerro

modificarJuguetes :: ([String]->[String])->Perro ->Perro 
modificarJuguetes unaFuncion  unPerro = unPerro {juguetesFavoritos = unaFuncion . juguetesFavoritos $ unPerro }
--
razasEstravagantes :: [String]
razasEstravagantes = ["Dalmata", "Pomeria"]

diaDeSpa :: Perro -> Perro
diaDeSpa unPerro | esRazaExtravagante unPerro || estaraEnLaGuarderia 50 unPerro = recibePremioYseEnergiza unPerro
                 | otherwise = unPerro

esRazaExtravagante :: Perro -> Bool
esRazaExtravagante (UnPerro raza _ _ _) = elem raza razasEstravagantes

estaraEnLaGuarderia :: Int->Perro-> Bool
estaraEnLaGuarderia unTiempo (UnPerro _ _ tiempoDePerroEnGuarderia _) = tiempoDePerroEnGuarderia >= unTiempo

recibePremioYseEnergiza :: Perro -> Perro
recibePremioYseEnergiza unPerro = modificarEnergia (const 100).modificarJuguetes ("Peine de goma":) $ unPerro
--
diaDeCampo :: Perro ->Perro
diaDeCampo unPerro = modificarJuguetes (drop 1) unPerro
---
zara :: Perro
zara = UnPerro "Dalmata" ["Pelota","Mantita"] 90 80

guarderiaDePerritos :: Guarderia
guarderiaDePerritos = UnaGuarderia "guarderiaDePerritos" [ UnaActividad jugar 10, UnaActividad (ladrar 18) 20,
                                                             UnaActividad (regalar "Pelota") 0,UnaActividad diaDeSpa 120, UnaActividad diaDeCampo 720 ]
--
puedeEstarEnLaGuarderia :: Perro -> Guarderia ->Bool
puedeEstarEnLaGuarderia (UnPerro _ _ tiempoPerro _) unaGuarderia = tiempoPerro >= tiempoRutina (rutina unaGuarderia)

tiempoRutina :: [Actividad] -> Int
tiempoRutina unasActivadades =sum . map tiempoActividad $  unasActivadades
--

reconocerResponsables :: [Perro] -> [Perro]
reconocerResponsables unosPerros = filter (tieneJuguetesFavoritos 3) . map diaDeCampo $ unosPerros

tieneJuguetesFavoritos :: Int->Perro->Bool
tieneJuguetesFavoritos unaCantidadDeJuguetes  (UnPerro _ juguetes _ _ ) = unaCantidadDeJuguetes<length juguetes 
--
realizarRutina :: Guarderia->Perro ->Perro
realizarRutina unaGuarderia unPerro  | puedeEstarEnLaGuarderia unPerro unaGuarderia = realizaActividades unPerro (rutina unaGuarderia)
                                    | otherwise = unPerro

realizaActividades :: Perro -> [Actividad] ->Perro
realizaActividades unPerro  unasActivadades = foldr ($) unPerro (map ejercicio unasActivadades)

--
reportarPerrosCansados :: [Perro] ->Guarderia-> [Perro]
reportarPerrosCansados unosPerros unaGuarderia = filter ((5>).energia) . map (realizarRutina unaGuarderia) $ unosPerros
--

perroPi ::Perro 
perroPi = UnPerro "Labrador" infinitasSogas 314 159

infinitasSogas :: [String]
infinitasSogas = map (generaSoga "Soguita ") [1..]

generaSoga :: String -> Int -> String
generaSoga unaSoga unaNumeracion = unaSoga ++ show unaNumeracion

--
{-
--1 ¿Sería posible saber si Pi es de una raza extravagante?
Si, seria Posible, ya que solo se evaluaria su raza, la cual es labrador, por lo que daria False. No entra en juego en ningun
momento la lista infinita
Consulta: esRazaExtravagante perroPi 

2. ¿Qué pasa si queremos saber si Pi tiene…

Funcion para el punto
esJugueteFavorito :: String -> Perro -> Bool
esJugueteFavorito unJuguete unPerro =  any (unJuguete ==) . juguetesFavoritos $ unPerro


… algún huesito como juguete favorito? 
La consulta se veria como: esJugueteFavorito "Huesito"
En este caso jamas se terminaria de evaliar, ya que seria una sucesion de FALSE por lo que any jamas se detendria, no encuentra algun TRUE
deterse, seguiria buscando infinitamente algu "HUesito", pero PerroPi solo tiene "Sogas"

… alguna pelota luego de pasar por la Guardería de Perritos?
Consulta: esJugueteFavorito "Pelota". realizarRutina guarderiaDePerritos $ perroPi
En este caso la respuesta seria TRUE, ya que realizarRutina, con ls actividades propuestas en La Guarderia, nunca necesuta evaluar la lista
completa de elementos de los juguetesFavoritos. Esto debido a la Lazy evaluation. A su vez, luego de la actividad regalar "pelota", la 
funcion ANY encontrara un elemento TRUE y retornara sin problema

… la soguita 31112?
Consulta : esJugueteFavorito "Soguita 31112" perroPi
En este caso nuevamente, por evaluacion perezosa, la funcion solo generara hasta que ANY encuentre algun elemento que cumpla su condicion,
por lo tanto SI llegara el momento en el que se genere la SOGA 31112 y ANY retorne TRUE

¿Es posible que Pi realice una rutina?
Consulta: realizarRutina guarderiaDePerritos PerroPi
Si, PerroPI puede realizar cualquier rutina en la que ninguna de sus activdades requieran evaluar la lista COMPLETA de sus juguetes favoritos
Por ejemplo perroPi no puede participar de reconocerAlosResponsables.

¿Qué pasa si le regalamos un hueso a Pi?
regalar "Hueso" perroPi
En este caso, no pasa nada, PerroPi obtendra un nuevo huesito! Por lazy evaluation haskell jamas evaluara la lista completa de juguetes
o la necesitara, agregara "Hueso" a PerroPi sin mirar la lista

Para todos los casos anteriores es importante aclarar que NUNCA se podra mostrar por consola o pantalla a perroPi, debido a su lista de 
juguetesFavoritos Infinita. Las funciones mencionadas anteriormente que devuelven tipo PERRO, SI funcionan pero al llamarlas y querer 
mostrar como resultado a PerroPi fallaran, pero si funcionan.
-}