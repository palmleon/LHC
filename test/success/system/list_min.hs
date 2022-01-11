list_min_rec :: [Double] -> Double -> Int -> Int -> Double
list_min_rec xs min i length = if (i >= length)
                                then min
                                else 
                                 let xi :: Double; xi = xs !! i
                                  in							
							      if xi < min
							       then list_min_rec xs xi (i+1) length
                                   else list_min_rec xs min (i+1) length
list_min  :: [Double] -> Int -> Double
list_min xs length = if length > 0
                      then list_min_rec xs (xs !! 0) 1 length
                      else -1.0 -- sort of error code
main = do
       let mylist :: [Double]; x :: Double
           x = let x :: Double; x = -19.5e0 in x
           mylist = [5.0, 2.0, x, 34.0, 1.0]
       print "Output should be -19.5"
       print (list_min mylist 5)
   -- result should be -19.5
   