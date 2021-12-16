countTrue :: [Bool] -> Int -> Int -> Int
countTrue xs i cnt = if i < elem xs
                     then 
                           if xs !! i
                           then countTrue xs (i+1) (cnt+1)
                           else countTrue xs (i+1) cnt						   
					 else cnt
main = do  
       let list :: [Bool]
           list = [True, False, True, False] 
       print (countTrue list 0 0) 
-- should print 2
