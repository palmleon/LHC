gcd :: Int -> Int -> Int
gcd x y = 
          if x == 0 then y else gcd (mod y x) x
myGCD :: Int -> Int -> Int
myGCD x y = 
          if x < 0 then myGCD (-x) y else
		  if y < 0 then myGCD x (-y) else
		  if y < x then gcd y x else
		  gcd x y
x, y :: Int		  
x = 4
y = 78
main = do print "GCD between 4 and 78 is"
          print (gcd x y)