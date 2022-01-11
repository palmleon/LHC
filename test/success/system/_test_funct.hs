func1 :: Int -> Bool
func1 x = x < 0
func2 :: Int -> Int -> Bool
func2 x y = let res :: Bool; res = x > y in res
func3 :: String -> Char
func3 xs = xs !! 0
main = do
       let c :: Char
           c = func3 "Ciao"
       if c == 'C' then print "C recognized" else print "ERROR: C not found!" -- condition should be True
