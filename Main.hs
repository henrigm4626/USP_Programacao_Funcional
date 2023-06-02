totalPontos :: [Int] -> Int -> Int -> Int
totalPontos [] _ pontuacao = pontuacao
totalPontos (x : y : z : resto) frame pontuacao
  | frame > 10 = pontuacao
  | ehStrike x = totalPontos (y : z : resto) (frame + 1) (pontuacao + x + y + z)
  | ehSpare x y = totalPontos (z : resto) (frame + 1) (pontuacao + x + y + z)
  | otherwise = totalPontos (z : resto) (frame + 1) (pontuacao + x + y)
totalPontos _ _ pontuacao = pontuacao

-- Verifica se o frame é um strike
ehStrike :: Int -> Bool
ehStrike x = x == 10

-- Verifica se o frame é um spare
ehSpare :: Int -> Int -> Bool
ehSpare x y = x + y == 10

-- Calcula a pontuação final
pontuacaoFinal :: [Int] -> Int
pontuacaoFinal jogadas = totalPontos jogadas 1 0


imprimeFrame :: [Int] -> String
imprimeFrame [x, y] -- Frames com apenas 2 jogadas
  | x + y == 10 = show x ++ " / |"
  | otherwise = show x ++ " " ++ show y ++ " |"
imprimeFrame [x, y, z] -- Ultimo frame, com 3 jogadas
  | x + y == 10 = show x ++ " / " ++ show z ++ " |"
  | x == 10 && y + z == 10 = "X " ++ show y ++ " / |"
  | x + y == 10 && z == 10 = show x ++ " / X |"
  | x + y + z == 30 = "X X X |"
  | otherwise = show x ++ " " ++ show y ++ " " ++ show z ++ "|"
imprimeFrame (x : y : z : resto)
  | x == 10 = "X _ | " ++ imprimeFrame (y : z : resto)
  | x + y == 10 = show x ++ " / | " ++ imprimeFrame (z : resto)
  | otherwise = show x ++ " " ++ show y ++ " | " ++ imprimeFrame (z : resto)
imprimeFrame _ = ""


-- Função principal para ler a sequência de pinos e imprimir a pontuação final
main :: IO ()
main = do
  putStrLn "Digite a sequência de pinos derrubados (use espaços para separar):"
  entrada <- getLine
  let pinos = map read (words entrada) :: [Int]
  let pontos = pontuacaoFinal pinos
  putStrLn $ imprimeFrame pinos ++ " " ++ show pontos