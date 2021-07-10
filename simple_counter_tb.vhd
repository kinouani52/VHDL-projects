----------------------------------------------------------------------------------
-- Name: VICTOR MURILO KOSTYCHA


-- Testbench interface (no ports)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY simple_counter_tb IS
END ENTITY simple_counter_tb;


-- Testbench implementation
ARCHITECTURE behavior OF simple_counter_tb IS 
 
    -- Component declaration for the Design Under Test (DUT)
    COMPONENT simple_counter
	 generic(
			MAX_COUNT : integer := 5
			);
    PORT(
			rst : in std_logic:= '0';
			clk : in std_logic:= '0';
			mcount : out std_logic;
			count : out integer range 0 to MAX_COUNT
        );
    END COMPONENT simple_counter;

   --Inputs
   --signal din : unsigned (2 downto 0);
	constant MAX_COUNT_TB: integer := 5;
	signal rst : std_logic;
	signal clk : std_logic;
 	--Outputs
	signal mcount : std_logic;
	signal count : integer range 0 to MAX_COUNT_TB;
   --signal dout : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Design Under Test (DUT) and map its ports
	dut: simple_counter generic map(MAX_COUNT => MAX_COUNT_TB)
	PORT MAP (
		-- Mapping: component port (left) => this arch signal/port (right)
		rst => rst,
		clk => clk,
		mcount => mcount,
		count => count
	);

	-- Stimulus process

	stim_proc: process
	begin
		clk <= '0';
		wait for 100 ns;
		for i in 0 to 50 loop
			clk <= 	not clk;
			wait for 50 ns;
		end loop;	
		-- PUT YOUR CODE HERE TO ASSIGN ALL POSSIBLE VALUES TO din
		-- Remember to wait 100 ns before changing the value of din
		assert false severity failure;
		wait;   -- Input data exhausted. Simulation ended.
	end process;

	stim_proc2: process
	begin
		rst <= '0';
		wait for 200 ns;
		rst <= '1';
		wait for 200 ns;
		rst <= '0';
		-- PUT YOUR CODE HERE TO ASSIGN ALL POSSIBLE VALUES TO din
		-- Remember to wait 100 ns before changing the value of din
		--assert false severity failure;
		wait;   -- Input data exhausted. Simulation ended.
	end process;

END ARCHITECTURE behavior;