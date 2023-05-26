-- Função auxiliar para calcular a pontuação de um frame
pontuacaoFrame :: [Int] -> Int -> Int --Declarando a função
pontuacaoFrame jogadas frame -- Definindo a função a partir daqui
  | ehStrike jogadas frame = 10 + bonusStrike jogadas frame
  | ehSpare jogadas frame = 10 + bonusSpare jogadas frame
  | otherwise = soma jogadas frame

-- Verifica se o frame é um strike
ehStrike :: [Int] -> Int -> Bool
ehStrike jogadas frame = jogadas !! frame == 10

-- Verifica se o frame é um spare
ehSpare :: [Int] -> Int -> Bool
ehSpare jogadas frame = soma jogadas frame == 10

-- Calcula a soma das duas jogadas de um frame
soma :: [Int] -> Int -> Int
soma jogadas frame = jogadas !! frame + jogadas !! (frame + 1)

-- Calcula o bônus de um strike
bonusStrike :: [Int] -> Int -> Int
bonusStrike jogadas frame
  | frame == 9 = jogadas !! 10 + jogadas !! 11
  | ehStrike jogadas frame = 10 + jogadas !! (frame + 1) + bonusStrike jogadas (frame + 1)
  | otherwise = soma jogadas (frame + 1)

-- Calcula o bônus de um spare
bonusSpare :: [Int] -> Int -> Int
bonusSpare jogadas frame
  | frame == 9 = jogadas !! 10 + jogadas !! 11
  | otherwise = jogadas !! (frame + 2)

-- Calcula a pontuação final
pontuacaoFinal :: [Int] -> Int --Recebe um [Int] (input da função) e retorna um Int (output da função)
pontuacaoFinal jogadas = sum [pontuacaoFrame jogadas frame | frame <- [0 .. 9]]

-- Função principal para ler a sequência de pinos e imprimir a pontuação final
main :: IO ()
main = do
  putStrLn "Digite a sequência de pinos derrubados (use espaços para separar):"
  entrada <- getLine
  let pinos = map read (words entrada) :: [Int]
  let pontuacao = pontuacaoFinal pinos
  putStrLn ("Sequência de pinos derrubados: " ++ show pinos)
  putStrLn ("Pontuação final: " ++ show pontuacao)


-- sum: soma todos os elementos de uma lista
-- show: imprime itens como um String