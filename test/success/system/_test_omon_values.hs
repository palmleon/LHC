x :: Int
x = let y :: Int; y = let y :: Int; y = 0 in y-1
    in y-1
y :: Double
y = let y :: Double; y = 0.0 in y
main = do
       print "Result should be -2"
       print x
       print "Result should be 0.0"
       print y