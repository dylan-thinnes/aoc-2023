{-# LANGUAGE RecordWildCards #-}
module Main where

main :: IO ()
main = interact $ show . minimum . uncurry runOnSeeds . parseSeedsAndMapping

runOnSeeds :: [Int] -> [[Mapping]] -> [Int]
runOnSeeds is mappingss = map (`applyMappingss` mappingss) is

parseSeedsAndMapping :: String -> ([Int], [[Mapping]])
parseSeedsAndMapping source =
  let seeds = map read $ tail $ words $ head $ lines source
      mappingss = parseMappingss $ drop 2 $ lines source
  in
  (seeds, mappingss)

data Mapping = Mapping { from, to, size :: Int }
  deriving (Show)

parseMappingss :: [String] -> [[Mapping]]
parseMappingss [] = []
parseMappingss lines = parseMappings (takeWhile (/= "") lines) : parseMappingss (drop 1 (dropWhile (/= "") lines))

parseMappings :: [String] -> [Mapping]
parseMappings = map parseMapping . tail

parseMapping :: String -> Mapping
parseMapping line =
  let [to, from, size] = map read $ words line
  in
  Mapping{..}

applyMapping :: Int -> Mapping -> Maybe Int
applyMapping i Mapping{..}
  | i >= from && (i - from) < size = Just (i + to - from)
  | otherwise = Nothing

applyMappings :: Int -> [Mapping] -> Int
applyMappings i [] = i
applyMappings i (mapping:rest) =
  case applyMapping i mapping of
    Nothing -> applyMappings i rest
    Just i -> i

applyMappingss :: Int -> [[Mapping]] -> Int
applyMappingss i [] = i
applyMappingss i (mappings:rest) = applyMappingss (applyMappings i mappings) rest
