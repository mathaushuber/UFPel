-- Definição das árvore sintática para representação dos programas:

data E = 	Num Int
        	|Var String
		|Soma E E
          |Sub E E
		|Mult E E
          deriving(Show)

data B =	TRUE
		| FALSE
          | Not B
		| And B B
          | Or  B B
          | Leq E E -- menor ou igual
		| Igual  E E -- verifica se duas expressões aritméticas são iguais
          deriving(Show)

data C =  While B C 
		| Repeat C B
		| DoWhile C B
		| For E E E C --ALÉM
		| Swap E E
    		| AtribDupla E E E E --ALÉM
		| If B C C
		| Seq C C
		| Atrib E E
          | Skip
	deriving(Show)


-----------------------------------------------------
-----
----- As próximas funções, servem para manipular a memória (sigma)
-----
------------------------------------------------


--- A próxima linha de código diz que o tipo memória é equivalente a uma lista de tuplas, onde o
--- primeiro elemento da tupla é uma String (nome da variável) e o segundo um Inteiro
--- (conteúdo da variável):


type Memoria = [(String,Int)]

procuraVar :: Memoria -> String -> Int
procuraVar [] s = error ("Variavel " ++ s ++ " nao definida na memoria")
procuraVar ((s,i):xs) v
  | s == v     = i
  | otherwise  = procuraVar xs v

mudaVar :: Memoria -> String -> Int -> Memoria
mudaVar [] v n = error ("Variavel " ++ v ++ " nao definida na memoria")
mudaVar ((s,i):xs) v n
  | s == v     = ((s,n):xs)
  | otherwise  = (s,i): mudaVar xs v n


-- DEFININDO AS MEMÓRIAS
exSigma :: Memoria
exSigma = [ ("x", 10), ("temp",0), ("y",0)]
exSigma2 :: Memoria
exSigma2 = [("x",3), ("temp",0), ("y",0)]
exSigma3 :: Memoria
exSigma3 = [("x",3), ("temp",5), ("y",0)]
exSigma4 :: Memoria
exSigma4 = [("x",5), ("temp",0), ("y",0)]
exSigma5 :: Memoria
exSigma5 = [("x",1), ("temp",0), ("y",0)]
exSigma6 :: Memoria
exSigma6 = [("x",1)]
exSigma7 :: Memoria
exSigma7 = [("x",1), ("temp",3)]
exSigma8 :: Memoria
exSigma8 = [("x",0), ("temp",10)]

--BIG STEP DE EXPRESSÕES ARITMÉTICAS
ebigStep :: (E,Memoria) -> (Int,Memoria)
ebigStep (Var x,s) = (procuraVar s x,s)
ebigStep (Num n,s) = (n,s)
ebigStep (Soma e1 e2,s)  = let	(n1,s1) = ebigStep (e1, s)
				(n2,s2) = ebigStep (e2, s)
					in (n1+n2,s)
ebigStep (Sub e1 e2,s)  = let 	(n1,s1) = ebigStep(e1, s)
				(n2,s2) = ebigStep (e2, s)
					in (n1-n2,s)
ebigStep (Mult e1 e2,s)  = let 	(n1,s1) = ebigStep(e1, s)
				(n2,s2) = ebigStep (e2, s)
					in (n1*n2,s)

-------------------------------------------------------------------------------------------------------------------------------------------------------
-- A ideia desenvolvida em aula é que a semantica big step de expressões aritméticas entrariam com uma expressão e a memória e retornariam um inteiro.
-- Implementei. através de let in, entrando com uma expressão e a memória, retorna um inteiro e a memória.
-- Esse código é mais simples, portanto se quiser usar essa implementação, simplesmente comentar o desenvolvimento acima!
-------------------------------------------------------------------------------------------------------------------------------------------------------
--ebigStep :: (E,Memoria) -> Int
--ebigStep (Var x,s) = procuraVar s x
--ebigStep (Num n,s) = n
--ebigStep (Soma e1 e2,s)  = ebigStep (e1,s) + ebigStep (e2,s)
--ebigStep (Sub e1 e2,s)  = ebigStep (e1,s) - ebigStep (e2,s)
--ebigStep (Mult e1 e2,s)  = ebigStep (e1,s) * ebigStep (e2,s)
-------------------------------------------------------------------------------------------------------------------------------------------------------

