pontuacaoTotalAux :: [Int] -> Int -> Int -> Int
pontuacaoTotalAux [] _ pontuacao = pontuacao
pontuacaoTotalAux (x:y:z:resto) rodada pontuacao
    | rodada > 10 = pontuacao
    | ehStrike x = pontuacaoTotalAux (y:z:resto) (rodada + 1) (pontuacao + x + y + z)
    | ehSpare x y = pontuacaoTotalAux (z:resto) (rodada + 1) (pontuacao + x + y + z)
    | otherwise = pontuacaoTotalAux (z:resto) (rodada + 1) (pontuacao + x + y)
pontuacaoTotalAux _ _ pontuacao = pontuacao

-- Verifica se o frame é um strike
ehStrike :: Int -> Bool
ehStrike x = x == 10

-- Verifica se o frame é um spare
ehSpare :: Int -> Int -> Bool
ehSpare x y = x + y == 10

-- Calcula a pontuação final
pontuacaoFinal :: [Int] -> Int
pontuacaoFinal jogadas = pontuacaoTotalAux jogadas 1 0

-- Função principal para ler a sequência de pinos e imprimir a pontuação final
main :: IO ()
main = do
  putStrLn "Digite a sequência de pinos derrubados (use espaços para separar):"
  entrada <- getLine
  let pinos = map read (words entrada) :: [Int]
  let pontos = pontuacaoFinal pinos
  putStrLn ("Sequência de pinos derrubados: " ++ show pinos)
  putStrLn $ "Pontuação final do jogo: " ++ show pontos

-- show: imprime itens como um String
