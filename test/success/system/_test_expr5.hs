a, b :: Double
a = -3.0; b = 4.0
e :: Bool; e = if !(!(a <= b) || !(a /= b)) then True else False 
f :: Bool -> Bool
f b = let c :: Bool; c = b in c
main = do
       if e then do
         print "Hello there!"
         print "Shouldn't you be home at this time?"
        else print "Bye bye"