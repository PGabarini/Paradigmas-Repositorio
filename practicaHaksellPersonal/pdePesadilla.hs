data Persona = UnaPersona { nombre::String,
                            recuerdos :: [Recuerdo]}
type Recuerdo = String

suki:: Persona
suki = UnaPersona "Susana Kitimporta" ["abuelita", "escuela primaria", "examen aprobado","novio"]
{-}
pesadillaDeMovimiento :: Int -> Int -> Persona ->Persona
pesadillaDeMovimiento posicionAmover posicionFinal unaPersona = modificarRecuerdos () unaPersona

modificarRecuerdos :: ([Recuerdo]->[Recuerdo]) -> Persona ->Persona
modificarRecuerdos unaFuncion unaPersona = unaPersona{recuerdos= unaFuncion.recuedos $ unaPersona}

-}