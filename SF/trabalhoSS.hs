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
     | DoWhile C B  -- Do C while B
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

--  Memórias 
exSigma :: Memoria
exSigma = [ ("x", 10), ("temp",0), ("y",0)]
exSigma2 :: Memoria
exSigma2 = [("x",10), ("y",1)]
exSigma3 :: Memoria
exSigma3 = [ ("x", 0), ("y",5), ("z",7)]
exSigma4 :: Memoria
exSigma4 = [ ("x", 4), ("y",10), ("z",3)]
exSigma5 :: Memoria
exSigma5 = [ ("x", 5), ("y", 22), ("z",15)]
exSigma6 :: Memoria
exSigma6 = [ ("x", 7), ("temp",15), ("y",0)]
exSigma7 :: Memoria
exSigma7 = [ ("x", 2), ("temp",30), ("y",47)]
exSigma8 :: Memoria
exSigma8 = [ ("x", 8), ("temp",102), ("y",79)]

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


smallStepE :: (E,Memoria) -> (E,Memoria)
-- variavel
smallStepE (Var x,s) = (Num (procuraVar s x),s)
-- soma
smallStepE (Soma (Num n1) (Num n2), s) = (Num (n1+n2),s)
smallStepE (Soma (Num n) e, s)         = let (el,sl) = smallStepE (e ,s)
                                         in (Soma (Num n) el,sl)
smallStepE (Soma e1 e2,s)              = let (el,sl) = smallStepE (e1, s)
                                         in (Soma el e2, sl)
--multiplicação
smallStepE (Mult (Num n1) (Num n2), s) = (Num (n1*n2),s)
smallStepE (Mult (Num n) e, s)        = let (el,sl) = smallStepE (e ,s)
                                         in (Mult (Num n) el,sl)
smallStepE (Mult e1 e2,s)              = let (el,sl) = smallStepE (e1, s)
                                         in (Mult el e2,sl)
--subtração
smallStepE (Sub (Num n1) (Num n2), s) = (Num (n1-n2),s)
smallStepE (Sub (Num n) e2, s) = let (ef,_) = smallStepE (e2 ,s)
                                 in (Sub (Num n) ef,s)
smallStepE (Sub e1 e2,s)  = let (ef,_) = smallStepE (e1, s)
                            in (Sub ef e2,s)

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
smallStepB (Igual (Num x) (Num y), s) = if (x==y) then (TRUE,s) else (FALSE, s)
smallStepB (Igual (Num x) e2, s) = let (el,_) = smallStepE (e2 ,s)
                                 in (Igual (Num x) el,s)
smallStepB (Igual e1 e2,s)  = let (el,_) = smallStepE (e1, s)
                            in (Igual el e2,s)

--MENOR
smallStepB (Leq (Num x) (Num y), s) = if (x<y) then (TRUE,s) else (FALSE, s)
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
smallStepC (DoWhile c b,s) = (Seq c (While b c), s)

----------------------
--  INTERPRETADORES
----------------------


--- Interpretador para Expressões Aritméticas:
isFinalE :: E -> Bool
isFinalE (Num n) = True
isFinalE _       = False


interpretadorE :: (E,Memoria) -> (E,Memoria)
interpretadorE (e,s) = if (isFinalE e) then (e,s) else interpretadorE (smallStepE (e,s))

--- Interpretador para expressões booleanas
isFinalB :: B -> Bool
isFinalB TRUE   = True
isFinalB FALSE  = True
isFinalB _      = False

interpretadorB :: (B,Memoria) -> (B,Memoria)
interpretadorB (b,s) = if isFinalB b then (b,s) else interpretadorB (smallStepB (b,s))

-- Interpretador da Linguagem Imperativa
isFinalC :: C -> Bool
isFinalC Skip   = True
isFinalC _      = False

interpretadorC :: (C,Memoria) -> (C,Memoria)
interpretadorC (c,s) = if isFinalC c then (c,s) else interpretadorC (smallStepC (c,s))

--------------------------------------
---
--- Exemplos de programas para teste
---
--- O ALUNO DEVE IMPLEMENTAR DOIS EXEMPLOS DE PROGRAMA, UM USANDO O IF E OUTRO USANDO O DO WHILE
-------------------------------------

teste1 :: B
teste1 = (Leq (Soma (Num 3) (Num 3))  (Mult (Num 2) (Num 3)))
-- interpretadorB(teste1, exSigma)
-- -*>
--(FALSE,[("x",10),("temp",0),("y",0)])

