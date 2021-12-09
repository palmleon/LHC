a :: Int
a = if True then
     if True then
      let x :: Bool; x = False
	  in if x then 1 else 2
      else 3
     else 5
main = do 
       let length :: Int 
           length = let l :: Int
		                l = a in l
       print length