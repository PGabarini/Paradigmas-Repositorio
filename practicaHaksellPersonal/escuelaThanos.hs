data Personaje = UnPersonaje {edad :: Int ,
                             energia :: Int,
                             habilidades :: [Habilidad], 
                             nombre :: String,
                             planeta :: String} deriving Show

data Guantelete = UnGuantelete {material :: Material,
                                gemas ::[Gema]} 
type Material = String
type Gema =  (Personaje -> Personaje )


type Habilidad = String
type Universo = [Personaje]


chasquearUniverso :: Guantelete -> Universo -> Universo
{-
chasquearUniverso guanteleteCompleto unUniverso =  take (div (tamañoUniverso unUniverso) 2) (reverse unUniverso)
-}
chasquearUniverso unGuantelete unUniverso | esGuanteleteCompleto unGuantelete = reducir unUniverso
                                          | otherwise = unUniverso

esGuanteleteCompleto :: Guantelete -> Bool
esGuanteleteCompleto unGuantelete = tieneTodasLasGemas unGuantelete && esMaterial "Uru" unGuantelete

esMaterial :: Material -> Guantelete -> Bool
esMaterial unMaterial unGuantelete = (unMaterial ==).material $ unGuantelete

tieneTodasLasGemas :: Guantelete -> Bool
tieneTodasLasGemas unGuantelete = (6 ==).length.gemas $ unGuantelete

reducir :: Universo -> Universo
reducir unUniverso = take (div (tamañoUniverso unUniverso) 2) (reverse unUniverso)

guanteleteCompleto :: Guantelete
guanteleteCompleto = UnGuantelete "Uru" [laMente 2]

gemasDePoder :: [Gema] 
gemasDePoder = [laMente 2]

tamañoUniverso :: Universo -> Int
tamañoUniverso unUniverso = length unUniverso
--

esAptoParaPendex :: Universo -> Bool
esAptoParaPendex unUniverso = any ((45>).edad) unUniverso

energiaTotal :: Universo -> Int 
energiaTotal unUniverso = sum (map energia (personajesConHabilidad unUniverso)) 

personajesConHabilidad :: [Personaje] -> [Personaje]
personajesConHabilidad unosPersonjes = filter ((0>).length.habilidades) unosPersonjes

--
laMente :: Int -> Gema
laMente unNumero unPersonaje = modificarEnergia (subtract unNumero)  unPersonaje

modificarEnergia :: (Int -> Int) -> Personaje ->Personaje
modificarEnergia unaFuncion unPersonaje = unPersonaje {energia= unaFuncion.energia $ unPersonaje }
--
elAlma :: Habilidad -> Gema
elAlma unaHabilidad unPersonaje = quitarHabilidad unaHabilidad.modificarEnergia (subtract 10) $ unPersonaje

quitarHabilidad :: Habilidad -> Personaje -> Personaje
quitarHabilidad unaHabilidad unPersonaje = modificarHabilidades (filter (unaHabilidad /=)) unPersonaje

modificarHabilidades :: ([Habilidad]->[Habilidad]) -> Personaje -> Personaje
modificarHabilidades  unaFuncion unPersonaje = unPersonaje {habilidades = unaFuncion.habilidades $ unPersonaje}

--
elEspacio :: String -> Gema
elEspacio unPlaneta unPersonaje = teletransportar unPlaneta.modificarEnergia (subtract 20) $ unPersonaje

teletransportar :: String -> Personaje->Personaje
teletransportar unPlaneta unPersonaje = unPersonaje {planeta = unPlaneta}
--
elPoder :: Gema
elPoder unPersonaje =  quitar2Habilidades.modificarEnergia (const 0) $ unPersonaje

quitar2Habilidades :: Personaje ->Personaje
quitar2Habilidades unPersonaje |(3<).length.habilidades $ unPersonaje = modificarHabilidades (const []) unPersonaje
                               | otherwise = unPersonaje
--
elTiempo :: Gema
elTiempo unPersonaje = modificarEdad ((max 18) . dividirEdad).modificarEnergia (subtract 50) $ unPersonaje

modificarEdad :: (Int->Int) -> Personaje ->Personaje
modificarEdad unaFuncion unPersonaje = unPersonaje {edad = unaFuncion.edad $ unPersonaje}

dividirEdad :: Int -> Int
dividirEdad unaEdad = div unaEdad 2
--
laGemaLoca :: Int-> Gema ->Gema
laGemaLoca unaCantidad unaGema unPersonaje = foldr ($) unPersonaje (replicate unaCantidad unaGema)
--

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = UnGuantelete "Goma" [elTiempo,elAlma "usar Mjolnir", laGemaLoca 2 (elAlma "programación en Haskell")]
--
utilizarGemas :: [Gema] -> Personaje ->Personaje
utilizarGemas unasGemas unPersonaje = foldr ($) unPersonaje unasGemas

--
gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa unGuantelete unPersonaje =  gemaMasPoderosaDe unPersonaje (gemas unGuantelete)  

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema  
gemaMasPoderosaDe _ [unaGema] = unaGema 
gemaMasPoderosaDe unPersonaje (gema1 : demasGemas) = mejorGema unPersonaje gema1 (gemaMasPoderosaDe unPersonaje demasGemas )
gemaMasPoderosaDe _ w = head w
                                                           
mejorGema :: Personaje->Gema -> Gema -> Gema
mejorGema unPersonaje gema1 gema2 | (energia.gema1 $ unPersonaje) > (energia.gema2 $ unPersonaje) = gema2
                                 |otherwise = gema1

