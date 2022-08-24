osQuatroSaoIguais :: Int -> Int -> Int -> Int -> Bool
osQuatroSaoIguais a b c d = 
  (a == b) && (b == c) && (c == d)

quantosSaoIguais :: Int -> Int -> Int -> Int 
quantosSaoIguais a b c
    | (a == b) && (b == c) = 3
    | (a == b) || (a == c) || (b == c) = 2
    | otherwise = 0

todosDiferentes :: Int -> Int -> Int -> Bool
todosDiferentes a b c = (a /= b) && (a /= c) && (b /= c) 

quantosSaoIguais2 :: Int -> Int -> Int -> Int
quantosSaoIguais2 a b c 
    |todosIguais a b c = 3
    |todosDiferentes a b c = 0
    |otherwise = 2

elevadoDois :: Int -> Int 
elevadoDois a = a ^ 2

elevadoQuatro :: Int -> Int
elevadoQuatro a = elevadoDois a * elevadoDois x

vendas :: Int -> Int
vendas s
    | (s == 0) = 10
    | (s == 1) = 20
    | (s == 2) = 30
    | (s == 3) = 15
    | (s == 4) = 5
    | otherwise = 50

vendaTotal :: Int -> Int
vendaTotal x
    |(x == 0) = vendas 0
    |otherwise = vendas x + vendaTotal(x-1)
