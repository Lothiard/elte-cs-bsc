module NagyBead where

import Data.Either
import Data.Maybe
import Text.Read (readMaybe)
import Data.Char (isDigit, isSpace)

basicInstances = 0 -- Mágikus tesztelőnek kell ez, NE TÖRÖLD!

-- 1.
-- Dir tipus
data Dir = InfixL | InfixR
  deriving (Show, Eq, Ord)

-- Tok tipus
data Tok a = BrckOpen | BrckClose | TokLit a | TokBinOp (a -> a -> a) Char Int Dir

-- Show peldany
instance Show a => Show (Tok a)
  where
    show BrckOpen = "BrckOpen"
    show BrckClose = "BrckClose"
    show (TokLit a) = "TokLit " ++ show a
    show (TokBinOp _ op ero kotes) = "TokBinOp " ++ show op ++ " " ++ show ero ++ " " ++ show kotes

-- Eq peldany
instance Eq a => Eq (Tok a)
  where
    BrckOpen == BrckOpen = True
    BrckClose == BrckClose = True
    TokLit a == TokLit b = True
    TokBinOp _ op1 ero1 kotes1 == TokBinOp _ op2 ero2 kotes2 = op1 == op2 && ero1 == ero2 && kotes1 == kotes2 

type OperatorTable a = [(Char, (a -> a -> a, Int, Dir))]

tAdd, tMinus, tMul, tDiv, tPow :: (Floating a) => Tok a
tAdd = TokBinOp (+) '+' 6 InfixL
tMinus = TokBinOp (-) '-' 6 InfixL
tMul = TokBinOp (*) '*' 7 InfixL
tDiv = TokBinOp (/) '/' 7 InfixL
tPow = TokBinOp (**) '^' 8 InfixR

operatorTable :: (Floating a) => OperatorTable a
operatorTable =
    [ ('+', ((+), 6, InfixL))
    , ('-', ((-), 6, InfixL))
    , ('*', ((*), 7, InfixL))
    , ('/', ((/), 7, InfixL))
    , ('^', ((**), 8, InfixR))
    ]

-- 2.
operatorFromChar :: OperatorTable a -> Char -> Maybe (Tok a)
operatorFromChar [] _ = Nothing
operatorFromChar ((funk, (op, ero, kotes)):xs) x
  | funk == x = Just $ TokBinOp op funk ero kotes
  | otherwise = operatorFromChar xs x

getOp :: (Floating a) => Char -> Maybe (Tok a)
getOp = operatorFromChar operatorTable

-- 3.
parseTokens :: Read a => OperatorTable a -> String -> Maybe [Tok a]
parseTokens opTable input = traverse id $ tokenize [] input
  where
    tokenize temp [] = reverse temp                                                 -- alapeset
    tokenize temp (x:xs)
      | isSpace x = tokenize temp xs                                                -- hs ws
      | x == '(' = Just BrckOpen : tokenize temp xs                                 -- ha (
      | x == ')' = Just BrckClose : tokenize temp xs                                -- ha )
      | isDigit x =                                                                 -- ha literal
        case span (\x -> isDigit x || x == '.') (x:xs) of
          (num, maradek) -> Just (TokLit (read num)) : tokenize temp maradek
      | otherwise =                                                                 -- ha op
        case lookup x opTable of 
          Just (op, prec, dir) -> Just (TokBinOp op x prec dir) : tokenize temp xs
          Nothing -> [Nothing]
  
parse :: String -> Maybe [Tok Double]
parse = parseTokens operatorTable

parseAndEval :: (String -> Maybe [Tok a]) -> ([Tok a] -> ([a], [Tok a])) -> String -> Maybe ([a], [Tok a])
parseAndEval parse eval input = maybe Nothing (Just . eval) (parse input)

