data Chico = UnChico {nombre :: String,
                     edad ::Int,
                     habilidades :: [Habilidad],
                     deseos :: [Deseo]}

type Habilidad = String

type Deseo = Chico ->Chico

--
aprenderHabilidades :: [Habilidad] -> Chico -> Chico 
aprenderHabilidades unasHabiliades unChico = modificarHabilidades (unasHabiliades++) unChico

modificarHabilidades :: ([Habilidad]->[Habilidad]) -> Chico ->Chico
modificarHabilidades unaFuncion unChico = unChico{habilidades= unaFuncion.habilidades $ unChico}
--
serGrosoEnElNeedForSpeed:: Chico -> Chico
serGrosoEnElNeedForSpeed unChico = modificarHabilidades (habilidadesDeNedForSpeed++) unChico

habilidadesDeNedForSpeed :: [Habilidad]
habilidadesDeNedForSpeed = map (("Jugar Need For Speed" ++) . show ) ["1.."]
--
serMayor :: Deseo
serMayor unChico = modificarEdad (const 18) unChico 

modificarEdad :: (Int->Int) -> Chico ->Chico
modificarEdad unaFuncion unChico = unChico{edad= unaFuncion.edad $ unChico}
--

wanda :: Chico -> Chico
wanda unChico = madurar.aplicarDeseo (head.deseos$ unChico) $ unChico

madurar :: Deseo
madurar unChico = modificarEdad (+1) unChico

aplicarDeseo :: Deseo -> Chico -> Chico
aplicarDeseo unDeseo unChico = unDeseo unChico
--

cosmo :: Chico -> Chico
cosmo unChico = modificarEdad (div 2) unChico

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldr ($) unChico (deseos unChico)
--

tieneHabilidad :: Habilidad -> Chico -> Bool
tieneHabilidad unaHabilidad unChico = elem unaHabilidad (habilidades unChico)

esSuperMaduro :: Chico -> Bool
esSuperMaduro unChico = esMayorDeEdad unChico && tieneHabilidad "Manejar" unChico

esMayorDeEdad :: Chico -> Bool
esMayorDeEdad unChico = (>17).edad $ unChico
--

data Chica = UnaChica {nombreChica :: String , condicionDeBaile :: CondicionDeBaile}

type CondicionDeBaile = Chico -> Bool

trixie :: Chica
trixie = UnaChica "Trixie Tang" noEsTimmy

noEsTimmy :: Chico -> Bool
noEsTimmy (UnChico nombre _ _ _) = not (nombre == "Timmy")

vicky :: Chica
vicky = UnaChica "Vicky" (tieneHabilidad "ser un supermodelo noruego")
--

quienConquistaUnaChica :: Chica -> [Chico] -> Chico
quienConquistaUnaChica _ [soloUnChico] = soloUnChico
quienConquistaUnaChica unaChica (primerChico : demasChicos) | (condicionDeBaile unaChica) primerChico = primerChico                                                  
                                                            |sigueHabiendoPretendientes demasChicos  = quienConquistaUnaChica unaChica demasChicos
                                                            |otherwise = last demasChicos
quienConquistaUnaChica _ u = head u

sigueHabiendoPretendientes :: [Chico] -> Bool
sigueHabiendoPretendientes unosPretendientes = not.null $ unosPretendientes
--
inFractoresDeDaRules :: [Chico] -> [Chico]
inFractoresDeDaRules unosChicos = filter tieneDeseosProhibidos unosChicos

tieneDeseosProhibidos :: Chico -> Bool
tieneDeseosProhibidos unChico = any esHabilidadProhibida (take 5.habilidades.muffinMagico $ unChico)

esHabilidadProhibida :: Habilidad -> Bool
esHabilidadProhibida unaHabilidad  = elem unaHabilidad ["Enamorar","Matar","Dominar El Mundo"]