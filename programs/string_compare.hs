string_compare_rec :: [Char] -> [Char] -> Int -> Int -> Int -> Int
string_compare_rec s1 s2 i length shortIdx = 
                               if (i >= length) 
                                then shortIdx -- if we have reached the end of the shortest string, return its index
                                else 
                                 if (s1 !! i) < (s2 !! i) then 1 else
                                 if (s1 !! i) > (s2 !! i) then 2 else
                                 string_compare_rec s1 s2 (i+1) length shortIdx
string_compare :: [Char] -> [Char] -> Int -> Int -> Int
string_compare s1 s2 length shortIdx = if length <= 0 
                               then -1
                               else string_compare_rec s1 s2 0 length shortIdx
min :: Int -> Int -> Int
min x y = if x < y then x else y
whichIsSmaller :: Int -> Int -> Int
whichIsSmaller x y = if x <= y then 1 else 2
main = do let string1 :: String; string1 = "world" -- modify this line to try with other inputs
              string2 :: String; string2 = "worl"  -- modify this line to try with other inputs
              result :: Int; result = string_compare string1 string2 (min 5 4) (whichIsSmaller 5 4)
          print "Strings to be compared:"
          print string1; print string2
          if result == -1 then print "something went wrong" else
           if result == 1 then print "The first string is lower or equal to the second one"
            else print "The second string is lower or equal to the first one"