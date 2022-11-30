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
     | Leq  E E
     | Igual  E E -- verifica se duas expressões aritméticas são iguais
   deriving(Eq,Show)

data C =    While B C
     | DoWhile C B -- Do C while B
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
exSigma2 :: Memoria
exSigma2 = [("x",0), ("temp",1), ("y",0)]
-- exSigma3 :: Memoria
-- exSigma3 = [("x", TRUE), ("temp", FALSE), ("y", TRUE)]
exSigma4 :: Memoria
exSigma4 = [("x",10), ("temp",1)]

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
--- [("x",10),("temp",20),("temp",0)]
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

smallStepE :: (E,Memoria) -> (E,Memoria)
-- variavel
smallStepE (Var x,s) = (Num (procuraVar s x),s)
-- soma
smallStepE (Soma (Num x) (Num temp), s) = (Num (x+temp),s)
smallStepE (Soma (Num x) e2, s) = let (ef,_) = smallStepE (e2 ,s)
                                 in (Soma (Num x) ef,s)
smallStepE (Soma e1 e2,s)  = let (ef,_) = smallStepE (e1, s)
                            in (Soma ef e2,s)
--subtração
smallStepE (Sub (Num x) (Num temp), s) = (Num (x-temp),s)
smallStepE (Sub (Num x) e2, s) = let (ef,_) = smallStepE (e2 ,s)
                                 in (Sub (Num x) ef,s)
smallStepE (Sub e1 e2,s)  = let (ef,_) = smallStepE (e1, s)
                            in (Sub ef e2,s)
--multiplicação
smallStepE (Mult (Num x) (Num temp), s) = (Num (x*temp),s)
smallStepE (Mult (Num x) e2, s) = let (ef,_) = smallStepE (e2 ,s)
                                 in (Mult (Num x) ef,s)
smallStepE (Mult e1 e2,s)  = let (ef,_) = smallStepE (e1, s)
                            in (Mult ef e2,s)

smallStepB :: (B,Memoria) -> (B,Memoria)
smallStepB (Not FALSE,s)      = (TRUE,s)

-- NOT
smallStepB (Not TRUE,s)       = (FALSE, s)
smallStepB (Not b, s) = let (bn,sn) = smallStepB (b,s)
                        in (Not bn ,sn)

--AND
smallStepB (And TRUE b2,s)  = (b2,s)
smallStepB (And FALSE b2,s) = (FALSE,s)
smallStepB (And b1 b2,s)    = let (bn,sn) = smallStepB (b1,s)
                              in (And bn b2,sn)

--OR
smallStepB (Or TRUE b2,s)  = (TRUE,s)
smallStepB (Or FALSE b2,s) = (b2,s)
smallStepB (Or b1 b2,s)    = let (bn,sn) = smallStepB (b1,s)
                              in (Or bn b2,sn)

--IGUAL
smallStepB (Igual (Num x) (Num temp), s) = if (x==temp) then (TRUE,s) else (FALSE, s)
smallStepB (Igual (Num x) e2, s) = let (el,_) = smallStepE (e2 ,s)
                                 in (Igual (Num x) el,s)
smallStepB (Igual e1 e2,s)  = let (el,_) = smallStepE (e1, s)
                            in (Igual el e2,s)

--MENOR
smallStepB (Leq (Num x) (Num temp), s) = if (x<temp) then (TRUE,s) else (FALSE, s)
smallStepB (Leq (Num x) e2, s) = let (el,_) = smallStepE (e2 ,s)
                                 in (Leq (Num x) el,s)
smallStepB (Leq e1 e2,s)  = let (el,_) = smallStepE (e1, s)
                            in (Leq el e2,s)

--If
smallStepC (If TRUE c1 c2,s) =  (c1,s) 
smallStepC (If FALSE c1 c2,s) = (c2,s) 
smallStepC (If b c1 c2,s) = let(bn,sn) = smallStepB(b,s) 
                            in (If bn c1 c2, sn)   

--Atrib
smallStepC (Atrib (Var x) (Num e),s) = (Skip, mudaVar s x e)
smallStepC (Atrib (Var x) e,s) = let(el,sn) = smallStepE(e,s) 
                                 in (Atrib (Var x) el, sn)

--Seq
smallStepC (Seq Skip c,s) = (c,s) 
smallStepC (Seq c1 c2,s) = let(cl,sn) = smallStepC(c1,s) 
                           in (Seq cl c2, sn)
 
--While
smallStepC (While b c, s) = ((If b (Seq c (While b c)) Skip), s)

--doWhile
smallStepC (DoWhile c b, s) = (Seq b (While c b), s)

----------------------
--  INTERPRETADORES
----------------------

--- Interpretador para Expressões Aritméticas:
isFinalE :: E -> Bool
isFinalE (Num a) = True
isFinalE _       = False

interpretadorE :: (E,Memoria) -> (E,Memoria)
interpretadorE (a,s) = if isFinalE a then (a,s) else interpretadorE (smallStepE (a,s))

--- Interpretador para expressões booleanas
isFinalB :: B -> Bool
isFinalB TRUE  = True
isFinalB FALSE = True
isFinalB _     = False


interpretadorB :: (B,Memoria) -> (B,Memoria)
interpretadorB (b,s) = if isFinalB b then (b,s) else interpretadorB (smallStepB (b,s))

-- Interpretador da Linguagem Imperativa
isFinalC :: C -> Bool
isFinalC Skip = True
isFinalC _    = False

interpretadorC :: (C,Memoria) -> (C,Memoria)
interpretadorC (c,s) = if isFinalC c then (c,s) else interpretadorC (smallStepC (c,s))



exemplo :: E
exemplo = Soma (Num 3) (Soma (Var "x") (Var "temp"))
exemplo3 :: E
exemplo3 = Sub (Num 3) (Sub (Var "x") (Var "temp"))
exemplo4 :: E
exemplo4 = Mult (Num 3) (Mult (Var "x") (Var "temp"))

exemploAtrib :: C
exemploAtrib = Atrib (Var "x") (Var "temp")

-- RODANDO O EXEMPLO:
-- Hugs> interpretadorE (exemplo, exSigma2)

testeNovo :: C
testeNovo = (While (Not (Igual (Var "x") (Num 3))) (Seq (Atrib (Var "x") 
                              (Soma (Var "x") (Num 1))) (Atrib (Var "temp") (Soma (Var "temp") (Num 3)))) )

exemplo2 :: B
exemplo2 = And (And TRUE (Not FALSE)) (And (Not (Not TRUE)) TRUE)

exemploOR :: B
exemploOR = Or FALSE (And TRUE (Not FALSE)) 
-- *Main> interpretadorB (exemplo2,exSigma2)
-- (TRUE,[("x",3),("temp",0),("y",0)])

--- TESTES

testec1 :: C
testec1 = (Seq (Seq (Atrib (Var "y") (Var "x")) (Atrib (Var "x") (Var "temp")))(Atrib (Var "temp") (Var "y")))

fatorial :: C
fatorial = (Seq (Atrib (Var "temp") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "temp") (Mult (Var "temp") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))


menor1 :: B 
menor1 = (Leq (Var "x") (Num 10))

exercicio :: C
exercicio = (Seq (Atrib (Var "x") (Num 0))
                  (While (Leq (Var "x") (Num 10)) ( Atrib (Var "x") (Soma (Var "x") (Num 1)))))