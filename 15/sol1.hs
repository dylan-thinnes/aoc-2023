module Main where

import Data.List (foldl')
import Data.Char (ord)

main :: IO ()
main = interact $ show . sum . map cost . splitCommas

splitCommas :: String -> [String]
splitCommas [] = []
splitCommas xs = takeWhile (/= ',') xs : splitCommas (drop 1 (dropWhile (/= ',') xs))

step :: Integer -> Char -> Integer
step acc c = (17 * (acc + fromIntegral (ord c))) `mod` 256

cost :: String -> Integer
cost = foldl' step 0
