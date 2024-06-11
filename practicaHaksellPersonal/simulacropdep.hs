

data Ninja = UnNinja {nombre :: String, herramientas::[Herramienta] , jutsus :: [Jutsu], rango:: Int}
type Herramienta = (String,Int)


obtenerHerramienta :: Ninja -> Herramienta -> Ninja 
obtenerHerramienta unNinja unaHerramienta = modificarHerramientas  (herramientaSinExcederse unaHerramienta (cantidadDeHerramientas unNinja) :) unNinja
                                         
herramientaSinExcederse ::  Herramienta -> Int -> Herramienta
herramientaSinExcederse (nombre, cantidad) herramientasDelNinja = (nombre, min 100 (cantidad+herramientasDelNinja))

modificarHerramientas :: ([Herramienta]->[Herramienta]) -> Ninja -> Ninja
modificarHerramientas unaFuncion unNinja = unNinja {herramientas= unaFuncion.herramientas $ unNinja}

cantidadDeHerramientas :: Ninja -> Int
cantidadDeHerramientas unNinja =  foldr ((+).snd) 0 (herramientas unNinja)
--cantidadDeHerramientas unNinja =  sum . map snd . herramientas $ unNinja

--
usaHerramienta :: Ninja ->Herramienta -> Ninja
usaHerramienta unNinja unaHerramienta = modificarHerramientas (quitarHerramienta unaHerramienta) unNinja

quitarHerramienta :: Herramienta->[Herramienta] -> [Herramienta]
quitarHerramienta (nombre,_ ) unasHerramientas = filter (( nombre /= ). fst ) unasHerramientas


data Mision = UnaMision { cantidadDeNinja :: Int , rangoMision :: Int , ninjasEnemigos :: [Ninja] , recompensa :: Herramienta}



esDesafiante :: [Ninja] -> Mision -> Bool
esDesafiante unosNinjas unaMision = any (not.esNivelNinjaSuficiente unaMision) unosNinjas && ((>1).cantidadDeEnemigos $ unaMision)

cantidadDeEnemigos :: Mision -> Int
cantidadDeEnemigos unaMision = length.ninjasEnemigos $ unaMision

esNivelNinjaSuficiente :: Mision->Ninja -> Bool
{-
esNivelNinjaSuficiente unaMision unNinja  = (>rangoMision unaMision). rango $ unNinja
-}
esNivelNinjaSuficiente (UnaMision _ rangoMision _ _)(UnNinja _ _ _ rangoNinja)  = rangoMision<rangoNinja
--

recompensasCopadas :: [Herramienta]
recompensasCopadas = [("bh",3),("sh",5),("kun",14)]

esCopada :: Mision -> Bool
esCopada unaMision= elem (recompensa unaMision ) recompensasCopadas 
{-
esCopada (UnaMision _ _ _ recompensaMision) = elem recompensaMision recompensasCopadas
-}

--
esFactible ::  [Ninja]-> Mision -> Bool
esFactible unosNinjas unaMision = esDesafiante unosNinjas unaMision && estanPreparados unosNinjas unaMision

estanPreparados :: [Ninja] -> Mision -> Bool
estanPreparados unosNinjas unaMision = sonNinjasNecesarios unosNinjas unaMision || ((>500).cantidadDeHerramientasGrupo $ unosNinjas)
{-
esFactible ::  [Ninja]-> Mision -> Bool
esFactible unosNinjas unaMision  | esDesafiante unosNinjas unaMision && sonNinjasNecesarios unosNinjas unaMision = True
                                | esDesafiante unosNinjas unaMision && ((>500).cantidadDeHerramientasGrupo $ unosNinjas) = True
                                | otherwise = False 
-}
sonNinjasNecesarios :: [Ninja] -> Mision ->Bool
sonNinjasNecesarios unosNinjas unaMision = length unosNinjas >= cantidadDeNinja unaMision

cantidadDeHerramientasGrupo:: [Ninja] -> Int
cantidadDeHerramientasGrupo unosNinjas =  sum . map cantidadDeHerramientas $ unosNinjas
{-
cantidadDeHerramientasGrupo [] = 0
cantidadDeHerramientasGrupo (cabeza:cola) = cantidadDeHerramientas cabeza + cantidadDeHerramientasGrupo cola-}

--

