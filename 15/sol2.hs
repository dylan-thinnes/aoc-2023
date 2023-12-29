module Main where

import Data.List (foldl')
import Data.Char (ord)

main :: IO ()
main = interact $ show . scoreState . foldl' runInstruction initialState . map parse . splitCommas

scoreState :: [[(String, Int)]] -> Int
scoreState = sum . zipWith scoreBox [1..]
  where
    scoreBox boxI = sum . zipWith (scoreLens boxI) [1..]
    scoreLens boxI slotI (_, focalLength) = boxI * slotI * focalLength

splitWhile :: (a -> Bool) -> [a] -> ([a], [a])
splitWhile pred xs = (takeWhile pred xs, drop 1 (dropWhile pred xs))

splitCommas :: String -> [String]
splitCommas = go . filter (/= '\n')
  where
    go [] = []
    go xs =
      let (fst, snd) = splitWhile (/= ',') xs
      in fst : splitCommas snd

runInstruction :: [[(String, Int)]] -> Instruction -> [[(String, Int)]]
runInstruction state (Remove id) = runRemove state id
runInstruction state (Insert id i) = runInsert state id i

modifyIndex :: String -> (a -> a) -> [a] -> [a]
modifyIndex id f = map go . zip [0..]
  where
    go (i, a)
      | i == index id = f a
      | otherwise = a

initialState :: [[(String, Int)]]
initialState = replicate 256 []

runRemove :: [[(String, Int)]] -> String -> [[(String, Int)]]
runRemove state id = modifyIndex id (filter (\(candidate, _) -> candidate /= id)) state

runInsert :: [[(String, Int)]] -> String -> Int -> [[(String, Int)]]
runInsert state id n = modifyIndex id go state
  where
    go ((candidate, m):rest)
      | candidate == id = (candidate, n) : rest
      | otherwise = (candidate, m) : go rest
    go [] = [(id, n)]

data Instruction
  = Remove String
  | Insert String Int
  deriving (Show, Eq, Ord)

parse :: String -> Instruction
parse xs =
  let (label, operation) = splitWhile (`notElem` "=-") xs
  in
  case operation of
    "" -> Remove label
    nRaw -> Insert label (read nRaw)

step :: Int -> Char -> Int
step acc c = (17 * (acc + fromIntegral (ord c))) `mod` 256

index :: String -> Int
index = foldl' step 0