-- 4.
shuntingYardBasic :: [Tok a] -> ([a], [Tok a])
shuntingYardBasic tokens = shunt tokens [] []
  where
    shunt [] lit op = (lit, op)                              -- alapeset
    shunt (x:xs) lit op
      | TokLit x <- x = shunt xs (x : lit) op                -- ha literal -> literal lista
      | BrckOpen <- x = shunt xs lit (x : op)                -- ha ( -> operator lista
      | TokBinOp _ _ _ _ <- x = shunt xs lit (x : op)        -- ha operator -> operator lista
      | BrckClose <- x = shunt xs newLit newOp               -- ha ) -> eval
        where
          (newLit, newOp) = eval lit op

    eval lit (BrckOpen : ops) = (lit, ops)
    eval (x2 : x1 : xs) (TokBinOp f _ _ _ : ops) = eval (result : xs) ops
      where
        result = f x1 x2
      

syNoEval :: String -> Maybe ([Double], [Tok Double])
syNoEval = parseAndEval parse shuntingYardBasic

syEvalBasic :: String -> Maybe ([Double], [Tok Double])
syEvalBasic = parseAndEval parse (\t -> shuntingYardBasic $ BrckOpen : (t ++ [BrckClose]))

-- 5.
-- shuntingYardPrecedence :: [Tok a] -> ([a], [Tok a])

-- syEvalPrecedence :: String -> Maybe ([Double], [Tok Double])
-- syEvalPrecedence = parseAndEval parse (\t -> shuntingYardPrecedence $ BrckOpen : (t ++ [BrckClose]))

-- eqError-t vedd ki a kommentből, ha megcsináltad az 1 pontos "Hibatípus definiálása" feladatot
-- eqError = 0 -- Mágikus tesztelőnek szüksége van rá, NE TÖRÖLD!

{-
-- Ezt akkor vedd ki a kommentblokkból, ha a 3 pontos "A parser és az algoritmus újradefiniálása" feladatot megcsináltad.
parseAndEvalSafe ::
    (String -> ShuntingYardResult [Tok a]) ->
    ([Tok a] -> ShuntingYardResult ([a], [Tok a])) ->
    String -> ShuntingYardResult ([a], [Tok a])
parseAndEvalSafe parse eval input = either Left eval (parse input)

sySafe :: String -> ShuntingYardResult ([Double], [Tok Double])
sySafe = parseAndEvalSafe
  (parseSafe operatorTable)
  (\ts -> shuntingYardSafe (BrckOpen : ts ++ [BrckClose]))
-}

{-
-- Ezt akkor vedd ki a kommentblokkból, ha az 1 pontos "Függvénytábla és a típus kiegészítése" feladatot megcsináltad.
tSin, tCos, tLog, tExp, tSqrt :: Floating a => Tok a
tSin = TokFun sin "sin"
tCos = TokFun cos "cos"
tLog = TokFun log "log"
tExp = TokFun exp "exp"
tSqrt = TokFun sqrt "sqrt"

functionTable :: (RealFrac a, Floating a) => FunctionTable a
functionTable =
    [ ("sin", sin)
    , ("cos", cos)
    , ("log", log)
    , ("exp", exp)
    , ("sqrt", sqrt)
    , ("round", (\x -> fromIntegral (round x :: Integer)))
    ]
-}

{-
-- Ezt akkor vedd ki a kommentblokkból, ha a 2 pontos "Függvények parse-olása és kiértékelése" feladatot megcsináltad.
syFun :: String -> Maybe ([Double], [Tok Double])
syFun = parseAndEval
  (parseWithFunctions operatorTable functionTable)
  (\t -> shuntingYardWithFunctions $ BrckOpen : (t ++ [BrckClose]))
-}

{-
-- Ezt akkor vedd ki a kommentblokkból, ha minden más feladatot megcsináltál ez előtt.
syComplete :: String -> ShuntingYardResult ([Double], [Tok Double])
syComplete = parseAndEvalSafe
  (parseComplete operatorTable functionTable)
  (\ts -> shuntingYardComplete (BrckOpen : ts ++ [BrckClose]))
-}
