module Main where

import Data.List

charStrength :: Char -> Int
charStrength 'A' = 14
charStrength 'K' = 13
charStrength 'Q' = 12
charStrength 'T' = 10
charStrength 'J' = 0
charStrength c = read [c]

handStrength :: String -> (Int, [Int])
handStrength hand =
  ( sum
      [ if isFive then 1000 else 0
      , if isFour then 100 else 0
      , if isThree then 10 else 0
      , twoGroups * 1
      ]
  , map charStrength hand
  )
    where
      nonJoker = filter (/= 'J') hand
      jokerCount = length (filter (== 'J') hand)
      groups =
        case reverse $ sort $ sameKindGroups nonJoker of
          (highest:rest) -> highest + jokerCount : rest
          [] -> [5]
      isFive = 5 `elem` groups
      isFour = 4 `elem` groups
      isThree = 3 `elem` groups
      twoGroups = length (filter (==2) groups)

sameKindGroups :: String -> [Int]
sameKindGroups line = map length (group (sort line))

parseLine :: String -> (String, Int)
parseLine line =
  let [x, y] = words line
  in
  (x, read y)

main :: IO ()
main = interact $ \source ->
  let hands = map parseLine $ lines source
      sortedHands = sortOn (handStrength . fst) hands
      bidsTimesRanks = zipWith (*) [1..] (map snd sortedHands)
  in
  show $ sum bidsTimesRanks
