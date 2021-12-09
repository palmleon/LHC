x :: Int
x = 1 + 3 - 4 * 2 / 2
y :: Int
y = 3 div 2
z :: Int 
z = mod 3 2
w :: Double
w = -0.0
res :: Bool
res = if (x == 0) then
       if (y > 0 && z >= 0) then True else False
	   else False
main = if (z >= y && x >= y || !True)
        then print "z >= y and x gt y \n"
		else print "z < y or x < y \n"
