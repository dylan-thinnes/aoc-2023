main :: IO ()
main = interact $ show . score . map winners . lines

score :: [Integer] -> Integer
score = sum . map f
  where
    f 0 = 0
    f n = 2 ^ (n - 1)

winners :: String -> Integer
winners line =
  let targets = take 10 $ drop 2 $ words line
      tokens = drop 11 $ drop 2 $ words line
  in
  fromIntegral $ length $ filter (`elem` targets) tokens
