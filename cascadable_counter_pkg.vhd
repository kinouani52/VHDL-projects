library ieee;
use ieee.std_logic_1164.all;
package cascadable_counter_pkg is

    -- This is the declaration of the component we want to verify
    component cascadable_counter is
    generic (max_count: positive := 10 );
    port (
		clk:   in  std_logic;
		rst:   in  std_logic := '0';
		ena:   in  std_logic := '1';
		cin:   in  std_logic := '1';
		cout:  out std_logic;
		count: out integer range 0 to max_count);
    end component cascadable_counter;

    -- ------------------------------------------------------------------------------------
    -- Constants 
    -- ------------------------------------------------------------------------------------

    -- Max count of each counter.
    -- Counters 1 (0 to 4, 5 cycles total) and 3 (0 to 2, 3 cycles total) are cascaded, 
    -- so cascade outputs of counter2 (0 to 14, 15 cycles total) and counter3 must match
    constant max_count1: positive := 4;
    constant max_count2: positive := 2;
    constant max_count3: positive := 14;

    -- The actual value of this clock period has no importance in functional simulation
    constant CLK_PERIOD: time := 20 ns;

    -- Number of clock cycles to assert each input signal 
    constant RST_ASSERTED_CYCLES:   integer := 10;
    constant ENA1_ASSERTED_CYCLES:  integer := 20;
    constant ENA2_ASSERTED_CYCLES:  integer := 40;
    constant ENA3_ASSERTED_CYCLES:  integer := 60;

    -- ------------------------------------------------------------------------------------
    -- Subprograms (declarations) used to help verify the module functionality
    -- ------------------------------------------------------------------------------------
	procedure cascadable_counter_check(signal clk: in std_logic; 
										signal rst: in std_logic; 
										signal ena: in std_logic; 
										signal cin: in std_logic; 
										signal cout: in std_logic; 
										signal count: in integer;
										constant max_count: in positive;
										constant name: string;
										variable cout_v: inout std_logic;
										variable count_v: inout integer);

end package cascadable_counter_pkg;






package body cascadable_counter_pkg is

	-- ------------------------------------------------------------------------------------
	-- Subprograms (implementations) used to help verify the module functionality
	-- ------------------------------------------------------------------------------------

	procedure cascadable_counter_check(signal clk: in std_logic; 
										signal rst: in std_logic; 
										signal ena: in std_logic; 
										signal cin: in std_logic; 
										signal cout: in std_logic; 
										signal count: in integer;
										constant max_count: in positive;
										constant name: string;
										variable cout_v: inout std_logic;
										variable count_v: inout integer) is
	begin
		wait on rst, clk;
		cout_v := '0';
		if (rst = '1') then
			count_v := 0;
		elsif rising_edge(clk) and (ena = '1') and (cin = '1') then
			count_v := (count_v + 1) mod (max_count+1);
		end if;
		wait for 1ns;
		if ((count_v = max_count) and (cin = '1')) then cout_v := '1'; end if;
		assert cout = cout_v report name & ": cout value error. Expected value " & std_logic'image(cout_v) & 
			", actual value " & std_logic'image(cout) severity warning;
		assert count = count_v report name & ": count value error. Expected value " & integer'image(count_v) & 
			", actual value " & integer'image(count) severity warning;
	end procedure cascadable_counter_check;
	
end package body cascadable_counter_pkg;