teste2 :: B
teste2 = (Leq (Soma (Var "x") (Num 3))  (Mult (Num 2) (Num 3)))
-- interpretadorB(teste2, exSigma)
-- -*>
-- (FALSE,[("x",10),("temp",0),("y",0)])
exemplo :: E
exemplo = Soma (Num 3) (Soma (Var "x") (Var "temp"))
-- interpretadorE(exemplo, exSigma) 
-- -*>
-- (Num 13,[("x",10),("temp",0),("y",0)])
exemplo3 :: E
exemplo3 = Sub (Num 3) (Sub (Var "x") (Var "temp"))
-- interpretadorE(exemplo3, exSigma)
-- -*>
-- (Num (-7),[("x",10),("temp",0),("y",0)])
exemplo4 :: E
exemplo4 = Mult (Num 3) (Mult (Var "x") (Var "temp"))
-- interpretadorE(exemplo4, exSigma)
-- -*>     
-- (Num 0,[("x",10),("temp",0),("y",0)])

exemploAtrib :: C
exemploAtrib = Atrib (Var "x") (Var "y")
-- interpretadorC(exemploAtrib, exSigma3)
-- -*>
-- (Skip,[("x",5),("y",5),("z",7)])

testeNovo :: C
testeNovo = (While (Not (Igual (Var "x") (Num 3))) (Seq (Atrib (Var "x") 
                              (Soma (Var "x") (Num 1))) (Atrib (Var "y") (Soma (Var "y") (Num 3)))) )
-- while(x != 3){
--    x = x + 1;
--    y = y + 3;   
-- }
-- interpretadorC(testeNovo, exSigma3)
-- -*>
-- (Skip,[("x",3),("y",14),("z",7)])
-- Se usar um x > 3 entra em loop.

exemplo2 :: B
exemplo2 = And (And TRUE (Not FALSE)) (And (Not (Not TRUE)) TRUE)
--  interpretadorB(exemplo2, exSigma)
-- -*>
-- (TRUE,[("x",10),("temp",0),("y",0)])
exemploOR :: B
exemploOR = Or FALSE (And TRUE (Not FALSE)) 
-- interpretadorB(exemploOR, exSigma)
-- (TRUE,[("x",10),("temp",0),("y",0)])

--- TESTES

testeSeq :: C
testeSeq = (Seq (Seq (Atrib (Var "z") (Var "x")) (Atrib (Var "x") (Var "y")))(Atrib (Var "y") (Var "z")))
-- exSigma3 = [ ("x", 2), ("y",5), ("z",7)]
-- z = x
-- x = y
-- y = z
-- interpretadorC(testeSeq, exSigma3)
-- -*>
-- (Skip,[("x",5),("y",0),("z",0)])

fatorial :: C
fatorial = (Seq (Atrib (Var "y") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "y") (Mult (Var "y") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))
-- interpretadorC(fatorial, exSigma)                                                        
-- -*>
-- (Skip,[("x",1),("temp",0),("y",3628800)

testeLeq :: B 
testeLeq = (Leq (Var "x") (Num 10))
-- interpretadorB(testeLeq, exSigma)
-- -*>
-- (FALSE,[("x",10),("temp",0),("y",0)])

exemploTeste :: C
exemploTeste = (Seq (Atrib (Var "x") (Num 0))
                  (While (Leq (Var "x") (Num 10)) ( Atrib (Var "x") (Soma (Var "x") (Num 1)))))
-- x = 0;
-- while (x <= 10)
-- x += 1;
-- interpretadorC(exemploTeste, exSigma2)
-- -*>
--(Skip,[("x",10),("temp",0),("y",0)])

programaUm :: C
programaUm = (If (Leq (Var "x") (Var "y")) 
                (Atrib (Var "temp") (Mult (Num 2) (Num 2))) 
                  (Atrib (Var "temp") (Num 5)))
--Primeiro comparamos se a variável x <= y, depois atribuimos à variável temp = 2*2, por fim atribuimos à variável temp = 5
--		if(x <= y){
--			temp = 2*2;
--			temp = 5;
--		}
-- interpretadorC(programaUm, exSigma)
-- -*>
-- (Skip,[("x",10),("temp",5),("y",0)])

programaDois :: C
programaDois = DoWhile (Atrib (Var "x") (Soma (Var "x") (Num 1)))
                    (Leq (Var "x") (Num 10))
-- Do x += 1 
-- while (x<=10)
-- interpretadorC(programaDois, exSigma)
-- -*>
-- (Skip,[("x",11),("temp",0),("y",0)])