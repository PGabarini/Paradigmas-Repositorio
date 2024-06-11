

data Personaje = UnPersonaje { nombre :: String,
                                salud :: Float,
                                elementos :: [Elemento],
                                anioPresente :: Int }

data Elemento = UnElemento { tipo :: String, 
                            ataque :: (Personaje-> Personaje), 
                            defensa :: (Personaje -> Personaje) }

type Tranformacion = Personaje -> Personaje

mandarAlAnio :: Int -> Personaje -> Personaje
mandarAlAnio unAño unPersonaje  = modificarAnioPresente (const unAño) unPersonaje

modificarAnioPresente :: (Int->Int)->Personaje ->Personaje
modificarAnioPresente unaFuncion unPersonaje = unPersonaje {anioPresente= unaFuncion . anioPresente $ unPersonaje}
--
meditar :: Personaje -> Personaje
meditar unPersonaje = modificarSalud (*1.5) unPersonaje

modificarSalud :: (Float -> Float) -> Personaje -> Personaje
modificarSalud unaFuncion unPersonaje = unPersonaje {salud = unaFuncion . salud $ unPersonaje}

--
daniarEnemigo ::  Float -> Personaje -> Personaje
daniarEnemigo  unDaño unEnemigo = modificarSalud (max 0 . subtract unDaño) unEnemigo

--
esMalvado :: Personaje -> Bool
esMalvado unPersonaje = any esElementoMalvado (elementos unPersonaje)

esElementoMalvado :: Elemento -> Bool
esElementoMalvado (UnElemento "Malvado" _ _) = True
esElementoMalvado _ = False
--
danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce unPersonaje unElemento = (salud unPersonaje) - (salud . ataque unElemento $ unPersonaje)
--

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales unPersonaje unosEnemigos = filter (esEnemigoMortalDe unPersonaje) unosEnemigos

esEnemigoMortalDe :: Personaje -> Personaje -> Bool
esEnemigoMortalDe unPersonaje unEnemigo = any (tieneElementoQueAsesinaA unPersonaje) (elementos unEnemigo )  

tieneElementoQueAsesinaA :: Personaje -> Elemento -> Bool
tieneElementoQueAsesinaA unPersonaje unElemento = salud unPersonaje <= danioQueProduce unPersonaje unElemento
--

concentracion :: Int -> Elemento
concentracion unNivel = UnElemento "Magia" meditar (generaAccion unNivel meditar )

generaAccion :: Int ->(Personaje ->Personaje)-> Personaje ->Personaje
generaAccion unaCantidad unaAccion unPersonaje = foldr ($) unPersonaje (replicate unaCantidad unaAccion)

--
esbirrosMalvados :: Int -> Elemento
esbirrosMalvados unaCantidad = UnElemento "Malvado" (generaAccion unaCantidad (daniarEnemigo 1)) meditar



jack :: Personaje
jack = UnPersonaje "Jack" 300 [concentracion 3, katanaMagica] 200

katanaMagica :: Elemento 
katanaMagica = UnElemento "Magia" (daniarEnemigo 1000) meditar

aku :: Int -> Float -> Personaje 
aku unAño unaSalud = UnPersonaje "Aku" unaSalud [concentracion (100*unAño), esbirrosMalvados 3, portalAlFuturo unAño] unAño

portalAlFuturo :: Int -> Elemento
portalAlFuturo unAño  = UnElemento "Magia"  (mandarAlAnio (futuroDe unAño) ) (generarAkuFuturo unAño)

generarAkuFuturo :: Int -> Personaje ->Personaje
generarAkuFuturo unAño unPersonaje = aku (futuroDe unAño) (salud unPersonaje)

futuroDe :: Int -> Int
futuroDe unAño = unAño+2800

luchar :: Personaje -> Personaje -> (Personaje, Personaje)
luchar  atacante defensor | sigueVivo.(aplicarAtaques defensor).aplicarDefensas $ atacante= luchar defensor atacante
                          |otherwise = (defensor , atacante)

aplicarDefensas :: Personaje -> Personaje
aplicarDefensas unPersonaje = foldr ($) unPersonaje (map defensa (elementos unPersonaje))  

aplicarAtaques :: Personaje -> Personaje ->Personaje 
aplicarAtaques defensor atacante =  foldr ($) defensor (map ataque (elementos atacante))  
    
sigueVivo :: Personaje -> Bool
sigueVivo (UnPersonaje _ salud _ _) = salud>0