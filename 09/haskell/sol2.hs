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
     then head xs - head differences
     else head xs - extrapolate differences
