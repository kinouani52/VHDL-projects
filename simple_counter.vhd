----------------------------------------------------------------------------------
-- Name: VICTOR MURILO KOSTYCHA


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:47:00 02/25/2020 
-- Design Name: 
-- Module Name:    dec3to8 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
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

 entity simple_counter is
  generic
	(
	MAX_COUNT : integer := 5
	);
	Port(
		rst : in std_logic := '0';
		clk : in std_logic := '0';
		mcount : out std_logic;
		count : out integer range 0 to MAX_COUNT
	);

end entity simple_counter;

architecture Behavioral of simple_counter is
	signal value : integer range 0 to MAX_COUNT;
begin
	cont : process (rst, clk) is
	begin
		if(rst = '1') then
			value <= 0;
		elsif rising_edge(clk) then
			if(value = MAX_COUNT) then
				value <= 0;
			else
				value <= value + 1;
			end if;
		end if;
	end process cont;
	
	mcount <= '1' when value = MAX_count else
				 '0';
	count <= value;
	
end Behavioral;

