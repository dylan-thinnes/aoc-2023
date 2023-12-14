module Main where

import Data.List

main :: IO ()
main = interact $ show . sum . map (extrapolate . parse) . lines

parse :: String -> [Int]
parse = map read . words

extrapolate :: [Int] -> Int
extrapolate xs =
  let differences = zipWith (-) (tail xs) xs
  in
  if length (nub differences) == 1
     then last xs + head differences
     else last xs + extrapolate differences