fallarMision :: [Ninja]->Mision -> [Ninja]
fallarMision unosNinjas unaMision = map (modificarRango (subtract 2)) . ninjasQueSobreviven unaMision $ unosNinjas

ninjasQueSobreviven :: Mision -> [Ninja] -> [Ninja]
ninjasQueSobreviven unaMision unosNinjas  = filter (esNivelNinjaSuficiente unaMision ) unosNinjas

modificarRango :: (Int->Int) -> Ninja -> Ninja
modificarRango unaFuncion unNinja = unNinja {rango= unaFuncion.rango $ unNinja}
--

cummplirMision :: [Ninja] -> Mision -> [Ninja]
cummplirMision unosNinjas unaMision = obtenerRecompensa unaMision . promocionar $ unosNinjas

promocionar :: [Ninja] -> [Ninja]
promocionar unosNinjas = map (modificarRango (+1)) unosNinjas

obtenerRecompensa :: Mision -> [Ninja] -> [Ninja]
--obtenerRecompensa unaMision unosNinjas = map (modificarHerramientas ( recompensa unaMision :)) unosNinjas
obtenerRecompensa (UnaMision _ _ _ recompensaMision) unosNinjas = map (modificarHerramientas ( recompensaMision :)) unosNinjas

--

type Jutsu = Mision -> Mision

clonesDeSombra :: Int -> Mision -> Mision
clonesDeSombra  cantidadDeClones unaMision |  cantidadDeClones >(cantidadDeNinja unaMision) = modificarCantidadNecesaria (const 1) unaMision
                                           | otherwise = modificarCantidadNecesaria (subtract cantidadDeClones) unaMision

modificarCantidadNecesaria :: (Int -> Int) -> Mision -> Mision
modificarCantidadNecesaria unaFuncion unaMision = unaMision {cantidadDeNinja = unaFuncion.cantidadDeNinja $ unaMision}

--

fuerzaDeUnCentenar :: Mision -> Mision
fuerzaDeUnCentenar unaMision = modificarEnemigos (filter enemigoConPoder) unaMision

enemigoConPoder :: Ninja -> Bool
enemigoConPoder unEnemigo = (500>).rango $ unEnemigo

modificarEnemigos :: ([Ninja] -> [Ninja]) ->  Mision -> Mision
modificarEnemigos unaFuncion unaMision = unaMision {ninjasEnemigos = unaFuncion.ninjasEnemigos $ unaMision}

--

ejecutarMision :: [Ninja] ->  Mision -> [Ninja]
ejecutarMision unosNinjas unaMision = completarMision unosNinjas . usarJutsus unosNinjas $ unaMision

completarMision :: [Ninja] -> Mision -> [Ninja]
completarMision unosNinjas unaMision  |esFactible unosNinjas unaMision || esCopada unaMision = cummplirMision unosNinjas unaMision
                                      | otherwise = fallarMision unosNinjas unaMision

usarJutsus :: [Ninja] -> Mision -> Mision
usarJutsus unosNinjas unaMision = foldr ($) unaMision (jutsusDelGrupo unosNinjas)

jutsusDelGrupo :: [Ninja] -> [Jutsu]
jutsusDelGrupo unosNinjas = concatMap jutsus unosNinjas

--

granGuerraNinja :: Mision
granGuerraNinja = UnaMision 10000 100 infinitosEnemigosZetsu abanicoMadara

infinitosEnemigosZetsu :: [Ninja]
infinitosEnemigosZetsu =  map (generaUnZetsu zetsu ) [1..] 

zetsu :: Ninja
zetsu = UnNinja "Zetsu" [] [] 600

generaUnZetsu :: Ninja -> Int -> Ninja
generaUnZetsu unNinja numero = unNinja {nombre =  (show numero ++). nombre $ unNinja} 

abanicoMadara :: Herramienta
abanicoMadara = ("abanico",1)

-- esDesafiante [infinitosNinjas]  granGuerraNinja
--Si devuelve True la primera parte luego : NO porque debe medir la cantidad de enemigos con un length
--Ademas la primera parte no puede dar False porque nunca terminaria de evaluar para dar False


--esCopada granGuerraNinja
--Si devolveria bien

--fuerzaCentenar granGuerraNinja
-- jamas llegaria de filtrar los ninjas

