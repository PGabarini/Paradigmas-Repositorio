import Text.Show.Functions()
{- Lazy Evaluation
distancia :: Int->Int -> Int
distancia x y = abs (x - y)

> distancia (3*40) (div 600 3)
    abs ((3*40) - (div 600 3))
--
fst (2*40 , div 600 0) nunca hago el div q no anda
(2*40)
80
--


-}

{-
tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada unaCiudad = any (isVowel.head) $ [String]

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"
-}

{-
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
-}

{-
laGemaLoca :: Int-> Gema ->Gema
laGemaLoca unaCantidad unaGema unPersonaje = foldr ($) unPersonaje (replicate unaCantidad unaGema)
-}

{-
platinum :: Plato
platinum = UnPlato "Platino" 10 listaDeComponentesRaros

listaDeComponentesRaros :: [Componente]
listaDeComponentesRaros = map (generaComponenteRaro ("Ingrediente ",0)) [1..]

generaComponenteRaro :: Componente -> Float -> Componente
generaComponenteRaro (ingrediente,gramos) numero =  (ingrediente ++ show numero , gramos + numero)
-}

{-


sumaDeComponentes :: Plato -> Float
sumaDeComponentes unPlato = foldr (+) 0 (map snd (componentes unPlato))

participanteEstrella :: [Participante] -> Participante
participanteEstrella [unSoloParticipante] = unSoloParticipante
participanteEstrella (primerParticpante : colaDeParticipantes) = mejorParticipante primerParticpante (participanteEstrella colaDeParticipantes)
participanteEstrella u = head u 

mejorParticipante :: Participante -> Participante ->Participante
mejorParticipante unParticipante otroParticipante | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) = unParticipante
                                                  | otherwise = otroParticipante

esMejorQue :: Plato -> Plato ->Bool
esMejorQue unPlato otroPlato = dificultad unPlato > dificultad otroPlato && sumaDeComponentes unPlato < sumaDeComponentes otroPlato
-}

{-
modificarHabilidades :: ([Habilidad]->[Habilidad]) -> Chico ->Chico
modificarHabilidades unaFuncion unChico = unChico{habilidades= unaFuncion.habilidades $ unChico}
--
serGrosoEnElNeedForSpeed:: Chico -> Chico
serGrosoEnElNeedForSpeed unChico = modificarHabilidades (habilidadesDeNedForSpeed++) unChico

habilidadesDeNedForSpeed :: [Habilidad]
habilidadesDeNedForSpeed = map (("Jugar Need For Speed" ++) . show ) ["1.."]
-}