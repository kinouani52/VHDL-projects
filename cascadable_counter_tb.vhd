
-- Self-contained (no ports) testbench for the "cascadable_counter" design unit
--
-- This testbench:
--
-- 1) Instantiate three cascadable counters, with different values for the max_count generic parameter 
--    (4, 2, and 14)
--    Two of the counters are in parallel (first with max_count = 4, second with max_count = 14) 
--    and the third (with max_count = 2) has the cascade-in chained to the cascade-out of the first.
--    This structure is depicted below
--  
--    rst--------+--------------------------------------+
--               |                                      |
--    clk-----+--------------------------------------+  |
--            |  |                                   |  |
--    ena--+--------------------------------------+  |  |
--         |  |  |                                |  |  |
--         |  |  |         +--------------+       |  |  |         +--------------+
--         |  |  |         |max_count = 4 |       |  |  |         |max_count = 2 |
--         |  |  |         +--------------+       |  |  |         +--------------+
--         |  |  +-------->|rst           |       |  |  +-------->|rst           |
--         |  +----------->|clk           |       |  +----------->|clk           |
--         +-------------->|ena           |       +-------------->|ena           |
--         |  |  |   open->|cin           |                +----->|cin           |
--         |  |  |         |         count|-->count_0to4   |      |         count|-->count_0to2
--         |  |  |         |          cout|-->cout_5-------+      |          cout|-->cout_5x3
--         |  |  |         |              |                       |              |
--         |  |  |         +--------------+                       +--------------+
--         |  |  |
--         |  |  |          +--------------+
--         |  |  |          |max_count = 14|
--         |  |  |          +--------------+
--         |  |  +--------->|rst           |
--         |  +------------>|clk           |
--         +--------------->|ena           |
--                    open->|cin           |
--                          |         count|-->count_0to14
--                          |          cout|-->cout_15
--                          |              |
--                          +--------------+
--
-- 2) Provide the stimuli to all counters (clk, rst, ena) in eight sections as follows
--
--    2.1) RST_ASSERTED_CYCLES clock cycles with the rst and ena inputs asserted.
--    2.2) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
--    2.3) RST_ASSERTED_CYCLES clock cycles with the rst and ena both deasserted.
--    2.4) ENA1_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted.
--    2.5) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
--    2.6) ENA2_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted
--         once every two clock cycles.
--    2.7) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
--    2.8) ENA3_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted 
--         once every three clock cycles.
-- 
--    During all the simulation the rst and ena signals assertions and deassertions
--    are sligthly shifted from the clock edge to ensure they are clearly separated
--    from the clock edge.
--
--    After these clock cycles have elapsed, the simulation finishes.
--    To stop the simulation a failed assertion is raised, producing the message 
--    "Simulation finished! (*not* a failure actually)" on the simulator console.
--
-- 3) At each clock edge the testbench code calculates the correct output of each counter
--    using a high-level implementation of the counters behaviour. 
--    This highly abstract implementation makes heavy use of procedures and non-synthesizable VHDL code.
--
-- 4) At each clock cycle the testbench code checks (using assertions) if the actual outputs 
--    of the instantiated counters match the calculated values by the highly-abstract description.
--    This comparison is carried out using procedures and non-synthesizable VHDL code.
--
--    4.1) If outputs match nothing happens
--
--    4.2) In case of mismatch, an assertion message appears on the simulator console
--         with the pattern  
--         "Note: output-name for counter-instance-name is wrong (expected some-value, actual is some-other-value)"
--
library ieee;
use ieee.std_logic_1164.all;
entity cascadable_counter_tb is
end entity cascadable_counter_tb;

use std.textio.all;
use work.cascadable_counter_pkg.all;
architecture sim of cascadable_counter_tb is

    -- Signals to stimulate the system-under-test
    signal clk: std_logic := '0';
    signal rst: std_logic := '0';
    signal ena: std_logic := '0';

    -- Outputs from the system-under-test
    signal cout_5:      std_logic;
    signal count_0to4:  integer range 0 to max_count1;
    signal cout_5x3:    std_logic;
    signal count_0to2:  integer range 0 to max_count2;
    signal cout_15:     std_logic;
    signal count_0to14: integer range 0 to max_count3;
	
	-- Signals used for automatic checking
	signal one: std_logic := '1';
	signal count_0to4_i:  integer;
    signal count_0to2_i:  integer;
    signal count_0to14_i: integer;

