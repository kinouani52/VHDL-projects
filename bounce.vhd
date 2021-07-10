--SERGE MILTON KINOUANI
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
    Port ( 
	 rst : in  STD_LOGIC;
	 bounce_in : in  STD_LOGIC;
	 ena : in  STD_LOGIC;
	 clk : in  STD_LOGIC;
	 debounce_out : out  STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
	signal input1 : STD_LOGIC := '0';
	signal input2 : STD_LOGIC := '0';
	signal input3 : STD_LOGIC := '0';
	begin

	button: process (clk, rst)
		begin 
			if(rst = '0') then
				debounce_out <= '0';
			elsif(rising_edge(clk) and clk'event) then
				if(ena = '1') then
					input3 <= input2;
					input2 <= input1;
					input1 <= bounce_in;
					if(input1 = '1' and input2 = '1' and input3 = '1') then 
			       debounce_out <= '1';
               elsif(input1 = '0' and input2 = '0' and input3 = '0') then 	 
					 debounce_out <= '0';
			     end if;
		      end if;
			end if;
			
	end process button;
end architecture Behavioral;

