a,b,c :: Int
a = 3; b = 4; c = 5
d :: Int
e :: Double
d = mod a b
e = a div b
main = do
       let judge :: Bool
           judge = if (d /= a || e > 1.0) then False else True
       if judge then print "False" else print "True"