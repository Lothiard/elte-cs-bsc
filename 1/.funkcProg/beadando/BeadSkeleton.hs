module NagyBead where

import Data.Either
import Data.Maybe
import Text.Read (readMaybe)
import Data.Char (isDigit, isSpace)
import Data.List (find)

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
    show (TokBinOp _ op prec dir) = "TokBinOp " ++ show op ++ " " ++ show prec ++ " " ++ show dir

-- Eq peldany
instance Eq a => Eq (Tok a)
  where
    BrckOpen == BrckOpen = True
    BrckClose == BrckClose = True
    TokLit a == TokLit b = a == b
    TokBinOp _ op1 prec1 dir1 == TokBinOp _ op2 prec2 dir2 = op1 == op2 && prec1 == prec2 && dir1 == dir2
    _ == _ = False

type OperatorTable a = [(Char, (a -> a -> a, Int, Dir))]

tAdd, tMinus, tMul, tDiv, tPow :: (Floating a) => Tok a
tAdd = TokBinOp (+) '+' 6 InfixL
tMinus = TokBinOp (-) '-' 6 InfixL
tMul = TokBinOp (*) '*' 7 InfixL
tDiv = TokBinOp (/) '/' 7 InfixL
tPow = TokBinOp (**) '^' 8 InfixR

operatorTable :: (Floating a) => OperatorTable a
operatorTable = [
    ('+', ((+), 6, InfixL)),
    ('-', ((-), 6, InfixL)),
    ('*', ((*), 7, InfixL)),
    ('/', ((/), 7, InfixL)),
    ('^', ((**), 8, InfixR))
    ]

operatorFromChar :: OperatorTable a -> Char -> Maybe (Tok a)
operatorFromChar ops x = matchOperator (find ((== x) . fst) ops)
  where
    matchOperator Nothing = Nothing 
    matchOperator (Just (_, (opFunc, prec, dir))) = Just $ TokBinOp opFunc x prec dir

getOp :: (Floating a) => Char -> Maybe (Tok a)
getOp = operatorFromChar operatorTable

parseTokens :: Read a => OperatorTable a -> String -> Maybe [Tok a]
parseTokens ops input = processTokens tokens []
  where
    tokens = tokenize input -- tokenekre bontas

    tokenize :: String -> Maybe [String]
    tokenize = splitTokens [] False
      where
        splitTokens acc _ [] = Just (reverse acc)                 -- alapeset
        splitTokens acc prevBracket (c:cs)                        -- karakterek feldolgozasa
          | isSpace c = splitTokens acc False cs                  -- ws atugras
          | c == '(' = splitTokens ("(":acc) True cs              -- ( hozzaadas
          | c == ')' = splitTokens (")":acc) True cs              -- ) hozzaadas
          | isTokenChar c = 
              let (tok, rest) = span isTokenChar (c:cs)           -- token kiszedese
              in validateToken tok rest acc prevBracket           -- token validalasa
          | otherwise = Nothing                                   -- invalid karakter

        validateToken tok rest acc prevBracket                    -- token validalasa
          | prevBracket = Nothing                                 -- helytelen: zarojel elott operator
          | nextCharIsBracket rest = Nothing                      -- helytelen: zarojel utan operator
          | otherwise = splitTokens (tok:acc) False rest          -- helyes

        nextCharIsBracket [] = False                              -- nincs tobb karakter
        nextCharIsBracket (x:_) = x == '(' || x == ')'            -- zarojel

        isTokenChar x = not (isSpace x || x == '(' || x == ')')   -- token karakter

    processTokens Nothing _ = Nothing                             -- invalid token
    processTokens (Just []) acc = Just (reverse acc)              -- alapeset
    processTokens (Just (t:ts)) acc = processToken t ts acc

    processToken "(" ts acc = processTokens (Just ts) (BrckOpen : acc)                    -- ( token
    processToken ")" ts acc = processTokens (Just ts) (BrckClose : acc)                   -- ) token
    processToken [op] ts acc                                                              -- operator token
      | Just (f,p,d) <- lookup op ops = processTokens (Just ts) (TokBinOp f op p d : acc) -- operator
    processToken tok ts acc                                                               -- literal token
      | Just n <- readMaybe tok = processTokens (Just ts) (TokLit n : acc)                -- literal
      | otherwise = Nothing        
      
    checkFirstTwoChars (c1:c2:_) result
      | isOperatorChar c1 && isOperatorChar c2 = Nothing  -- Consecutive operators found
    checkFirstTwoChars _ result = result  -- No issue, proceed with result

    -- Helper function to identify operator characters
    isOperatorChar c = any (\(opChar, _) -> c == opChar) ops                                                       -- invalid token

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

    eval lit (BrckOpen : ops) = (lit, ops)                   -- alapeset ( '(' az op teteje )
    eval (x2 : x1 : xs) (TokBinOp f _ _ _ : ops) = eval (result : xs) ops
      where
        result = f x1 x2 

