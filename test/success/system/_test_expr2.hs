b,c,d,e,f,g :: Double
b = 3.0; c = 4.0; d = 5.0
e = b - c
f = b/d
g = if (f >= e && e < f) then 1.0 else 0.0
doubleToBool :: Double -> Bool
doubleToBool x = if x == 1.0 then True else False 
main = if (doubleToBool x) print "True" else print "False"