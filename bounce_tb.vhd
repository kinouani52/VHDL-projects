--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:50:41 03/13/2020
-- Design Name:   
-- Module Name:   C:/Exercises/New folder/bounce/bounce_tb.vhd
-- Project Name:  bounce
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bounce
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bounce_tb IS
END bounce_tb;
 
ARCHITECTURE behavior OF bounce_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debounce
    PORT(
         rst : IN  std_logic;
         bounce_in : IN  std_logic;
         ena : IN  std_logic;
         clk : IN  std_logic;

         debounce_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal bounce_in : std_logic := '0';
   signal ena : std_logic := '0';
   signal clk : std_logic := '0';
   signal debounce_out : std_logic := '0';
	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debounce PORT MAP (
          rst => rst,
          bounce_in => bounce_in,
          ena => ena,
          clk => clk, 
          debounce_out => debounce_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '0';
		ena <= '0';
		bounce_in <= '0';
      wait for 100 ns;	
     rst <= '0';
     ena <= '1';
bounce_in <= '1';
wait for 100 ns;
rst <= '1';
ena <= '0';
bounce_in <= '0';
wait for 100 ns;
rst <= '1';
ena <= '1';
bounce_in <= '1';
wait for 100 ns;
rst <= '1';
ena <= '1';
bounce_in <= '1';
wait for 100 ns;
wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
