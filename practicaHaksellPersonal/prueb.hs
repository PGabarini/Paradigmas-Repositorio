{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Using elem on tuple" #-}
import Data.Char()


doble :: Int -> Int
doble = (*2)

mayor:: [Int] -> Int
mayor lista = foldr max 0 lista 

oncate:: [String] -> String
oncate lista =  foldr anadirHola [] lista

anadirHola ::  String -> String -> String
anadirHola palabra palsig= palabra ++ "hola" ++ palsig 
--[2,36,21,3,66,7]  ["nashe","jua","jose"]-

agregarEnlugar :: [Int] -> Int -> Int -> [Int]
agregarEnlugar lista posicion valor = take posicion lista ++ valor : drop posicion lista

dobles :: Num a => [a] -> [a]
dobles numeros = map (\numero -> numero * 2) numeros