begin

    -- ************************************************************************************
    -- SYSTEM UNDER TEST
    -- ************************************************************************************

	counter1: cascadable_counter generic map (max_count => max_count1) 
		port map (
			clk => clk, rst => rst, ena => ena,
			cin => open,
			cout => cout_5,
			count=> count_0to4 );
	counter2: cascadable_counter generic map (max_count => max_count2) 
		port map (
			clk => clk, rst => rst, ena => ena,
			cin => cout_5,
			cout => cout_5x3,
			count=> count_0to2 );
	counter3: cascadable_counter generic map (max_count => max_count3) 
		port map (
			clk => clk, rst => rst, ena => ena,
			cin => open,
			cout => cout_15,
			count=> count_0to14 );
	

    -- ************************************************************************************
    -- STIMULI
    -- ************************************************************************************

    -- Generate the clock signal
    stim_clk: process (clk) is
    begin
        clk <= not(clk) after CLK_PERIOD / 2;
    end process stim_clk;

    -- Generate the rst and ena signal
    stim_rst_ena: process is
    begin
		--    2.1) RST_ASSERTED_CYCLES clock cycles with the rst and ena inputs asserted.
        rst <= '1';
        ena <= '1';
		wait for CLK_PERIOD/4;
        wait for RST_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.2) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
        rst <= '1';
        ena <= '0';
        wait for RST_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.3) RST_ASSERTED_CYCLES clock cycles with the rst and ena both deasserted.
        rst <= '0';
        ena <= '0';
        wait for RST_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.4) ENA1_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted.
        rst <= '0';
        ena <= '1';
        wait for ENA1_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.5) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
        rst <= '1';
        ena <= '0';
        wait for RST_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.6) ENA2_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted
		--         once every two clock cycles.
        rst <= '0';
		for i in 1 to ENA2_ASSERTED_CYCLES/2 loop
			ena <= '1';
			wait for CLK_PERIOD;
			ena <= '0';
			wait for CLK_PERIOD;
		end loop;
		--    2.7) RST_ASSERTED_CYCLES clock cycles with the rst asserted and ena deasserted.
        rst <= '1';
        ena <= '0';
        wait for RST_ASSERTED_CYCLES*CLK_PERIOD;
		--    2.8) ENA3_ASSERTED_CYCLES clock cycles with the rst deasserted and ena asserted 
		--         once every three clock cycles.
        rst <= '0';
		for i in 1 to ENA3_ASSERTED_CYCLES/3 loop
			ena <= '1';
			wait for CLK_PERIOD;
			ena <= '0';
			wait for 2*CLK_PERIOD;
		end loop;
		
		assert false report "Simulation finished! (not a failure actually)"  severity failure;
		wait;
    end process stim_rst_ena;



    -- ************************************************************************************
    -- FUNCTIONAL VERIFICATION USING ASSERTIONS
    -- ************************************************************************************

	count_0to14_i <= integer(count_0to14);
	count_0to4_i  <= integer(count_0to4);
	count_0to2_i  <= integer(count_0to2);
	check1: process is
		variable cout_v: std_logic := '0';
		variable count_v: integer:= 0;
	begin
		proc: cascadable_counter_check(clk, rst, ena, one, cout_5, count_0to4_i, max_count1, "counter1", cout_v, count_v);
	end process check1;
	check2: process is
		variable cout_v: std_logic := '0';
		variable count_v: integer:= 0;
	begin
		proc: cascadable_counter_check(clk, rst, ena, cout_5, cout_5x3, count_0to2_i, max_count2, "counter2", cout_v, count_v);
	end process check2;
	check3: process is
		variable cout_v: std_logic := '0';
		variable count_v: integer:= 0;
	begin
		proc: cascadable_counter_check(clk, rst, ena, one, cout_15, count_0to14_i, max_count3, "counter3", cout_v, count_v);
	end process check3;

end architecture sim;

