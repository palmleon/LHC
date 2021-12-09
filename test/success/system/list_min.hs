list_min :: [Double] -> Double -> Int -> Int
list_min xs min i = if (i >= elem xs)
                        then min
                        else
                            let x :: Double; x = xs !! 1
                            in							
							  if x < min
							    then list_min xs x (i+1)
                                else list_min xs min (i+1)
main = do
       let list :: [Double]
           list = [5.0, 2.0, 19.0, 34.0, 1.0]
       print (list_min list 100.0 0)