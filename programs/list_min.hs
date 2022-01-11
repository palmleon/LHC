list_min_rec :: [Double] -> Double -> Int -> Int -> Double
list_min_rec xs min i length = if (i >= length)
                               then min
                               else 
                                let x :: Double; x = xs !! i
                                in							
							     if x < min
							     then list_min_rec xs x (i+1) length
                                 else list_min_rec xs min (i+1) length
list_min :: [Double] -> Int -> Double
list_min xs length = if length > 0 
                       then list_min_rec xs (xs !! 0) 1 length  
					   else -1.0
main = do
       let list :: [Double]; x :: Double
           x = -19.5e0
           list = [5.0, 2.0, x, 34.0, 1.0]  
       print (list_min list 5)
   -- result should be -19.5
   