
-- Testbench interface (no ports)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY dec3to8_tb IS
END ENTITY dec3to8_tb;


-- Testbench implementation
ARCHITECTURE behavior OF dec3to8_tb IS 
 
    -- Component declaration for the Design Under Test (DUT)
    COMPONENT dec3to8
    PORT(
         din :  IN  integer range 0 to 7;
         dout : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT dec3to8;

   --Inputs
   signal din : integer range 0 to 7 := 0;
 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Design Under Test (DUT) and map its ports
	dut: dec3to8
	PORT MAP (
		-- Mapping: component port (left) => this arch signal/port (right)
		din  => din,
		dout => dout
	);

	-- Stimulus process
	stim_proc: process
	begin
		-- PUT YOUR CODE HERE TO ASSIGN ALL POSSIBLE VALUES TO din
		-- Remember to wait 100 ns before changing the value of din
		wait;   -- Input data exhausted. Simulation ended.
	end process;

END ARCHITECTURE behavior;