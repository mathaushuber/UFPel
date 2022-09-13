-- Definição das árvore sintática para representação dos programas:

data E = Num Int
      |Var String
      |Soma E E
      |Sub E E
      |Mult E E
   deriving(Eq,Show)

data B = TRUE
      | FALSE
      | Not B
      | And B B
      | Or  B B
      | Leq E E    -- menor ou igual
      | Igual E E  -- verifica se duas expressões aritméticas são iguais
   deriving(Eq,Show)

data C = While B C
    | DoWhile C B  -- Do C while B
    | Repeat C B  -- repeat C until B
    | If B C C
    | Seq C C
    | Atrib E E
    | Skip
   deriving(Eq,Show)                


-----------------------------------------------------
-----
----- As próximas funções, servem para manipular a memória (sigma)
-----
------------------------------------------------


--- A próxima linha de código diz que o tipo memória é equivalente a uma lista de tuplas, onde o
--- primeiro elemento da tupla é uma String (nome da variável) e o segundo um Inteiro
--- (conteúdo da variável):


type Memoria = [(String,Int)]

exSigma :: Memoria
exSigma = [ ("x", 10), ("temp",0), ("y",0)]


--- A função procuraVar recebe uma memória, o nome de uma variável e retorna o conteúdo
--- dessa variável na memória. Exemplo:
---
--- *Main> procuraVar exSigma "x"
--- 10


procuraVar :: Memoria -> String -> Int
procuraVar [] s = error ("Variavel " ++ s ++ " nao definida no estado")
procuraVar ((s,i):xs) v
  | s == v     = i
  | otherwise  = procuraVar xs v


--- A função mudaVar, recebe uma memória, o nome de uma variável e um novo conteúdo para essa
--- variável e devolve uma nova memória modificada com a varíável contendo o novo conteúdo. A
--- chamada
---
--- *Main> mudaVar exSigma "temp" 20
--- [("x",10),("temp",20),("y",0)]
---
---
--- essa chamada é equivalente a operação exSigma[temp->20]

mudaVar :: Memoria -> String -> Int -> Memoria
mudaVar [] v n = error ("Variavel " ++ v ++ " nao definida no estado")
mudaVar ((s,i):xs) v n
  | s == v     = ((s,n):xs)
  | otherwise  = (s,i): mudaVar xs v n


-------------------------------------
---
--- Completar os casos comentados das seguintes funções:
---
---------------------------------




ebigStep :: (E,Memoria) -> Int
ebigStep (Var x,s) = procuraVar s x
ebigStep (Num n,s) = n
ebigStep (Soma e1 e2,s)  = ebigStep (e1,s) + ebigStep (e2,s)
ebigStep (Sub e1 e2,s)  =  ebigStep (e1,s) - ebigStep (e2,s) --completado
ebigStep (Mult e1 e2,s)  = ebigStep (e1,s) * ebigStep (e2,s) --completado


bbigStep :: (B,Memoria) -> Bool
bbigStep (TRUE,s)  = True
bbigStep (FALSE,s) = False
bbigStep (Not b,s) 
   | bbigStep (b,s) == True     = False
   | otherwise                  = True 
bbigStep (And b1 b2,s )  = let	(n1) = bbigStep(b1, s)
				(n2) = bbigStep(b2, s)
				in(n1 && n2, s)
bbigStep (Or b1 b2,s )  = let	(n1) = bbigStep(b1, s)
				(n2) = bbigStep(b2, s)
				in(n1 || n2, s)
bbigStep (Leq e1 e2,s) = let 	(n1) = abigStep(e1, s)
				(n2) = abigStep (e2, s)
				in (n1<=n2,s)
bbigStep (Igual e1 e2,s) = let	(b1) = abigStep(e1, s)
				(b2) = abigStep(e2, s)
				in(b1==b2, s)

