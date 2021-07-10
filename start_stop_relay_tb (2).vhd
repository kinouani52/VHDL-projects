-- Name : Serge MILTON KINOUANI



library ieee;                     
use ieee.std_logic_1164.all;

entity start_stop_relay_tb is 
end entity start_stop_relay_tb ;


ARCHITECTURE behavior OF start_stop_relay_tb IS 

 COMPONENT start_stop_relay
	 generic(
		make_level : std_logic := '0'
			);
			port (
	rst :in  std_logic :='1';
	clk : in std_logic :='1';
	ena : in std_logic := '1' ;
	pulse_in : in std_logic;
	
	
	start_stop : out std_logic 
	);
end component start_stop_relay ;

-- Signals to stimulate the system-under-test
   --Inputs 
	 constant make_level : std_logic := '0';
    signal clk :  std_logic := '1';
    signal rst:    std_logic := '1';
    signal ena: std_logic := '1';
	 signal pulse_in :  std_logic :=  make_level ;
	 
	 --Outputs
	signal start_stop :  std_logic ;
	
	begin 
	
	dut: start_stop_relay     generic map ( make_level => make_level )
		 
		

		
		 
		 port map (
		 
		            clk  => clk,
                    rst	  => rst,				
                    ena  => ena,
						  	start_stop => start_stop,
					pulse_in  => pulse_in
				
				--	start_stop => start_stop
					);
					
--		clk  <= not (clk) after 100ns ;
		
		
		
 		
	   clk_process :process
  begin
 -- for i in 0 to 50 loop
		clk <= '0';
		wait for 5 ns ;
		clk <= not (clk);
		wait for 5 ns;
--	end loop;
   end process;
 
		
		stim_proc1 : process is 
		
		begin 
		       rst <= '1';
               wait for 500 ns; 
                rst <= '1';
                wait for 500 ns;
              	rst <= '0';			
		        wait for 500 ns ;
				rst <= '0';
				wait for 500 ns;
				
				end process stim_proc1;
				
		stim_proc2 : process is 
		
		begin 
		         pulse_in <= not(make_level);
				 wait for 20 ns ;
				 pulse_in <= make_level ;
				 wait for 30 ns;
				 pulse_in <= not(make_level);
				 wait for 30 ns;
				 pulse_in <= make_level ;
				 wait for 20 ns;
				 
				 end process stim_proc2;
				 
		stim_proc3 : process is 
		
		begin
				  ena <= '0' ;
				for i in 0 to 50 loop
				ena <= '1';
				wait for 500 ns ;
				end loop;
		end process stim_proc3;
 

    end architecture behavior; 
				
				
					