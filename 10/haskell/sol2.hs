module Main where

import Control.Monad (guard)

main :: IO ()
main = do
  contents <- getContents
  let gridWithS = parse contents
      sIdx = findS gridWithS
      grid = connectS sIdx gridWithS
      loop = globLoop grid [] sIdx
      visualization = visualizeLoop grid (lines contents) loop
  putStrLn $ unlines visualization
  print $ countFilledTiles visualization

data Direction = U | D | L | R deriving (Show, Eq, Ord)

flipDirection :: Direction -> Direction
flipDirection U = D
flipDirection D = U
flipDirection R = L
flipDirection L = R

parse :: String -> Grid
parse = (map . map) directions . lines

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

allConnecting :: Grid -> Index -> [(Direction, Index)]
allConnecting grid idx =
  [ (dir, index)
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

connectS :: Index -> Grid -> Grid
connectS sIdx grid = (map . map) go grid
  where
    go pipe
      | pipe == [R, L, U, D] = map fst $ allConnecting grid sIdx
      | otherwise = pipe

globLoop :: Grid -> [Index] -> Index -> [Index]
globLoop grid seen current =
  let connections = map snd $ allConnecting grid current
      newConnections = filter (`notElem` seen) connections
  in
  case newConnections of
    (nearestConnection:_) -> globLoop grid (current : seen) nearestConnection
    [] -> current : seen

loopIntersections :: Grid -> Index -> [Index] -> Int
loopIntersections grid (y, x) loop = length
  [ index
  | x' <- [0..x]
  , let index = (y, x')
  , index `elem` loop
  , U `elem` (index `lookupIndex` grid)
  ]

visualizeLoop :: Grid -> [[Char]] -> [Index] -> [[Char]]
visualizeLoop grid source loop = zipWith goRow [0..] source
  where
    goRow :: Int -> String -> String
    goRow y row = zipWith (goCell y) [0..] row

    goCell :: Int -> Int -> Char -> Char
    goCell y x char =
      let idx = (y,x)
      in
      if idx `elem` loop
         then char
         else if loopIntersections grid idx loop `mod` 2 == 1
                  then '█'
                  else ' '

countFilledTiles :: [[Char]] -> Int
countFilledTiles = length . filter (== '█') . concat
