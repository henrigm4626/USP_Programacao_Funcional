--Participantes do grupo:
--Giancarlo Malfate Caprino 12725025
--Giovanna Pedrino Belasco 12543287
--Laura Fernandes Camargos 13692334


-- Funcao principal para calcular a pontuacao total do jogo de boliche
pontuacaoTotal :: [Int] -> Int -> Int -> Int
pontuacaoTotal [] _ pontuacao = pontuacao  -- Todas as jogadas foram contabilizadas, retorna a pontuacao total
pontuacaoTotal (x:y:z:resto) rodada pontuacao
    | rodada > 10 = pontuacao  -- Retorna a pontuacao total
    | x == 10 = pontuacaoTotal (y:z:resto) (rodada + 1) (pontuacao + x + y + z)  -- Strike
    | x + y == 10 = pontuacaoTotal (z:resto) (rodada + 1) (pontuacao + x + y + z)  -- Spare
    | otherwise = pontuacaoTotal (z:resto) (rodada + 1) (pontuacao + x + y)  -- Jogadas padrao
pontuacaoTotal [x] 10 pontuacao = pontuacao + x  -- Última jogada isolada
pontuacaoTotal [x, y] 10 pontuacao = pontuacao + x + y  -- Última jogada com dois pinos derrubados
pontuacaoTotal _ _ pontuacao = pontuacao  -- Se a lista tiver incompleta, retorna a pontuacao atual



-- Funcao para exibir o placar do jogo de boliche
mostraJogadas :: [Int] -> String
mostraJogadas [x,y] = show x ++ " " ++ show y ++ " |"  -- Dois pinos derrubados
mostraJogadas [x,y,z]
  | x == 10 && y+z == 10 = "X " ++ show y ++ " / |"  -- Strike seguido de spare
  | x+y == 10 && z == 10 = show x ++ " / X |"  -- Spare seguido de strike
  | x+y == 10 = show x ++ " / " ++ show z ++ " |"  -- Spare
  | x+y+z == 30 = "X X X |"  -- Tres strikes
  | otherwise = show x ++ " " ++ show y ++ " " ++ show z ++ "|"  -- Jogadas padrao
mostraJogadas (x:y:z:resto)
  | x == 10 = "X _ | " ++ mostraJogadas (y:z:resto)  -- Strike com jogadas extras
  | x+y == 10 = show x ++ " / | " ++ mostraJogadas (z:resto)  -- Spare com jogada extra
  | otherwise = show x ++ " " ++ show y ++ " | " ++ mostraJogadas (z:resto)  -- Jogadas padrao
mostraJogadas _ = ""  -- Caso base, nenhuma jogada restante



-- Funcao principal do programa
main :: IO ()
main = do
    entrada <- getLine
    let jogadas = map read $ words entrada :: [Int]
    let resultado = pontuacaoTotal jogadas 1 0
    putStrLn $ mostraJogadas jogadas ++ " " ++ show resultado