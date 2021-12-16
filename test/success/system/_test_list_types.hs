main = do
       let a :: [Int]
           b :: [Char]
           c :: String
           d :: [Bool]
           e :: [Double]
           a = [1,2,3,4]
           b = ['a','b','c','d']
           c = "Hi there!"
           d = [True, True, True]
           e = [0.0, 1.0, 2.0]
        do
        let x :: String; x = [b !! 0, b !! 1]
        print x