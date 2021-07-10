----------------------------------------------------------------------------------
-- Name: SERGE MILTON KINOUANI



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



 entity cascadable_counter is
  generic
	(
	MAX_COUNT : integer := 10
	);
	Port(
		rst : in std_logic := '0';
		clk : in std_logic := '0';
		ena: in std_logic:= '0';
		cin: in std_logic:= '1';
		cout : out std_logic;
		count : out integer range 0 to MAX_COUNT
	);

end entity cascadable_counter;

architecture Behavioral of cascadable_counter is
	signal value : integer range 0 to MAX_COUNT;
begin
	cont : process (rst, clk) is
	begin
		if(rst = '1') then
			value <= 0;
		elsif rising_edge(clk) then
			if(ena = '1') then
				if(cin = '1') then
					if(value = MAX_COUNT) then
					value <= 0;
					else
				    value <= value + 1;
					end if;
				end if;
			end if;
		end if;
	end process cont;
	
	cout <= '1'
	when value = MAX_count and cin = '1'
	else
				 '0';
	count <= value;
	
end Behavioral;

