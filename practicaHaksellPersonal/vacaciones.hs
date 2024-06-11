data Turista =UnTurista {nivelEstres :: Int ,
                         nivelCansancion :: Int ,
                          viajaSolo ::Bool,
                           idiomas :: [String]} deriving Show
type Excursion = Turista -> Turista

irAlaPlaya :: Excursion
irAlaPlaya unTurista | viajaSolo unTurista = modificarCansancio (subtract 5) unTurista
                     | otherwise = modificarEstres (subtract 1) unTurista


modificarCansancio :: (Int -> Int) -> Turista -> Turista
modificarCansancio unaFuncion unTurista = unTurista{nivelCansancion = unaFuncion.nivelCansancion $ unTurista}


modificarEstres :: (Int -> Int) -> Turista -> Turista
modificarEstres unaFuncion unTurista = unTurista{nivelEstres = unaFuncion.nivelEstres $ unTurista}

--
apreciarPaisaje :: String -> Excursion
apreciarPaisaje unPaisaje unTurista = modificarEstres (subtract.length $ unPaisaje ) unTurista
--
salirAHalarIdioma :: String -> Excursion
salirAHalarIdioma unIdioma unTurista = modificarIdiomas (unIdioma:) . modificarViaje (const True) $ unTurista

modificarIdiomas :: ([String] -> [String]) -> Turista -> Turista
modificarIdiomas unaFuncion unTurista = unTurista{idiomas = unaFuncion.idiomas $ unTurista}

modificarViaje :: (Bool->Bool) -> Turista -> Turista
modificarViaje unaFuncion unTurista = unTurista{viajaSolo = unaFuncion.viajaSolo $ unTurista}
--
caminar :: Int -> Excursion
caminar unosMinutos unTurista = modificarCansancio (+ intensidadDeCaminata unosMinutos) . modificarEstres (subtract.intensidadDeCaminata $ unosMinutos) $ unTurista

intensidadDeCaminata :: Int -> Int
intensidadDeCaminata unosMinutos = div unosMinutos 4
--
paseoEnBarco :: String -> Excursion
paseoEnBarco "Fuerte" unTurista = modificarEstres (+5).modificarCansancio (+10) $ unTurista
paseoEnBarco "Tranquila" unTurista = salirAHalarIdioma "Aleman".apreciarPaisaje "Vista al Mar" .caminar 10 $ unTurista
paseoEnBarco _ unTurista = unTurista

sistemaExcursion :: Excursion -> Turista-> Turista
sistemaExcursion  unaExcursion unTurista = modificarEstres ((*9).(`div` 10) ) . unaExcursion $ unTurista 

--

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun unIndice unTurista unaExcursion = deltaSegun unIndice unTurista.sistemaExcursion unaExcursion $ unTurista

ana :: Turista
ana = UnTurista 21 0 False ["Español"]

esExcursionEducativa :: Turista -> Excursion ->Bool
esExcursionEducativa unTurista unaExcursion = 0 > deltaExcursionSegun (length.idiomas) unTurista unaExcursion

excursionesDesestresantes :: Turista -> [Excursion] ->[Excursion]
excursionesDesestresantes unTurista unasExcursiones = filter (desEstresaA unTurista ) unasExcursiones

desEstresaA :: Turista -> Excursion -> Bool
desEstresaA unTurista unaExcursion = 3 >= deltaExcursionSegun nivelEstres unTurista unaExcursion

--
type Tour = [Excursion]

completo :: Tour
completo = [salirAHalarIdioma "Melquemiano",caminar 40,apreciarPaisaje "Cascada",caminar 20]

ladoB :: Excursion -> Tour
ladoB unaExcursion = [caminar 120 ,unaExcursion,apreciarPaisaje "Costa",paseoEnBarco "Tranquila"]

islaVecina :: String -> Tour
islaVecina "Fuerte" = [paseoEnBarco "Fuerte",apreciarPaisaje "Lago",paseoEnBarco "Fuerte"] 
islaVecina cualquierMarea = [paseoEnBarco cualquierMarea,irAlaPlaya,paseoEnBarco cualquierMarea] 
--
hacerUnTour :: Turista -> Tour -> Turista
hacerUnTour unTurista unTour = hacerExcursiones unTour .modificarEstres (+ length unTour ) $ unTurista

hacerExcursiones :: [Excursion] -> Turista -> Turista
hacerExcursiones unasExcursiones unTurista = foldr ($) unTurista unasExcursiones
--
hayTourConveniente :: [Tour] -> Turista -> Bool
hayTourConveniente unosTours unTurista = any (esConveniente unTurista) unosTours
 
esConveniente :: Turista -> Tour -> Bool
esConveniente unTurista unTour = any (dejaAcompañadoYdesestresa unTurista) unTour  

dejaAcompañadoYdesestresa :: Turista -> Excursion -> Bool
dejaAcompañadoYdesestresa unTurista unaExcursion = desEstresaA unTurista unaExcursion && dejaAcompañadoA unTurista unaExcursion

dejaAcompañadoA :: Turista -> Excursion ->Bool
dejaAcompañadoA unTurista unaExcursion = not.viajaSolo.unaExcursion $ unTurista
--

efectividadDelTour :: Tour -> [Turista] -> Int
efectividadDelTour unTour unosTuristas = sum . map (espiritualidad unTour) . filter (`esConveniente` unTour) $ unosTuristas

espiritualidad :: Tour -> Turista -> Int
espiritualidad unTour unTurista =  perdidaDe nivelCansancion unTurista unTour  + perdidaDe nivelEstres unTurista unTour

perdidaDe :: (Turista -> Int) -> Turista->Tour -> Int
perdidaDe unIndice unTurista unTour = deltaSegun unIndice unTurista (hacerUnTour unTurista unTour)

--
visitaAPlayasInfinitas :: Tour
visitaAPlayasInfinitas = repeat irAlaPlaya

