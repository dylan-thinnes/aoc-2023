{-# LANGUAGE TupleSections #-}
main :: IO ()
main = interact $ show . score . map winners . lines

score :: [Int] -> Int
score = sum . go . map (,1)
  where
    go :: [(Int, Int)] -> [Int]
    go ((score, count):rest) =
      count : go ((map . fmap) (+count) (take score rest) ++ drop score rest)
    go [] = []

winners :: String -> Int
winners line =
  let targets = take 10 $ drop 2 $ words line
      tokens = drop 11 $ drop 2 $ words line
  in
  length $ filter (`elem` targets) tokens
