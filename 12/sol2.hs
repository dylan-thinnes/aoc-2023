{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NamedFieldPuns #-}
module Main where

import Data.Maybe (maybeToList)
import Data.List (unfoldr, partition, intercalate, nub)
import qualified Data.Map as M

main :: IO ()
main = interact $ show . sum . map (uncurry score . parse) . lines

data Record = Blank | Gear deriving (Show, Eq, Ord)

data State = State
  { numberStarted :: Maybe Int
  , otherNumbers :: [Int]
  } deriving (Show, Eq, Ord)

type States = M.Map State Int

mergeStates :: [States] -> States
mergeStates = foldr1 (M.unionWith (+))

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

isFinished :: State -> Bool
isFinished State{..} = null otherNumbers && numberStarted == Nothing

isFinishedAtEnd :: State -> Bool
isFinishedAtEnd State{..} =
  null otherNumbers &&
  case numberStarted of
    Nothing -> True
    Just 0 -> True
    _ -> False

stepAll :: [Maybe Record] -> States -> States
stepAll [] states = states
stepAll (record:rest) states =
  let states' = M.fromListWith (+)
        [ (state', k)
        | (state, k) <- M.toList states
        , state' <- stepBoth record state
        ]
  in
  stepAll rest states'

stepAllRep5 :: [Maybe Record] -> State -> States
stepAllRep5 records state =
  let records' = intercalate [Nothing] (replicate 5 records)
      state' = state { otherNumbers = concat (replicate 5 (otherNumbers state)) }
  in
  stepAll records' (M.singleton state' 1)

score :: [Maybe Record] -> State -> Int
score records state = sum (M.elems (M.filterWithKey (\k _ -> isFinishedAtEnd k) (stepAllRep5 records state)))

  {-
stepAllAfterN :: Bool -> [Maybe Record] -> State -> [(States, States)]
stepAllAfterN starting records origState = go starting (M.singleton origState 1)
  where
  go isFirst input =
    let records' = if isFirst then records else Nothing : records
        states = stepAll records' input
        (finished, unfinished) = M.partitionWithKey (\k _ -> isFinished k) states
        next =
          M.fromListWith (+)
            [ (addMoreNumbers state, n)
            | (state, n) <- M.toList unfinished
            ]
          where
          addMoreNumbers state =
            State
              { numberStarted = numberStarted state
              , otherNumbers = otherNumbers state ++ otherNumbers origState
              }
    in
    (finished, unfinished) : go False next

starts :: [Maybe Record] -> State -> [States]
starts records state =
  let allAfterN = stepAllAfterN True records state
      firstFour = map fst (take 4 allAfterN)
      fifth =
        let (fin, unfin) = allAfterN !! 4
         in mergeStates [fin, M.filterWithKey (\k _ -> isFinishedAtEnd k) unfin]
  in
  firstFour ++ [fifth]

mids :: [Maybe Record] -> State -> [States]
mids records state =
  let allAfterN = stepAllAfterN False records state
      firstFour = map fst (take 4 allAfterN)
  in
  firstFour

score :: [Maybe Record] -> State -> Int
score records state =
  let [s1, s2, s3, s4, s5] = map (sum . M.elems) $ starts records state
      [m1, m2, m3, m4] = map (sum . M.elems) $ mids records state
  in
  sum
    [ s1 * (m1 ^ 4 + m2 ^ 2 + 3 * m1 * m1 * m2 + m3 * m1 * 2 + m4)
    , s2 * (m3 + m1 * m2 * 2 + m1 ^ 3)
    , s3 * (m1 * m1 + m2)
    , s4 * m1
    , s5
    ]
  -}
