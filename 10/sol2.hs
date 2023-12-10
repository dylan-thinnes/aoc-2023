module Main where

import Control.Monad (guard)

main = pure ()

data Direction = U | D | L | R deriving (Show, Eq, Ord)

flipDirection :: Direction -> Direction
flipDirection U = D
flipDirection D = U
flipDirection R = L
flipDirection L = R

parse :: IO Grid
parse = (map . map) directions . lines <$> getContents

directions :: Char -> [Direction]
directions 'F' = [D, R]
directions '7' = [D, L]
directions 'L' = [U, R]
directions 'J' = [U, L]
directions '|' = [U, D]
directions '-' = [R, L]
directions '.' = []
directions 'S' = [R, L, U, D]

type Pipe = [Direction]
type Grid = [[Pipe]]
type Index = (Int, Int)

lookupIndex :: Index -> Grid -> Pipe
lookupIndex (y, x) grid = grid !! y !! x

move :: Index -> Direction -> Index
move (y, x) R = (y, x+1)
move (y, x) L = (y, x-1)
move (y, x) D = (y+1, x)
move (y, x) U = (y-1, x)

validIndex :: Index -> Grid -> Bool
validIndex (y, x) grid =
  let maxX = length (head grid)
      maxY = length grid
  in
  x >= 0 && x < maxX && y >= 0 && y < maxY

connectsAlong :: Grid -> Index -> Direction -> Maybe Index
connectsAlong grid idx dir = do
  let newIndex = move idx dir
  guard $ validIndex newIndex grid
  let newPipe = newIndex `lookupIndex` grid
  guard $ flipDirection dir `elem` newPipe
  pure newIndex

allConnecting :: Grid -> Index -> [Index]
allConnecting grid idx =
  [ index
  | let pipe = idx `lookupIndex` grid
  , dir <- pipe
  , Just index <- pure (connectsAlong grid idx dir)
  ]

findS :: Grid -> Index
findS grid = head
  [ (y, x)
  | (y, row) <- zip [0..] grid
  , (x, cell) <- zip [0..] row
  , cell == [R, L, U, D]
  ]

globLoop :: Grid -> [Index] -> Index -> [Index]
globLoop grid seen current =
  let connections = allConnecting grid current
      newConnections = filter (`notElem` seen) connections
  in
  case newConnections of
    (nearestConnection:_) -> globLoop grid (current : seen) nearestConnection
    [] -> current : seen
