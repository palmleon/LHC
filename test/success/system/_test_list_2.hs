countTrue :: [Bool] -> Int -> Int -> Int
countTrue xs i cnt = if i < elem xs
                     then 
                           let list :: [Bool]
                               list = [True, False, True, False]
                           if xs !! i == True
                           then countTrue xs (i+1) (cnt+1)
                           else countTrue xs (i+1) cnt						   
					 else cnt
main = print (countTrue list 0 0) -- should print 2