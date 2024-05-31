
data Participante = UnParticipante {
            nombre :: String ,
        trucosDeCocina :: [Truco] ,
        especialidad :: Plato }

data Plato = UnPlato {nombreplato :: String ,
                    dificultad::Int,
                    componentes :: [Componente] }

type Componente = ( Ingrediente , Peso )
type Ingrediente = String
type Peso = Float

type Truco = Plato -> Plato

--- Trucas
endulzar :: Peso -> Truco
endulzar  unPeso unPlato = modificarComponentes (("Azucar", unPeso) :) unPlato

salar :: Peso -> Truco
salar unPeso unPlato = modificarComponentes (("Sal", unPeso) :) unPlato

darSabor :: Peso -> Peso -> Truco
darSabor  unosGramosDeSal unosGramosDeAzucar unPlato = endulzar unosGramosDeAzucar . salar unosGramosDeSal $ unPlato

modificarComponentes :: ([Componente]->[Componente])->Truco
modificarComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion.componentes $ unPlato} 

duplicarPorcion:: Truco
duplicarPorcion unPlato = modificarComponentes duplicarComponetes unPlato

duplicarComponetes :: [Componente] -> [Componente]
duplicarComponetes unosComponentes = map duplicarGramos unosComponentes

duplicarGramos :: Componente -> Componente
duplicarGramos (ingrediente , gramos ) =  (ingrediente , gramos *2)

simplificar :: Truco
simplificar unPlato | esComplejo unPlato =
                                         modificarComponentes (quitarComponetesConGramos 10).modificarDificultad (const 5) $ unPlato
                    | otherwise = unPlato

modificarDificultad :: (Int->Int)->Truco
modificarDificultad unaFuncion unPlato = unPlato {dificultad = unaFuncion.dificultad $ unPlato} 

quitarComponetesConGramos :: Float -> [Componente] -> [Componente]
quitarComponetesConGramos unosGramos unosComponentes = filter ((>unosGramos).snd) unosComponentes


---
esVegano :: Plato -> Bool
esVegano unPlato = not (coincidenIngredientes ["huevos","carne","leche"]  unPlato)

coincidenIngredientes :: [Ingrediente] -> Plato -> Bool
coincidenIngredientes unosIngredientes unPlato = any ( ( `elem` unosIngredientes  ) . fst) (componentes unPlato)

esSinTacc :: Plato -> Bool
esSinTacc unPlato = not (coincidenIngredientes ["harina"] unPlato)

esComplejo :: Plato -> Bool
esComplejo unPlato = ((>7).dificultad $ unPlato) &&  ((>5).length.componentes $ unPlato)

--

pepeRonoccio :: Participante
pepeRonoccio = UnParticipante "Pepe Ronoccio" [darSabor 2 5, simplificar ,duplicarPorcion] asado

asado :: Plato
asado = UnPlato "Asado" 8 [("Sal",20),("a",2),("b",66),("na",3.2)]

--

cocinar ::  Participante -> Plato
cocinar unParticipante = foldr ($) (especialidad unParticipante) (trucosDeCocina unParticipante)

esMejorQue :: Plato -> Plato ->Bool
esMejorQue unPlato otroPlato = dificultad unPlato > dificultad otroPlato && sumaDeComponentes unPlato < sumaDeComponentes otroPlato

sumaDeComponentes :: Plato -> Float
sumaDeComponentes unPlato = foldr (+) 0 (map snd (componentes unPlato))

participanteEstrella :: [Participante] -> Participante
participanteEstrella [unSoloParticipante] = unSoloParticipante
participanteEstrella (primerParticpante : colaDeParticipantes) = mejorParticipante primerParticpante (participanteEstrella colaDeParticipantes)
participanteEstrella u = head u 

mejorParticipante :: Participante -> Participante ->Participante
mejorParticipante unParticipante otroParticipante | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) = unParticipante
                                                  | otherwise = otroParticipante
                                                
platinum :: Plato
platinum = UnPlato "Platino" 10 listaDeComponentesRaros

listaDeComponentesRaros :: [Componente]
listaDeComponentesRaros = map (generaComponenteRaro ("Ingrediente ",0)) [1..]

generaComponenteRaro :: Componente -> Float -> Componente
generaComponenteRaro (ingrediente,gramos) numero =  (ingrediente ++ show numero , gramos + numero)