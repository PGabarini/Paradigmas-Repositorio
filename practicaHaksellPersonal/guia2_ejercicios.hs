
siguiente :: Int -> Int
siguiente = (+3)

mitad :: Float -> Float
mitad = (/2)

inversa :: Float -> Float
inversa = (1/)

triple :: Num a=> a->a
triple = (*3)

esNumeroPositivo :: Float->Bool
esNumeroPositivo = (>0)

inversaRaizCuadrada :: Float -> Float
inversaRaizCuadrada = raizCuadrada.inversa

raizCuadrada :: Float -> Float
raizCuadrada = sqrt

incrementMCuadradoN :: Int -> Int -> Int
incrementMCuadradoN numeroM numeroN=  numeroM +numeroN*numeroN  --(^ 2) numeroN

esParNaM:: Int -> Int -> Bool
esParNaM numM = even.elevaNaM numM

elevaNaM :: Int -> Int -> Int
elevaNaM = (^)

