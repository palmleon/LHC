x :: Int
x = 1 + 3 - 4 * 2
y :: Int
y = 3 div 2
z :: Int 
z = 3 rem 2
w :: Double
w = -0.0
res :: Bool
res = if (x == 0) then
       if (y > 0 && z >= 0) then True else False
	   else False
main = if (z >= y && x >= y || not True)
        then print "z >= y and x >= y" -- shouldn't print this
		else print "z < y or x < y" -- should print this
