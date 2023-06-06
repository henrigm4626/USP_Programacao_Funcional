-- Calcula o total de pontos de um frame
totalPontos :: [Int] -> Int -> Int -> Int
totalPontos [] _ pontos_frame = pontos_frame
totalPontos (x : y : z : pontos_aux) frame pontos_frame
  | frame > 10 = pontos_frame
  | ehStrike x = totalPontos (y : z : pontos_aux) (frame + 1) (pontos_frame + x + y + z)
  | ehSpare x y = totalPontos (z : pontos_aux) (frame + 1) (pontos_frame + x + y + z)
  | otherwise = totalPontos (z : pontos_aux) (frame + 1) (pontos_frame + x + y)
totalPontos [x] 10 pontos_frame = pontos_frame + x
totalPontos [x, y] 10 pontos_frame = pontos_frame + x + y
totalPontos _ _ pontos_frame = pontos_frame

-- Verifica se o frame tem um strike
ehStrike :: Int -> Bool
ehStrike x = x == 10

-- Verifica se o frame tem um spare
ehSpare :: Int -> Int -> Bool
ehSpare x y = x + y == 10

-- Calcula o placar final a partir da quantidade de lances
placarFinal :: [Int] -> Int
placarFinal lances = totalPontos lances 1 0

-- Imprime o frame de acordo com o que foi pontuado
imprimeFrame :: [Int] -> String
imprimeFrame [x, y] -- Frames padrão, com apenas 2 jogadas
  | x + y == 10 = show x ++ " / |"
  | otherwise = show x ++ " " ++ show y ++ " |"
imprimeFrame [x, y, z] -- Avaliando strikes e spares seguidos
  | x + y == 10 = show x ++ " / " ++ show z ++ " |"
  | x + y + z == 30 = "X X X |"
  | x + y == 10 && z == 10 = show x ++ " / X |"
  | x == 10 && y + z == 10 = "X " ++ show y ++ " / |"
  | otherwise = show x ++ " " ++ show y ++ " " ++ show z ++ "|" -- Caso base
imprimeFrame (x : y : z : pontos_aux) -- Considerando a jogada bônus
  | x == 10 = "X _ | " ++ imprimeFrame (y : z : pontos_aux)
  | x + y == 10 = show x ++ " / | " ++ imprimeFrame (z : pontos_aux)
  | otherwise = show x ++ " " ++ show y ++ " | " ++ imprimeFrame (z : pontos_aux)
imprimeFrame _ = ""

-- Função principal para ler a sequência de pinos e imprimir o placar final
main :: IO ()
main = do
  --putStrLn "Digite a sequência de pinos derrubados (use espaços para separar):"
  input <- getLine
  let lances = map read (words input) :: [Int]
  putStrLn $ imprimeFrame lances ++ " " ++ show (placarFinal lances)