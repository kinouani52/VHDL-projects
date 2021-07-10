--Name SERGE MILTON KINOUANI



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity start_stop_relay is

	  generic
		(
			make_level : std_logic := '0'
		);
		port (
			rst :in  std_logic :='1';
			clk : in std_logic := '1' ;
			ena : in std_logic := '1' ;
			pulse_in :in std_logic  ;
			
			
			start_stop : out std_logic :='0'
		);
		end entity ;
		
	
	architecture behavior of start_stop_relay is 
	
			type fsm_state_type is (StStart,StMakeA, StMakeB, StBreakA,StBreakB);
			signal state: fsm_state_type; -- signal next_state: fsm_state_type;

			
			begin 
			
			 transition:  process (clk,rst)
			  
				  begin
					if( rst = '1') then
					  State <= StStart;
					 -- end if;
						  elsif (rising_edge (clk)) then 
						  if (rst = '0') then 
							 if (ena = '1') then
					 case state is 
										  when StStart => 
										 if (pulse_in = make_level)
														then state <= StMakeA;
										-- end if ;
										 elsif  (pulse_in = not(make_level))
													 then state <=	StBreakA;
									end if ;		
									 
										
									 
									 when  StBreakA =>
											if (pulse_in = make_level)
												then   state <= StMakeB;
										end if ;
										
									
								  when StMakeB => 
											if (pulse_in = not (make_level) )
											  then   state <= StBreakB ;
										  end if ;
								  when   StBreakB =>
											if ( pulse_in = make_level)
											 then state <= StMakeA ;
										 end if ;
										   when StMakeA =>
										 if (pulse_in = not (make_level))
														  then    state <= StBreakA;
										end if ;
									
						end case ;
										 end if;
						  end if;
					 end if;
			  end process transition;

	output:process (state)
				begin 
						  case state is 
						  when  StStart=>
						  start_stop <= '0';
							  when StMakeA=> 
							  start_stop <= '0';
						 when   StBreakA => 
						 start_stop <= '0';
							  when StMakeB => 
							  start_stop <= '1';
						 when   StBreakB =>
						 start_stop <= '1';
						  end case;
				  end process output;
				
end architecture behavior;
	  
                                     										
	       
	