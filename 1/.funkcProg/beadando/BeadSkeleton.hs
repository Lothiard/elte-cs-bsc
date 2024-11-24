module NagyBead where

import Data.Either ()
import Data.Maybe

-- parseTokenhez
import Data.Char (isDigit)
import Text.Read (readMaybe)
import Data.Maybe (isJust, fromJust)

basicInstances = 0 -- Mágikus tesztelőnek kell ez, NE TÖRÖLD!

-- Dir tipus
data Dir = InfixL | InfixR
  deriving (Show, Eq, Ord)

-- Tok tipus
data Tok a = BrckOpen | BrckClose | TokLit a | TokBinOp (a -> a -> a) Char Int Dir

-- Show instance
instance Show a => Show (Tok a)
  where
    show BrckOpen = "BrckOpen"
    show BrckClose = "BrckClose"
    show (TokLit a) = "TokLit " ++ show a
    show (TokBinOp _ jel ero kotes) = "TokBinOp " ++ show jel ++ " " ++ show ero ++ " " ++ show kotes

-- Eq instance
instance Eq a => Eq (Tok a)
  where
    BrckOpen == BrckOpen = True
    BrckClose == BrckClose = True
    TokLit a == TokLit b = True
    TokBinOp _ jel1 ero1 kotes1 == TokBinOp _ jel2 ero2 kotes2 = jel1 == jel2 && ero1 == ero2 && kotes1 == kotes2 

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

-- operatorFromChar
operatorFromChar :: OperatorTable a -> Char -> Maybe (Tok a)
operatorFromChar [] _ = Nothing
operatorFromChar ((jel, (muvelet, ero, kotes)):xs) char
  | char == jel = Just (TokBinOp muvelet jel ero kotes)
  | otherwise = operatorFromChar xs char

-- parseTokens
-- Define the parseTokens function
parseTokens :: Read a => OperatorTable a -> String -> Maybe [Tok a]
parseTokens opTable input = parseWords (words input) opTable

-- Function to parse a list of words into tokens
parseWords :: Read a => [String] -> OperatorTable a -> Maybe [Tok a]
parseWords [] _ = Just []
parseWords (w:ws) opTable =
  let tokens = parseWord w opTable
      restTokens = parseWords ws opTable
  in if isJust tokens && isJust restTokens
       then Just (fromJust tokens ++ fromJust restTokens)
       else Nothing

-- Function to parse a single word into tokens
parseWord :: Read a => String -> OperatorTable a -> Maybe [Tok a]
parseWord word opTable
  | all (`elem` "()" ) word = Just (parseBrackets word)
  | length word == 1 =
      let rd = readMaybe word
          op = operatorFromChar opTable (head word)
      in if isJust op
           then Just [fromJust op]
           else if isJust rd
                  then Just [TokLit (fromJust rd)]
                  else Nothing
  | otherwise =
      let rd = readMaybe word
      in if isJust rd
           then Just [TokLit (fromJust rd)]
           else Nothing

-- Function to parse brackets into tokens
parseBrackets :: String -> [Tok a]
parseBrackets [] = []
parseBrackets (c:cs)
  | c == '(' = BrckOpen : parseBrackets cs
  | c == ')' = BrckClose : parseBrackets cs
  | otherwise = []

-- Example usage
parse :: String -> Maybe [Tok Double]
parse input = parseTokens operatorTable input

getOp :: (Floating a) => Char -> Maybe (Tok a)
getOp = operatorFromChar operatorTable

parseAndEval :: (String -> Maybe [Tok a]) -> ([Tok a] -> ([a], [Tok a])) -> String -> Maybe ([a], [Tok a])
parseAndEval parse eval input = maybe Nothing (Just . eval) (parse input)

-- Shuntinhg Yard bassic
-- Definiáljuk a shuntingYardBasic függvényt
shuntingYardBasic :: [Tok a] -> ([a], [Tok a])
shuntingYardBasic tokens = processTokens tokens [] []

-- Segédfüggvény a tokenek feldolgozásához
processTokens :: [Tok a] -> [a] -> [Tok a] -> ([a], [Tok a])
processTokens [] litStack opStack = (litStack, opStack)
processTokens (t:ts) litStack opStack =
  case t of
    -- Ha literál, betesszük a litStack elejére
    TokLit n -> processTokens ts (n : litStack) opStack

    -- Ha nyitó zárójel, betesszük az opStack elejére
    BrckOpen -> processTokens ts litStack (BrckOpen : opStack)

    -- Ha operátor, kezeljük a precedenciát és az asszociativitást
    TokBinOp f c p d -> 
      let (newLitStack, newOpStack) = popOperators litStack opStack (getPrecedence t) d
      in processTokens ts newLitStack (t : newOpStack)

    -- Ha csukó zárójel, kiértékeljük az operátorokat a nyitó zárójel előtt
    BrckClose -> 
      let (newLitStack, newOpStack) = evaluateUntilBracket litStack opStack
      in processTokens ts newLitStack newOpStack

-- Segédfüggvény az operátorok kiértékeléséhez a nyitó zárójel előtt
evaluateUntilBracket :: [a] -> [Tok a] -> ([a], [Tok a])
evaluateUntilBracket litStack [] = (litStack, [])
evaluateUntilBracket litStack (op:ops) =
  case op of
    BrckOpen -> (litStack, ops) -- Megtaláltuk a nyitó zárójelet
    TokBinOp f _ _ _ -> 
      case litStack of
        (n1:n2:ns) -> 
          let result = f n2 n1 -- Fordított sorrend miatt n2 és n1
          in evaluateUntilBracket (result : ns) ops
        _ -> error "Nem elég literál az operátor alkalmazásához."
    _ -> error "Érvénytelen token az operátor stackben."

syNoEval :: String -> Maybe ([Double], [Tok Double])
syNoEval = parseAndEval parse shuntingYardBasic

syEvalBasic :: String -> Maybe ([Double], [Tok Double])
syEvalBasic = parseAndEval parse (\t -> shuntingYardBasic $ BrckOpen : (t ++ [BrckClose]))

-- syEvalPrecendce
-- Definiáljuk a shuntingYardPrecedence függvényt
shuntingYardPrecedence :: [Tok a] -> ([a], [Tok a])
shuntingYardPrecedence tokens = processTokens tokens [] []

-- Segédfüggvény az operátorok kiértékeléséhez az aktuális operátor precedenciája alapján
popOperators :: [a] -> [Tok a] -> Int -> Dir -> ([a], [Tok a])
popOperators litStack [] _ _ = (litStack, [])
popOperators litStack (op:ops) prec dir =
  case op of
    TokBinOp f' c' p' _ ->
      let shouldPop = if dir == InfixL
                        then p' >= prec
                        else p' > prec
      in if shouldPop
          then case litStack of
                (n1:n2:ns) ->
                  let result = f' n2 n1
                  in popOperators (result : ns) ops prec dir
                _ -> error "Nem elég literál az operátor alkalmazásához."
          else (litStack, op:ops)
    BrckOpen -> (litStack, op:ops)
    _ -> error "Érvénytelen token az operátor stackben."

-- Segédfüggvény az operátor precedenciájának kinyeréséhez
getPrecedence :: Tok a -> Int
getPrecedence (TokBinOp _ _ p _) = p
getPrecedence _ = 0 -- Csukó zárójel esetén 0


syEvalPrecedence :: String -> Maybe ([Double], [Tok Double])
syEvalPrecedence = parseAndEval parse (\t -> shuntingYardPrecedence $ BrckOpen : (t ++ [BrckClose]))

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
