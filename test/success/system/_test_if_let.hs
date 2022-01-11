a :: Int
a = if True then
     if True then
      let x :: Bool; x = False
	  in if x then 1 else 2
      else 3
     else 5 -- a should be 2
main = do 
       let len :: Int 
           len = let l :: Int
                     l = a 
                    in l
       print "Output should be 2"
       print len --length should be 2