--BIG STEP DE BOLEANOS
bbigStep :: (B,Memoria) -> (Bool,Memoria)
bbigStep (TRUE,s)  	= (True,s)
bbigStep (FALSE,s) 	= (False,s)
bbigStep (Not b,s) = case bbigStep (b,s) of
		(True,_) -> (False, s)
                (False,_) -> (True, s)
bbigStep (Igual e1 e2,s ) = let	(b1, s1) = ebigStep(e1, s)
				(b2, s2) = ebigStep(e2, s)
					in(b1==b2, s)
bbigStep (And b1 b2,s )  = let	(n1, s1) = bbigStep(b1, s)
				(n2, s2) = bbigStep(b2, s)
					in(n1 && n2, s)
bbigStep (Or b1 b2,s )  = let	(n1, s1) = bbigStep(b1, s)
				(n2, s2) = bbigStep(b2, s)
					in(n1 || n2, s)
bbigStep (Leq e1 e2,s)	= let 	(n1,s1) = ebigStep(e1, s)
				(n2,s2) = ebigStep (e2, s)
					in (n1<=n2,s)

-------------------------------------------------------------------------------------------------------------------------------------------------------
-- A ideia desenvolvida em aula é que a semantica big step de expressões booleanas entrariam com um booleana e a memória e retornariam um booleano.
-- Implementei. através de let in, entrando com uma expressão e a memória, retorna um booleano e a memória.
-- Esse código é mais simples, portanto se quiser usar essa implementação, simplesmente comentar o desenvolvimento acima!
-------------------------------------------------------------------------------------------------------------------------------------------------------
--bbigStep :: (B,Memoria) -> Bool
--bbigStep (TRUE,s)  = True
--bbigStep (FALSE,s) = False
--bbigStep (Not b,s) 
-- | bbigStep (b,s) == True = False
-- | otherwise = True 
--bbigStep (And b1 b2,s )
-- | bbigStep (b1,s) == True = bbigStep (b2,s)
-- | otherwise = False 
--bbigStep (Or b1 b2,s )
-- | bbigStep (b1,s) == True = True
-- | otherwise = bbigStep (b2,s)
--bbigStep (Leq e1 e2,s)
-- | ebigStep (e1, s) <= ebigStep (e2, s) = True
-- | otherwise = False
--bbigStep (Igual e1 e2,s)
-- | ebigStep (e1, s) == ebigStep (e2, s) = True
-- | otherwise = False
-------------------------------------------------------------------------------------------------------------------------------------------------------

--BIG STEP DE CONDICIONAIS
cbigStep :: (C,Memoria) -> (C,Memoria)
cbigStep (Skip,s)      	= (Skip,s)
cbigStep (If b c1 c2,s) = case bbigStep(b, s) of
			(True, _) -> cbigStep(c1,s)
			(False,_) -> cbigStep(c2, s)
cbigStep (Seq c1 c2,s)  = let	(com1, s1) = cbigStep (c1, s)
 				(com2, s2) = cbigStep(c2, s1)
					in (com2, s2)
cbigStep (Atrib (Var x) e,s) = let	(n1,s1) = ebigStep(e,s)
					(s2)	= (mudaVar s1 x n1)
						in (cbigStep(Skip, s2))
cbigStep (While b c, s) = case bbigStep(b,s) of
			(True, _) -> cbigStep(Seq (c) (While b c), s)
			(False, _) -> cbigStep(Skip, s)