syNoEval :: String -> Maybe ([Double], [Tok Double])
syNoEval = parseAndEval parse shuntingYardBasic

syEvalBasic :: String -> Maybe ([Double], [Tok Double])
syEvalBasic = parseAndEval parse (\t -> shuntingYardBasic $ BrckOpen : (t ++ [BrckClose]))

-- 5.
shuntingYardPrecedence :: [Tok a] -> ([a], [Tok a])
shuntingYardPrecedence tokens = process tokens [] []
  where
    process [] litStack opStack = (litStack, opStack)                           -- nincs tobb token
    process (TokLit x : ts) litStack opStack = 
        process ts (x : litStack) opStack                                       -- literal
    process (BrckOpen : ts) litStack opStack = 
        process ts litStack (BrckOpen : opStack)                                -- nyito zarojel
    process (BrckClose : ts) litStack opStack =
        let (ops, rest) = breakBracket opStack []                               -- zaro zarojel
            newLits = foldOperators litStack ops                                -- operatorok kiszamolasa
        in process ts newLits rest                                              -- folytatas
    process (curr@(TokBinOp _ _ currPrec currAssoc) : ts) litStack opStack =
        let (toApply, remaining) = getPrecedenceOps curr opStack []             -- operatorok kivalasztasa
            newLits = foldOperators litStack toApply                            -- operatorok kiszamolasa
        in process ts newLits (curr:remaining)                                  -- folytatas

    breakBracket (BrckOpen:rest) acc = (reverse acc, rest)                      -- zarojel kereses
    breakBracket (op:rest) acc = breakBracket rest (op:acc)                     -- operatorok kereses
    breakBracket [] acc = (reverse acc, [])                                     -- nincs zarojel

    getPrecedenceOps _ [] acc = (reverse acc, [])                                     -- nincs operator
    getPrecedenceOps curr@(TokBinOp _ _ p1 a1) (top@(TokBinOp _ _ p2 _):rest) acc     -- operatorok kivalasztasa
      | p2 > p1 || (p2 == p1 && a1 == InfixL) = getPrecedenceOps curr rest (top:acc)  -- operatorok kivalasztasa
      | otherwise = (reverse acc, top:rest)                               -- operatorok kivalasztasa
    getPrecedenceOps _ (BrckOpen:rest) acc = (reverse acc, BrckOpen:rest) -- zarojel
    getPrecedenceOps curr (op:rest) acc = (reverse acc, op:rest)          -- operator

    foldOperators (x:y:rest) (TokBinOp f _ _ _:ops) = foldOperators (f y x : rest) ops -- operatorok kiszamolasa
    foldOperators lits _ = lits                                                        -- nincs operator

syEvalPrecedence :: String -> Maybe ([Double], [Tok Double])
syEvalPrecedence = parseAndEval parse (\t -> shuntingYardPrecedence $ BrckOpen : (t ++ [BrckClose]))

-- eqError-t vedd ki a kommentből, ha megcsináltad az 1 pontos "Hibatípus definiálása" feladatot
eqError = 0 -- Mágikus tesztelőnek szüksége van rá, NE TÖRÖLD!

-- 1. hibatipus
data ShuntingYardError =
  OperatorOrClosingParenExpected |
  LiteralOrOpeningParenExpected |
  NoClosingParen |
  NoOpeningParen |
  ParseError
    deriving (Show, Eq)

type ShuntingYardResult a = Either ShuntingYardError a

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