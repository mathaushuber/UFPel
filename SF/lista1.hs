palindromo :: String -> Bool
palindromo x = reverse x == x

verificaTriangulo :: Int -> Int -> Int -> Bool
verificaTriangulo a b c =
  a + b > c &&
  a + c > b &&
  b + c > a

signal :: Int -> Int
signal x
  | x > 0 = 1
  | x < 0 = -1
  | otherwise = 0

menorTres :: Int -> Int -> Int -> Int
menorTres a b c
  | (a < b) && (a < c) = a
  | (b < c) && (b < a) = b 
  | (c < a) && (c < b) = c

potencia :: Int -> Int -> Int
potencia x n  |(n<0) = error "Expoente negativo."
              |(n==0) = 1
              |(n==1) = x
potencia x n = x * potencia x (n-1)

