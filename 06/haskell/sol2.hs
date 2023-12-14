module Main where

main :: IO ()
main = do
  let parse = read . concat . tail . words
  time <- parse <$> getLine
  distance <- parse <$> getLine
  let race = (time, distance)
  print $ uncurry possibleSolutions race

possibleSolutions :: Int -> Int -> Int
possibleSolutions time distance =
  let (lower, upper) = quadratic time distance
  in
  floor (upper - 0.0000000001) - ceiling (lower + 0.0000000001) + 1

quadratic :: Int -> Int -> (Double, Double)
quadratic time distance =
  let a = -1
      b = fromIntegral time
      c = -fromIntegral distance
      plusminus = [(+), (-)]
      quadratic f = (-b `f` sqrt (b * b - 4 * a * c)) / (2 * a)
  in
  (quadratic (-), quadratic (+))
