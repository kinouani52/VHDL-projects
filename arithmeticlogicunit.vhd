library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity arithmeticlogicunit is
generic (
W : positive := 8 -- operands width
);
port(
A, B : in signed(W - 1 downto 0); -- operands
s : in std_logic_vector(2 downto 0); -- select
R : out signed(W - 1 downto 0) -- result
);
end arithmeticlogicunit;
architecture arch of arithmeticlogicunit is
begin
process(A, B, s)
variable t : signed(2 * W - 1 downto 0);
begin
t := A * B;
case to_integer(unsigned(s)) is
when 0 => R <= A + B;
when 1 => R <= A - B;
when 2 => R <= A + B + 1;
when 3 => R <= A + 1;
when 4 => R <= abs(A);
when 5 => R <= -A;
when 6 => R <= t(2 * W - 1 downto W);
when 7 => R <= t(W - 1 downto 0);
when others => R <= (others => 'X');
end case;
end process;
end arch;