gcd' :: Int -> Int -> Int
gcd' x y = 
          if x == 0 then y else gcd' (y rem x) x
myGCD :: Int -> Int -> Int
myGCD x y = 
          if x < 0 then myGCD (-x) y else
		  if y < 0 then myGCD x (-y) else
		  if y < x then gcd' y x else
		  gcd' x y
x, y :: Int		  
x = 41028
y = 5443074
main = do print "Numbers to compute GCD from:"
          print x
          print y
          print "Their GCD is"
          print (gcd' x y)