{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use bimap" #-}
{-# HLINT ignore "Use uncurry" #-}

type TupaTriple = (Int,Int,String)
type TuplaDeFunciones = (Int->Int,Int->Int)

fst3 :: TupaTriple -> Int
fst3 (prim,_,_) = prim

doble :: Int->Int
doble = (*2)

triple :: Int->Int
triple = (*3)

aplicar :: TuplaDeFunciones ->Int->Int
aplicar (f1,f2) = f2.f1

cuentaBizarra :: (Int,Int) -> Int
cuentaBizarra (primerN,segundoN) | primerN>segundoN = primerN+segundoN
                                | (>10) (segundoN-primerN) =segundoN-primerN
                                | otherwise = primerN*segundoN

type NotasDeAlumno = (Int,Int)

esNotaBochazo :: Int -> Bool
esNotaBochazo = (<6)

aprobo :: NotasDeAlumno -> Bool
aprobo (nota1,nota2)= (not.esNotaBochazo) nota1 && (not.esNotaBochazo) nota2

promocion :: NotasDeAlumno -> Bool
promocion notas=  ambasMayorque7 notas && sumaDeNotas15 notas

ambasMayorque7 :: NotasDeAlumno -> Bool
ambasMayorque7 (nota1,nota2)=  (>7) nota1 && (>7) nota2

sumaDeNotas15 :: NotasDeAlumno -> Bool
sumaDeNotas15 (nota1,nota2)= (>14) (nota1+nota2)

aproboElPrimerParcial :: NotasDeAlumno -> Bool
aproboElPrimerParcial notas = (not.esNotaBochazo.fst) notas

type ParcialesYRecus = ((Int,Int),(Int,Int))

notaFinal :: ParcialesYRecus -> NotasDeAlumno
notaFinal notas = mejoresNotas (fst notas) (snd notas)      -- | (aprobo.fst) notas = fst notas 

mejoresNotas :: NotasDeAlumno -> NotasDeAlumno -> NotasDeAlumno
mejoresNotas notasP notasR = (max (fst notasP) (fst notasR),max (snd notasP) (snd notasR))

recursa :: ParcialesYRecus -> Bool
recursa = not.aprobo.notaFinal

recuperoElPrimerP :: ParcialesYRecus -> Bool
recuperoElPrimerP notas| (aproboElPrimerParcial.fst) notas= True
                        |  (aproboElPrimerParcial.snd) notas = True
                         |otherwise = False

recuperoDeGusto :: ParcialesYRecus -> Bool
recuperoDeGusto notas= (promocion.fst) notas && (> -2) ((notasRecuperatorios.snd) notas)

notasRecuperatorios:: NotasDeAlumno -> Int
notasRecuperatorios notas = fst notas + snd notas

type Persona = (String,Int)

esMayorDeEdad :: Persona -> Bool
esMayorDeEdad = (>21).snd

por2ElParMas1elImpar :: (Int,Int) -> (Int,Int)
por2ElParMas1elImpar tupla = (x2SiesPar.fst $ tupla, mas1SiEsImpar.snd $ tupla)

x2SiesPar:: Int -> Int
x2SiesPar num| even num = 2*num
            |otherwise = num

mas1SiEsImpar :: Int->Int
mas1SiEsImpar num | odd num = num+1
                    |otherwise = num