{-# LANGUAGE RecordWildCards #-}
module Main where

import qualified Data.Map as M

main :: IO ()
main = do
  movements <- getLine
  getLine
  nodeMap <- M.fromList . map parseNode . lines <$> getContents
  print movements
  print nodeMap
  let startingPoints = filter (('A'==) . last) (M.keys nodeMap)
  print startingPoints
  print $ foldr1 lcm $ map (\point -> length $ followPath nodeMap point (cycle movements)) startingPoints

data Node = Node { left, right :: String }
  deriving (Show)

parseNode :: String -> (String, Node)
parseNode line =
  let name = take 3 line
      left = take 3 $ drop 7 line
      right = take 3 $ drop 12 line
  in
  (name, Node{..})

followPath :: M.Map String Node -> String -> String -> String
followPath nodeMap [_, _, 'Z'] _ = ""
followPath nodeMap node (dir:rest) =
  let dirFunc = if dir == 'L' then left else right
  in
  dir : followPath nodeMap (dirFunc (nodeMap M.! node)) rest
