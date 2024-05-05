{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}


data Jugador = UnJugador {nombre :: String , cantidadDeDinero :: Int , tactica :: String
                        , propiedadesCompradas :: [Propiedad], acciones :: [Accion] }

type Propiedad = (String, Int)
type Accion = (Jugador->Jugador)

--JUGADORES
manuel :: Jugador
manuel = UnJugador "Manuel" 500 "Oferente Singular" [] [pasarPorElBanco,enojarse]

carolina :: Jugador
carolina = UnJugador "Carolina" 500 "accionista" [] [pasarPorElBanco,pagarAAcionistas]

--PASAR POR EL BANCO
pasarPorElBanco :: Accion
pasarPorElBanco unJugador = (modificarDinero (+40) . modificarTactica "Comprador compulsivo") unJugador

modificarDinero :: (Int->Int)->Jugador -> Jugador
modificarDinero unaFuncion unJugador = unJugador{cantidadDeDinero= (unaFuncion.cantidadDeDinero) unJugador}

modificarTactica :: String->Jugador -> Jugador
modificarTactica unaTactica unJugador = unJugador{tactica= unaTactica}

--ENOJARSE
enojarse :: Accion
enojarse unJugador = (modificarDinero (+50).sumarAccion gritar) unJugador

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHHH"++nombre unJugador}

sumarAccion :: Accion->Jugador->Jugador
sumarAccion unaAccion unJugador = unJugador{acciones= unaAccion : acciones unJugador}

--PAGAR A ACCIONISTAS
pagarAAcionistas :: Accion
pagarAAcionistas unJugador|esTactica "Accionista" unJugador = modificarDinero (+200) unJugador
                        | otherwise = modificarDinero (subtract 100) unJugador

esTactica :: String->Jugador -> Bool
esTactica unaTactica unJugador = tactica unJugador == unaTactica

--COBRAR ALQUILERES
cobrarAlquileres:: Accion
cobrarAlquileres unJugador = modificarDinero (+ (alquilerTotal.precioDeLasPropiedades) unJugador) unJugador

alquilerTotal :: [Int] -> Int
alquilerTotal unosPreciosDePropiedades = ((10*).cantidadPropiedades (<150)) unosPreciosDePropiedades +
                                         ((20*).cantidadPropiedades (>150)) unosPreciosDePropiedades

cantidadPropiedades :: (Int->Bool)-> [Int] -> Int
cantidadPropiedades unPrecio unosPreciosDePropiedades = (length.filter unPrecio) unosPreciosDePropiedades 

precioDeLasPropiedades :: Jugador -> [Int]
precioDeLasPropiedades unJugador = map precioDeLaPropiedad $ propiedadesCompradas unJugador

--SUBASTAR

subastar :: Propiedad->Accion
subastar unaPropiedad unJugador  | esTactica "Accionista" unJugador  || esTactica "Oferente Singular" unJugador =
                                    ganaLaPropiedad unaPropiedad unJugador
                                | otherwise = unJugador

{- Version2 SUBASTAR
subastar :: String->Propiedad->Accion
subastar "Accionista" unaPropiedad unJugador  = ganaLaPropiedad unaPropiedad unJugador
subastar "Oferente singular" unaPropiedad unJugador  = ganaLaPropiedad unaPropiedad unJugador                     
subastar _ unaPropiedad unJugador  = unJugador                        
                    

-}
ganaLaPropiedad :: Propiedad->Jugador -> Jugador
ganaLaPropiedad unaPropiedad unJugador = (modificarDinero(subtract $ precioDeLaPropiedad unaPropiedad  ) . sumarPropiedad unaPropiedad)unJugador

precioDeLaPropiedad :: Propiedad -> Int
precioDeLaPropiedad unaPropiedad = snd unaPropiedad

sumarPropiedad :: Propiedad-> Jugador -> Jugador
sumarPropiedad unaPropiedad unJugador= unJugador {propiedadesCompradas = unaPropiedad : propiedadesCompradas unJugador}