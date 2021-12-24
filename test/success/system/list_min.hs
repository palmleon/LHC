list_min :: [Double] -> Double -> Int -> Double
list_min xs min i = if (i >= length xs)
                        then min
                        else 
                         if (i == 0)
                          then let x :: Double; x = xs !! 0
                           in list_min xs x (i+1)
                          else
                           let x :: Double; x = xs !! i
                           in							
							if x < min
							 then list_min xs x (i+1)
                             else list_min xs min (i+1)
main = do
       let list :: [Double]; x :: Double
           x = let x :: Double; x = -19.5e0 in x
           list = [5.0, 2.0, x, 34.0, 1.0]
       print (list_min list 100.0 0)
   -- result should be -19.5
   