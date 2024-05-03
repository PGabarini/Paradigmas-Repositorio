esMultiploDe3 :: Int -> Bool
esMultiploDe3 unNumero = mod unNumero 3 == 0

esMultiploDe :: Int -> Int -> Bool
esMultiploDe primerNumero segundoNumero = mod segundoNumero primerNumero == 0

cuboDeUnNumero :: Num a => a -> a
cuboDeUnNumero unNumero = unNumero * 3 --unNumero ^ 3

areaTrignagulo :: Float->Float->Float
areaTrignagulo base altura = (base * altura) * 0.5

esAnoBisiesto :: Int-> Bool
esAnoBisiesto unAño = esMultiploDe 400 unAño || esMultiploDe 4 unAño && not (esMultiploDe 100 unAño)



{- DISPERSION
Trabajamos con tres números que imaginamos como el nivel del río Paraná a la altura 
de Corrientes medido en tres días consecutivos; cada medición es un entero que representa una cantidad de cm.

P.ej. medí los días 1, 2 y 3, las mediciones son: 322 cm, 283 cm, y 294 cm. 
A partir de estos tres números, podemos obtener algunas conclusiones. 
Definir estas funciones: -}

dispersion :: Int->Int->Int->Int
dispersion alturaDia1 alturaDia2 alturaDia3 = maximoEntre3 alturaDia1 alturaDia2 alturaDia3 -
                                             minimoEntre3 alturaDia1 alturaDia2 alturaDia3

maximoEntre3 :: Int->Int->Int->Int
maximoEntre3 num1 num2 = max (max num1 num2)

minimoEntre3 :: Int->Int->Int->Int
minimoEntre3 num1 num2 = min (min num1 num2)

diasParejos :: Int->Int->Int->Bool
diasParejos alturaDia1 alturaDia2 alturaDia3 = dispersion alturaDia1 alturaDia2 alturaDia3 < 30

diasLocos :: Int->Int->Int->Bool
diasLocos alturaDia1 alturaDia2 alturaDia3 = dispersion alturaDia1 alturaDia2 alturaDia3 > 1000


diasNormales :: Int->Int->Int->Bool
diasNormales alturaDia1 alturaDia2 alturaDia3 = not (diasParejos alturaDia1 alturaDia2 alturaDia3) &&
                                                not (diasLocos alturaDia1 alturaDia2 alturaDia3)

{-
En una plantación de pinos, de cada árbol se conoce la altura expresada en cm.
 El peso de un pino se puede calcular a partir de la altura así: 3 kg x cm hasta 3 metros, 2 kg x cm arriba
  de los 3 metros. P.ej. 2 metros ⇒  600 kg, 5 metros ⇒  1300 kg. 
Los pinos se usan para llevarlos a una fábrica de muebles,
 a la que le sirven árboles de entre 400 y 1000 kilos, un pino fuera de este rango no le sirve a la fábrica.
  Para esta situación:
   -}
pesoPino :: Int -> Int
pesoPino altura |altura < 4 = altura * 3
                |otherwise = 900 + 2 * altura

esPesotil :: Int -> Bool
esPesotil peso =  peso < 1000 && peso > 400

sirvePino :: Int -> Bool
sirvePino = esPesotil.pesoPino

