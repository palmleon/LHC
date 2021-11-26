-- The following program takes a list of tuples containing 
-- name and ages, then filters all the people whose age 
-- is less than a certain value
-- This program tests:
-- Tuples, List with non trivial types (and their print), Recursion, Let, Do
filterAge :: [(String, Int)] -> Int -> [(String, Int)]
filterAge list n = 
       if (length list) == 0 then [] else
        let element :: (String, Int); element = head list
            age = sel element 2		 
        in 
	       if age < n then element:(filterAge (tail list) n) else filterAge (tail list) n
main = do
       let people :: [(String, Int)]
           people = ("John", 50):("Joseph", 78):("Maria", 23):("Brie", 10):[]
           people' = filterAge people 25
       print people'
	   