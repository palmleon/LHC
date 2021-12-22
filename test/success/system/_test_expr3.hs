a,b,c :: Int
a = 3; b = 4; c = 5
d :: Int
e :: Int
d = a mod b
e = a div b
main = do
       let judge :: Bool
           judge = if (d /= a || e > 1) then False else True
       if judge then print "CORRECT" else print "WRONG"