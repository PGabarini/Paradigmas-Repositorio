{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use bimap" #-}
{-# HLINT ignore "Eta reduce" #-}

sumadorDeLista :: [Int] -> Int
sumadorDeLista = sum

frecuenciaCardiaca :: [Int]
frecuenciaCardiaca = [80, 100, 120, 128, 130, 123, 125]

promedioFrecuenciaCardiaca:: [Int] -> Int
promedioFrecuenciaCardiaca frecuencias = div (sum frecuencias)  (length frecuencias)

frecuenciasCardiacaMinuto :: [Int]->Int -> Int
frecuenciasCardiacaMinuto frecuencias minuto  = (!!) frecuencias (div minuto 10)

frecuenciasHastaMomento :: [Int]->Int -> [Int]
frecuenciasHastaMomento frecuencias minuto = take (div minuto 10+1) frecuencias

esCapicua :: [String] -> Bool
esCapicua lista = concat lista == (reverse.concat) lista

{-}
type HorarioReducido = (String,[Int])
type HorarioNormal = (String,[Int])
type DuracionDeLlamadas= (HorarioReducido,HorarioNormal)
-}

data DuracionLlamadas = UnaDuracionDeLlamadas {horarioReducido :: (String,[Int]) , horarioNormal :: (String,[Int]) } deriving (Show,Eq)

enQueHorarioSeHabloMas :: DuracionLlamadas -> String
enQueHorarioSeHabloMas unasLlamadas| sumaHorarioReducido unasLlamadas > sumaHorarioNormal unasLlamadas = "horarioReducido"
                                    | otherwise = "horarioNormal"

sumaHorarioReducido :: DuracionLlamadas -> Int
sumaHorarioReducido unasLlamadas = (sum.snd) $ horarioReducido unasLlamadas

sumaHorarioNormal :: DuracionLlamadas -> Int
sumaHorarioNormal unasLlamadas = (sum.snd) $ horarioNormal unasLlamadas

cuandoSeHicieronMasLlamadas :: DuracionLlamadas -> String
cuandoSeHicieronMasLlamadas unasLlamadas  | (length.snd) (horarioReducido unasLlamadas) > (length.snd) (horarioNormal unasLlamadas) = "horarioReducido"
                                            | otherwise = "horarioNormal"

--ORDEN SUPERIOR

existeAny :: (a->Bool) -> (a,a,a) -> Bool
existeAny funcionBoleana (elem1,elem2,elem3) = funcionBoleana elem1 || funcionBoleana elem2 || funcionBoleana elem3

type FuncionIncremental = (Int->Int)

mejor :: FuncionIncremental->FuncionIncremental->Int->Int
mejor funcion1 funcion2 unNumero = max (funcion1 unNumero) (funcion2 unNumero)

aplicarPar :: (a->b) -> (a,a) -> (b,b)
aplicarPar funcion tupla = (funcion.fst $ tupla , funcion.snd $ tupla)

aplicarParDeFunciones :: (a->b) -> (a->c) -> a -> (b,c)
aplicarParDeFunciones funcion1 funcion2 unValor = (funcion1 unValor,funcion2 unValor)

--ORDEN SUPERIOR + LISTAS

esMultiploDeAlguno :: Int -> [Int] -> Bool
esMultiploDeAlguno unNumero = any (esMultiploDe unNumero)

esMultiploDe :: Int->Int->Bool
esMultiploDe multiplo unNumero = mod multiplo unNumero== 0

promedios ::[[Int]] -> [Int]
promedios lista = map sacarProm lista

sacarProm ::[Int] -> Int
sacarProm lista =  div (sum lista)  (length lista) 

promediosSinAplazos :: [[Int]] -> [Int]
promediosSinAplazos lista = promedios (listaSin4 lista)

listaSin4 :: [[Int]] -> [[Int]]
listaSin4 lista = map (filter (>4)) lista

mejoresNotas :: [[Int]] -> [Int]
mejoresNotas lista = map maximum lista

aprobo :: [Int] -> Bool
aprobo notas = all (>5) notas

alumnosQueAprobaron :: [[Int]] -> [[Int]]
alumnosQueAprobaron lista =  filter aprobo lista

