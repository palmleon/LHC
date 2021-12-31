list_min :: [Double] -> Double -> Int -> Int -> Double
list_min xs min i length = if (i >= length)
                            then min
                            else 
                           if (i == 0)
                            then let x :: Double; x = xs !! 0
                             in list_min xs x (i+1) length
                            else
                             let x :: Double; x = xs !! i
                             in							
							 if x < min
							  then list_min xs x (i+1) length
                              else list_min xs min (i+1) length
main = do
       let list :: [Double]; x :: Double
           x = let x :: Double; x = -19.5e0 in x
           list = [5.0, 2.0, x, 34.0, 1.0]
       print (list_min list 100.0 0 5)
   -- result should be -19.5
   