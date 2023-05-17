module Main where

-- Função auxiliar para calcular a pontuação de um frame
pontuacaoFrame :: [Int] -> Int -> Int
pontuacaoFrame jogadas frame
    | eStrike jogadas frame = 10 + bonusStrike jogadas frame
    | eSpare jogadas frame = 10 + bonusSpare jogadas frame
    | otherwise = soma jogadas frame

-- Verifica se o frame é um strike
eStrike :: [Int] -> Int -> Bool
eStrike jogadas frame = jogadas !! frame == 10

-- Verifica se o frame é um spare
eSpare :: [Int] -> Int -> Bool
eSpare jogadas frame = soma jogadas frame == 10

-- Calcula a soma das duas jogadas de um frame
soma :: [Int] -> Int -> Int
soma jogadas frame = jogadas !! frame + jogadas !! (frame + 1)

-- Calcula o bônus de um strike
bonusStrike :: [Int] -> Int -> Int
bonusStrike jogadas frame
    | frame == 9 = jogadas !! 10 + jogadas !! 11
    | eStrike jogadas (frame + 1) = 10 + jogadas !! (frame + 2)
    | otherwise = soma jogadas (frame + 1)

-- Calcula o bônus de um spare
bonusSpare :: [Int] -> Int -> Int
bonusSpare jogadas frame = jogadas !! (frame + 2)

-- Calcula a pontuação final
pontuacaoFinal :: [Int] -> Int
pontuacaoFinal jogadas = pontuacaoFrame jogadas 0 + pontuacaoFrame jogadas 2 + pontuacaoFrame jogadas 4 + pontuacaoFrame jogadas 6 + pontuacaoFrame jogadas 8 + jogadas !! 10 + jogadas !! 11

-- Função principal para ler a sequência de pinos e imprimir a pontuação final
main :: IO ()
main = do
    putStrLn "Digite a sequência de pinos derrubados (use espaços para separar):"
    entrada <- getLine
    let pinos = map read (words entrada) :: [Int]
    let pontuacao = pontuacaoFinal pinos
    putStrLn ("Sequência de pinos derrubados: " ++ show pinos)
    putStrLn ("Pontuação final: " ++ show pontuacao)
