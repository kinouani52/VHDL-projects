--Name SERGE MILTON KINOUANI



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity fpga_start_stop_relay is

	   --generic
		--(
		--make_level : std_logic := '0'
		--);
		port (
			rst :in  std_logic :='1';
			clk : in std_logic := '1' ;
			ena : in std_logic := '1' ;
			pulse_in :in std_logic  ;
			
			
			start_stop : out std_logic :='0'
		);
		end entity ;
	

	architecture behavior of fpga_start_stop_relay is
		component start_stop_relay is 
			generic (		  
				make_level :std_logic
			);
		

			port(
				rst :in  std_logic :='1';
				clk : in std_logic := '1' ;
				ena : in std_logic := '1' ;
				pulse_in :in std_logic  ;
				
				
				start_stop : out std_logic 
			);
			
			end component start_stop_relay;
		

	constant make_level : std_logic := '0';
	--signal	rst :  std_logic :='1';
	--signal	clk :  std_logic := '1' ;
	--signal	ena :  std_logic := '1' ;
	--signal	pulse_in : std_logic  ;
		
		
	--signal	start_stop :  std_logic;
		
	begin 
dut:start_stop_relay		
		generic map (make_level => make_level)
	
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 start_stop => start_stop,

			pulse_in => pulse_in
			
		  

		  );
			 
			 
			 end architecture;