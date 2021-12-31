countTrue :: [Bool] -> Int -> Int -> Int -> Int
countTrue xs i cnt length = if i < length
                     then 
                           if xs !! i
                           then countTrue xs (i+1) (cnt+1) length
                           else countTrue xs (i+1) cnt length					   
					 else cnt
main = do  
       let list :: [Bool]
           list = [True, False, True, False] 
       print (countTrue list 0 0 4) 
-- should print 2
