-- Função que recebe um inteiro e uma lista e multiplica todos os elementos dessa lista pelo inteiro
multLista :: Int -> [Int] -> [Int]
multLista a [] = []
multLista a (x:xs) = a*x : multLista a xs

-- Função que recebe um inteiro e uma lista, e devolve um booleano dizendo se o inteiro se encontra na lista
elemento :: Int -> [Int] -> Bool
elemento a [] = False
elemento a (x:xs)
    | a == x = True
    | otherwise = elemento a xs


-- Função que recebe um inteiro e uma lista, e diz quantas vezes o inteiro ocorre dentro da lista
conta :: Int -> [Int] -> Int
conta a [] = 0
conta a (x:xs)
    | a == x = 1 + (conta a xs)
    | otherwise = conta a xs


-- Função que recebe um inteiro e uma lista e conta quantos elementos da lista são maiores que o inteiro passado como argumento
contaMaiores :: Int -> [Int]-> Int
contaMaiores a [] = 0
contaMaiores a (x:xs)
    | a < x = 1 + (contaMaiores a xs)
    | otherwise = contaMaiores a xs


-- Função que recebe um inteiro e uma lista e devolve uma lista contendo somente os valores que estavam na lista inicial e que são maiores do que o inteiro passado como argumento
maiores :: Int -> [Int] -> [Int]
maiores a [] = []
maiores a (x:xs)
    | a < x = (x:[]) ++ (maiores a xs)
    | otherwise = maiores a xs


-- Função que recebe um inteiro m e um inteiro n e devolve uma lista contendo m vezes n
geraLista :: Int -> Int -> [Int]
geraLista 0 n = []
geraLista m n = n:[] ++ geraLista (m-1) n

-- Função que recebe um inteiro, uma lista e adiciona o elemento no fim da lista
addFim :: Int -> [Int] -> [Int]
addFim y [] = y : []
addFim y (xs) = (xs) ++ (y : [])

-- Função que recebe uma lista e inverte ela
inverteLista :: [Int] -> [Int] 
inverteLista [] = []
inverteLista (x:xs) = inverteLista xs ++ [x]