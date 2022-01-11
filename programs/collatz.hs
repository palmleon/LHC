collatz :: Int -> Int -> Int
isEven :: Int -> Bool
x' :: Int; x' = 25
isEven n = (n rem 2 == 0)
collatz n i = if (n < 1) then -1 else
               if (n == 1) then i else
			   if (isEven n) then (collatz (n div 2) (i+1)) else (collatz (3*n + 1) (i+1))

main = do
       print "Applying the Collatz Procedure to 25 needs"
       print (collatz x' 0)
       print "steps"