cbigStep (Repeat c b, s) = let	(c1, s1) = cbigStep(c,s)
				in(case bbigStep(b, s1) of
				(True, _) -> cbigStep(Skip, s1)
				(False, _) -> cbigStep(Repeat c b, s1))

cbigStep (DoWhile c b, s) = let (c1, s1) = cbigStep(c,s)
			in(case bbigStep(b,s1) of
			(True, _) -> cbigStep(DoWhile c b, s1)
			(False, _) -> cbigStep(Skip, s1))

cbigStep (For (Var x) e1 e2 c,s) = cbigStep(Seq
					(Atrib (Var x) e1)
					(If (Leq e1 e2) (Seq c (For (Var x) (Soma e1 (Num 1)) e2 c)) (Skip)), s)

cbigStep (Swap (Var x) (Var y), s) = (Skip, mudaVar (mudaVar s x (procuraVar s y)) y (procuraVar s x)  )  

cbigStep (AtribDupla (Var x) (Var y) e1 e2, s) = cbigStep(Seq
					(Atrib (Var x) e1)
          (Atrib (Var y) e2), s)


-- TESTES
--- O progExp1 é um programa que usa apenas a semântica das expressões aritméticas. 
progExp1 :: E
progExp1 = Soma (Num 3) (Soma (Var "x") (Var "y"))
-- *Main> ebigStep (progExp1, exSigma)
-- (13,[("x",10),("temp",0),("y",0)]) OBS: Aqui coloquei para ele retornar além do inteiro que é o resultado da soma da memórias x e y com o número 3, a pŕopria memória
-- *Main> ebigStep (progExp1, exSigma2)
-- (6,[("x",3), ("y",0), ("z",0)]) OBS: Aqui coloquei para ele retornar além do inteiro que é o resultado da soma da memórias x e y com o número 3, a pŕopria memória

testeIg :: B
testeIg = Igual (Num 3) (Num 3)
-- bbigStep ((Igual (Num 2) (Num 3)), exSigma2 ) -> (False,[("x",3),("y",0),("z",0)])

testeAnd :: B
testeAnd = And TRUE (Not FALSE)
-- bbigStep ((And FALSE (Not FALSE)), exSigma2 ) -> (False,[("x",3),("y",0),("z",0)])

testeOr :: B
testeOr = Or (And TRUE TRUE) (Not TRUE)
-- bbigStep ((Or FALSE (Not TRUE)), exSigma2 ) -> (False,[("x",3),("y",0),("z",0)])

testeIf :: C
testeIf = If (And TRUE (Not FALSE)) testeAtriZ testeAtri
-- cbigStep (testeIf, exSigma2) -> (Skip,[("x",3),("y",0),("z",9)])

testeSeq :: C
testeSeq = Seq testeAtri testeIf
-- cbigStep (testeSeq, exSigma3) -> (Skip,[("x",3),("temp",11),("y",42)])

testeAtri :: C
testeAtri = Atrib (Var "temp") exemplo
-- cbigStep (testeAtri, exSigma3) -> (Skip,[("x",3),("temp",11),("y",0)])

testeAtriZ :: C
testeAtriZ = Atrib (Var "y") exemplo1
-- cbigStep (testeAtriZ, exSigma3) -> (Skip,[("x",3),("temp",5),("y",24)])

exemplo :: E
exemplo = Soma (Num 3) (Soma (Var "x") (Var "temp"))
-- exemplo = 3 + x + temp
-- no exemplo testeAtri, para exSigma3 -> temp = 3 + 3 + 5 = 11

exemplo1 :: E
exemplo1 = Mult (Num 3) (Soma (Var "x") (Var "temp"))
-- exemplo1 = 3 * (x + temp)
-- no exemplo testeAtriZ = 3 * (3 + 5) = 24

