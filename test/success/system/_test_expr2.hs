b,c,d,e,f,g :: Double
b = 3.0; c = 4.0; d = 5.0
e = b - c
f = b/d
g = if (f >= e && e < f) then 1.0 else 0.0
doubleToBool :: Double -> Bool
doubleToBool x = if x == 1.0 then True else False 
main = do
       print "There should be 3.0"
       print b
       print "There should be 4.0"
       print c
       print "There should be 5.0"
       print d
       print "There should be -1.0"
       print e
       print "There should be -1.0"
       print (b-c)
       print "There should be 0.6"
       print f
       print "There should be 0.6"
       print (b/d)
       if (doubleToBool g) then print "g is correct" else print "g is wrong"