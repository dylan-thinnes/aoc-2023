{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NamedFieldPuns #-}
module Main where

import Data.Maybe (maybeToList)

main :: IO ()
main = interact $ show . sum . map (length . uncurry stepAll . parse) . lines

data Record = Blank | Gear deriving (Show, Eq, Ord)

data State = State
  { numberStarted :: Maybe Int
  , otherNumbers :: [Int]
  } deriving (Show, Eq, Ord)

parseRecord :: Char -> Maybe Record
parseRecord '?' = Nothing
parseRecord '.' = Just Blank
parseRecord '#' = Just Gear
parseRecord _ = error "Unrecognized"

parse :: String -> ([Maybe Record], State)
parse src =
  let [gearSrc, numberSrc] = words src
      numberStarted = Nothing
      records = map parseRecord gearSrc
      otherNumbers = map read $ words $ map (\c -> if c == ',' then ' ' else c) numberSrc
  in
  (records, State{..})

step :: Record -> State -> Maybe State
step Blank state@State{ numberStarted = Nothing } =
  Just state
step Blank state@State{ numberStarted = Just 0, otherNumbers } =
  Just State { numberStarted = Nothing, otherNumbers }
step Blank state@State{ numberStarted = Just n } =
  Nothing
step Gear state@State{ numberStarted = Nothing, otherNumbers = [] } =
  Nothing
step Gear state@State{ numberStarted = Nothing, otherNumbers = newNumber:rest } =
  Just State { numberStarted = Just (newNumber - 1), otherNumbers = rest }
step Gear state@State{ numberStarted = Just 0 } =
  Nothing
step Gear state@State{ numberStarted = Just n, otherNumbers } =
  Just State { numberStarted = Just (n - 1), otherNumbers }

stepBoth :: Maybe Record -> State -> [State]
stepBoth (Just record) state = maybeToList $ step record state
stepBoth Nothing state = maybeToList (step Blank state) ++ maybeToList (step Gear state)

stepAll :: [Maybe Record] -> State -> [State]
stepAll [] state@State{..} =
  [ state
  | length otherNumbers == 0
  , case numberStarted of
      Nothing -> True
      Just 0 -> True
      _ -> False
  ]
stepAll (record:rest) state = stepAll rest =<< stepBoth record state