teste1 :: B
teste1 = (Igual (Soma (Num 3) (Num 3))  (Mult (Num 2) (Num 3)))
-- bbigStep (teste1, exSigma3) -> (True,[("x",3),("temp",5),("y",0)])
-- if(3 + 3 = 2 * 3)

teste2 :: B
teste2 = (Igual (Soma (Var "x") (Num 3))  (Mult (Num 2) (Num 3)))
-- bbigStep (teste2, exSigma3) -> (True,[("x",3),("temp",5),("y",0)])
-- if(x + 3 = 2 * 3)

testec1 :: C
testec1 = (Seq (Seq (Atrib (Var "y") (Var "x")) (Atrib (Var "x") (Var "temp")))
		(Atrib (Var "temp") (Var "y")))
-- cbigStep (testec1, exSigma3) -> (Skip,[("x",5),("temp",3),("y",3)])

fatorial :: C
fatorial = (Seq (Atrib (Var "temp") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "temp") (Mult (Var "temp") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))

-- Com exSigma3 -> X! colocado em Y -> (Skip,[("x",1),("y",6),("z",0)])
-- Com exSigma4 -> X! colocado em Y -> (Skip,[("x",1),("y",120),("z",0)])


--fazer com Memoria [("x",0), ("temp",10)] exSigma8
testeRepeat :: C
testeRepeat = (Repeat ( Atrib (Var "x") (Soma (Var "x") (Num 1)) ) (Igual (Var "x") (Var "temp") ) )
-- cbigStep (testeRepeat, exSigma8) -> (Skip,[("x",10),("y",10)])

--fazer com Memoria [("x",1)] exSigma6
testeDo :: C
testeDo = (DoWhile (Atrib (Var "x") (Mult (Var "x") (Num 2) ) )  (Leq (Var "x") (Num 64) ) )
-- cbigStep (testeDo, exSigma6) -> (Skip,[("x",128)])


-- X de 1 até 10 incrementando y em 2 unidades e z recebe a soma de z + y
testeFor:: C
testeFor = (For (Var "x") (Num 1) (Num 10)  (Seq (Atrib (Var "temp") (Soma (Var "temp") (Num 2))) (Atrib (Var "y") (Soma (Var "y") (Var "temp")))))
-- cbigStep (testeFor, exSigma3) -> (Skip,[("x",11),("temp",25),("y",160)])

--fazer com Memoria [("x",1), ("y", 3)] exSigma7
testeSwap :: C
testeSwap = (Swap (Var "x") (Var "temp") )
-- cbigStep (testeSwap, exSigma7) -> (Skip,[("x",3),("temp",1)])

programaUm :: C
programaUm = (If (Leq (Var "x") (Var "y")) 
                (Atrib (Var "temp") (Mult (Num 2) (Num 2))) 
                  (Atrib (Var "temp") (Num 5)))
--Primeiro comparamos se a variável x <= z, depois atribuimos à variável temp = 2*2, por fim atribuimos à variável temp = 5
--		if(x <= y){
--			temp = 2*2;
--			temp = 5;
--		}
-- cbigStep(programaUm, exSigma2) -> (Skip,[("x",3),("y",5),("z",0)])

programaDois :: C
programaDois = (DoWhile (Atrib (Var "x") (Soma (Var "x") (Num 1))) 
                (Leq (Var "x") (Num 8)))
-- Enquanto a variável x for menor 8, atribui a x a soma de x com 1.
-- 		while (x <= 8){
-- 		x = x + 1	 
--		}
--cbigStep(programaDois, exSigma3) -> (Skip,[("x",9),("temp",5),("y",0)])

--fazer com Memoria [("x",1), ("temp", 3)], exSigma7. Mas não faz muita diferença
testeAtribDupla :: C
testeAtribDupla = (AtribDupla (Var "x") (Var "temp") (Soma (Num 3) (Num 7)) (Sub (Num 10) (Num 4) ) )
-- cbigStep (testeAtribDupla, exSigma7) -> (Skip,[("x",10),("temp",6)])
