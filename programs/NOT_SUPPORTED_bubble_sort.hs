bubble_sort :: [Int] -> [Int]
bubble_sort xs = bubble_sort_rec xs
bubble_sort_rec :: [Int] -> [Int]
bubble_sort_rec s = if elem s >= 2 
                     then let x1, x2 :: Int; xs :: [Int]
                              x1 = head s; xs = tail s; x2 = head xs
                          in if x1 > x2 
                              then x2:(bubble_sort_rec (x1:xs)) 
                              else x1:(bubble_sort_rec (x2:xs))
                     else s
xs :: [Int]
xs = [1, 5, 9, 2, 0, -6]
-- Non-Functional Part
main = print (bubble_sort xs)


					 