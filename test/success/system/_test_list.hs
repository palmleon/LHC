extract :: [Int] -> Int -> Int
extract xs i = xs !! i
main = do 
       let a :: [Int]
           a = [1, 3*2, 3*4, 4]
       print (extract ([2, 3, 4]) 2)
       print (a !! 2)
       do
        let ys :: [Char]; ys = "Hello, world"
        print ys


