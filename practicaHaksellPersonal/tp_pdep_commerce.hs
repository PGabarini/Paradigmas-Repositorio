
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

-------------
esProductoDeLujo :: String -> Bool -- 5
esProductoDeLujo = tieneXoY

tieneXoY :: String -> Bool
tieneXoY palabra = elem 'y' palabra || elem 'x' palabra

esProductoCodiciado :: String -> Bool --7
esProductoCodiciado = longitudMayorA10

longitudMayorA10 :: String -> Bool
longitudMayorA10 palabra = length palabra > 10

esProductoCorriente :: String -> Bool -- 8
esProductoCorriente = empiezaConVocal

empiezaConVocal :: String -> Bool
empiezaConVocal = vocales.head

vocales :: Char -> Bool
vocales letra = letra =='a' || letra =='e' || letra =='i' || letra =='o' || letra =='u'

esProductoDeElite :: String -> Bool --2
esProductoDeElite producto = esProductoCodiciado producto && esProductoDeLujo producto && (not.esProductoCorriente) producto

productoXL :: String -> String
productoXL producto = producto ++ "XL" --9

entregaSencilla :: String -> Bool --4
entregaSencilla dia = (even.length) dia

aplicarCostoDeEnvio :: Num a => a -> a -> a --6
aplicarCostoDeEnvio precioProducto costoDeEnvio = precioProducto + costoDeEnvio

aplicarDescuento :: Num a => a -> a -> a --3
aplicarDescuento precioProducto descuento = precioProducto * (1-descuento)

precioTotal :: Num a => a -> a -> a -> a -> a --1
precioTotal precio descuento cantidad costoEnvio = aplicarCostoDeEnvio (aplicarDescuento precio descuento* cantidad) costoEnvio
  