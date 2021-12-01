-- The following program takes a list of tuples containing 
-- name and ages, then filters all the people whose age 
-- is less than a certain value
-- This program tests:
-- Tuples, List with non trivial types (and their print), Recursion, Let, Do
emptyList :: [(String, Int)]
emptyList = []
filterAge :: [(String, Int)] -> Int -> [(String, Int)]
filterAge list n = 
        let element :: (String, Int); element = head list
            age = sel element 2		 
        in 
	       if age < n then element:(filterAge (tail list) n) else filterAge (tail list) n
main = do
       let people :: [(String, Int)]
           people = ("John", 50):("Joseph", 78):("Maria", 23):("Brie", 10):emptyList
           people' = filterAge people 25
       print people'
	   