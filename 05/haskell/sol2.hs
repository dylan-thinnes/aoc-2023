{-# LANGUAGE RecordWildCards #-}
module Main where

main :: IO ()
main = interact $ show . minimum . map start . uncurry runOnRanges . parseRangesAndMapping

data Range = Range { start, end :: Int }
  deriving (Show)

isNonEmpty :: Range -> Bool
isNonEmpty Range{..} = end >= start

shiftRange :: Int -> Range -> Range
shiftRange i Range{..} = Range { start = start + i, end = end + i }

runOnRanges :: [Range] -> [[Mapping]] -> [Range]
runOnRanges = applyMappingss

parseRangesAndMapping :: String -> ([Range], [[Mapping]])
parseRangesAndMapping source =
  let ranges = parseRanges $ map read $ tail $ words $ head $ lines source
      mappingss = parseMappingss $ drop 2 $ lines source
  in
  (ranges, mappingss)

parseRanges :: [Int] -> [Range]
parseRanges (start:length:rest) =
  let end = start + length - 1
   in Range { start, end } : parseRanges rest
parseRanges [] = []

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

applyMapping :: Mapping -> Range -> ([Range], [Range])
applyMapping Mapping{..} Range{..} =
  ( map (shiftRange (to - from)) $
      filter isNonEmpty
        [ Range (max start from) (min end (from + size - 1))
        ]
  , filter isNonEmpty
      [ Range start (min end (from - 1))
      , Range (max start (from + size)) end
      ]
  )

applyMappings :: [Mapping] -> [Range] -> [Range]
applyMappings [] ranges = ranges
applyMappings (mapping:rest) ranges =
  let (mapped, unmapped) = foldMap (applyMapping mapping) ranges
  in
  mapped ++ applyMappings rest unmapped

applyMappingss :: [Range] -> [[Mapping]] -> [Range]
applyMappingss ranges [] = ranges
applyMappingss ranges (mappings:rest) = applyMappingss (applyMappings mappings ranges) rest
