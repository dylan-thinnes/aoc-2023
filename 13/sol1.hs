module Main where

import Data.List (transpose)

main :: IO ()
main = do
  contents <- getContents
  let matrices = splitMatrices (lines contents)
  print $ sum $ map score matrices

splitMatrices :: [[Char]] -> [[[Char]]]
splitMatrices [] = []
splitMatrices xs = takeWhile (/= "") xs : splitMatrices (drop 1 (dropWhile (/= "") xs))

palindromes :: Eq a => [a] -> [Bool]
palindromes = init . go []
  where
  go xs (y:ys) =
    and (zipWith (==) (y:xs) ys) :
    go (y:xs) ys
  go xs [] = []

reflectionColumn :: [[Bool]] -> Int
reflectionColumn = head . (++[0]) . map fst . filter snd . zip [1..] . foldr1 (zipWith (&&))

score :: Eq a => [[a]] -> Int
score matrix = reflectionColumn (map palindromes matrix) + 100 * reflectionColumn (map palindromes (transpose matrix))
