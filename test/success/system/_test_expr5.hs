a, b :: Double
a = -3.0; b = 4.0
e :: Bool; e = if not(not(a <= b) || not(a /= b)) then True else False 
f :: Bool -> Bool
f b = let c :: Bool; c = b in c
main = do
       if e then do
         print "Correct behaviour!"
         print "bye bye"
        else print "I SHOULDN'T PRINT THIS (there's a bug)"