library ieee;   -- importing libraries
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- entity or interface

ENTITY  dec3to8u   IS

 PORT ( 

     din: in unsigned (2 downto 0);
	  dout: out std_logic_vector(7 downto 0) 
	  );
	  
	  END ENTITY dec3to8u;
	  
	  
-- ARCHTECTURE 

ARCHITECTURE behavior of  dec3to8u is 


begin 

	stim_proc: Process  ( din ) is
  variable v : integer;
	begin 
      v:= to_integer(din);
		for i in 0 to 7 Loop
		
		
			-- din <= i;
			
		if (i=v) then

 dout (i) <=  '1'; -- 
 else 
 dout(i) <= '0';

   end if;
	end loop;
	 
	 end process stim_proc;
	 

end ARCHITECTURE  behavior ; 
	  