cbigStep :: (C,Memoria) -> (C,Memoria)
cbigStep (Skip,s) = (Skip,s)
cbigStep (If b c1 c2,s) = case bbigStep(b, s) of
			(True, _) -> cbigStep(c1,s)
			(False,_) -> cbigStep(c2, s)
cbigStep (Seq c1 c2,s) = let	(com1, s1) = cbigStep (c1, s)
 				(com2, s2) = cbigStep(c2, s1)
				in (com2, s2) 
cbigStep (Atrib (Var x) e,s) = let	(n1,s1) = ebigStep(e,s)
					(s2)	= (mudaVar s1 x n1)
					in (cbigStep(Skip, s2)) 
cbigStep (While b c, s) = case bbigStep(b,s) of
			(True, _) -> cbigStep(Seq (c) (While b c), s)
			(False, _) -> cbigStep(Skip, s)
cbigStep (DoWhile c b,s)  = let (c1, s1) = cbigStep(c,s)
			in(case bbigStep(b,s1) of
			(True, _) -> cbigStep(DoWhile c b, s1)
			(False, _) -> cbigStep(Skip, s1))
cbigStep (Repeat c b,s)= let	(c1, s1) = cbigStep(c,s)
				in(case bbigStep(b, s1) of
				(True, _) -> cbigStep(Skip, s1)
				(False, _) -> cbigStep(Repeat c b, s1))


--------------------------------------
---
--- Exemplos de programas para teste
---
--- O ALUNO DEVE IMPLEMENTAR DOIS EXEMPLOS DE PROGRAMA, UM USANDO O IF E OUTRO USANDO O DO WHILE
-------------------------------------

exSigma2 :: Memoria
exSigma2 = [("x",3), ("y",0), ("z",0)]


---
--- O progExp1 é um programa que usa apenas a semântica das expressões aritméticas. Esse
--- programa já é possível rodar com a implementação que fornecida:

progExp1 :: E
progExp1 = Soma (Num 3) (Soma (Var "x") (Var "y"))

---
--- para rodar:
-- *Main> ebigStep (progExp1, exSigma)
-- 13
-- *Main> ebigStep (progExp1, exSigma2)
-- 6

--- Para rodar os próximos programas é necessário primeiro implementar as regras da semântica
---


---
--- Exemplos de expressões booleanas:


teste1 :: B
teste1 = (Leq (Soma (Num 3) (Num 3))  (Mult (Num 2) (Num 3)))

teste2 :: B
teste2 = (Leq (Soma (Var "x") (Num 3))  (Mult (Num 2) (Num 3)))

testeIg :: B
testeIg = Ig (Num 3) (Num 3)

testeAnd :: B
testeAnd = And TRUE (Not FALSE)

testeOr :: B
testeOr = Or (And TRUE TRUE) (Not TRUE)

testeIf :: C
testeIf = If (And TRUE (Not FALSE)) testeAtriZ testeAtri

testeSeq :: C
testeSeq = Seq testeAtri testeIf

testeAtri :: C
testeAtri = Atrib (Var "y") exemplo

testeAtriZ :: C
testeAtriZ = Atrib (Var "z") exemplo1


---
-- Exemplos de Programas Imperativos:

testec1 :: C
testec1 = (Seq (Seq (Atrib (Var "z") (Var "x")) (Atrib (Var "x") (Var "y"))) 
               (Atrib (Var "y") (Var "z")))

fatorial :: C
fatorial = (Seq (Atrib (Var "y") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "y") (Mult (Var "y") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))

testeRepeat :: C
testeRepeat = (Repeat ( Atrib (Var "x") (Som (Var "x") (Num 1)) ) (Ig (Var "x") (Var "y") ) )
--Resultado: (Skip,[("x",10),("y",10)])

testeDo :: C
testeDo = (DoWhile (Atrib (Var "x") (Mul (Var "x") (Num 2) ) )  (Leq (Var "x") (Num 64) ) )
-- Resultado: (Skip,[("x",128)])