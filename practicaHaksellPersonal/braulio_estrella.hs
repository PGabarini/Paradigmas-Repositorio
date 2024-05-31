

data Personaje = UnPersonaje {nombre :: String , poderBasico :: PoderBasico,
                    superPoder :: SuperPoder, super :: Bool, cantidadDeVida :: Int}

type PoderBasico = Personaje -> Personaje
type SuperPoder = Personaje -> Personaje
type TipoDeTuercas = String
type RadioDeGranada = Int

type BrawlersEnPartida = [Personaje]

espina :: Personaje
espina = UnPersonaje "Espina" bolaDeEspinas (granadaDeEspinas 5) True 4800

pamela :: Personaje
pamela = UnPersonaje "Pamela" (lluviaDeTuercas "Sanadora")  torretaCurativa False 9600

lluviaDeTuercas :: TipoDeTuercas->PoderBasico
lluviaDeTuercas "Sanadora" unPersonaje = modificarVida (+800) unPersonaje
lluviaDeTuercas "Dañina" unPersonaje = modificarVida (`div` 2) unPersonaje
lluviaDeTuercas _ unPersonaje = unPersonaje

bolaDeEspinas :: PoderBasico
bolaDeEspinas unPersonaje = modificarVida (max 0 . subtract 1000) unPersonaje



granadaDeEspinas :: RadioDeGranada -> SuperPoder
granadaDeEspinas radioGranada unPersonaje | radioGranada<3 && estaEnLasUltimas unPersonaje =
                                         (modificarNombre "espinas estuvo aqui".modificarSuper False .modificarVida (min 0 )) unPersonaje
                                         | radioGranada<3 = modificarNombre "espinas estuvo aqui" unPersonaje
                                        | otherwise = bolaDeEspinas unPersonaje

torretaCurativa :: SuperPoder
torretaCurativa unPersonaje = (modificarSuper True .modificarVida (*2)) unPersonaje

modificarSuper :: Bool -> Personaje -> Personaje
modificarSuper booleano unPersonaje = unPersonaje{super = booleano}

modificarNombre :: String -> Personaje -> Personaje
modificarNombre agregado unPersonaje = unPersonaje {nombre= agregado ++ nombre unPersonaje}

modificarVida :: (Int -> Int) -> Personaje -> Personaje
modificarVida unaFuncion unPersonaje = unPersonaje { cantidadDeVida = (unaFuncion.cantidadDeVida) unPersonaje }

atacarConElPoderEspecial :: Personaje -> Personaje -> Personaje
atacarConElPoderEspecial personajeAtacante personajeAfectado | super personajeAtacante =
                                                             (poderBasico personajeAtacante . superPoder personajeAtacante) personajeAfectado
                                                            |otherwise = personajeAfectado

quiénesEstanEnLasUltimas :: BrawlersEnPartida -> [String]
quiénesEstanEnLasUltimas unosBrawlers = (map nombreBrawler . filter estaEnLasUltimas) unosBrawlers

estaEnLasUltimas :: Personaje -> Bool
estaEnLasUltimas unPersonaje = ((<800).cantidadDeVida) unPersonaje

nombreBrawler :: Personaje -> String
nombreBrawler = nombre