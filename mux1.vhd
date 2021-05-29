library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux1 is
  Port (
  a        : in  std_logic_vector(31 downto 0):= X"00001111";
  b        : in  std_logic_vector(31 downto 0):= X"01010101";
  aluc     : in  std_logic_vector(3 downto 0) := "0000";
  mux1_out : out std_logic_vector(31 downto 0)
  );
end mux1;

architecture Behavioral of mux1 is


function mux(
    mux1 : std_logic_vector(31 downto 0);
    mux2 : std_logic_vector(31 downto 0);
    aluc : std_logic
)return std_logic_vector is
variable mux_out : std_logic_vector(31 downto 0);
variable temp    : std_logic_vector(31 downto 0);

begin

if aluc = '0' then
    mux_out := mux1(31 downto 0);
else
    mux_out := mux2(31 downto 0);
end if;

return mux_out;
end function;

--------------------------------------------------

signal x1 : std_logic_vector(31 downto 0);
signal x2 : std_logic_vector(31 downto 0);

begin

x1 <= a and b;
x2 <= a or b;
mux1_out <= mux(x1,x2,aluc(2));
end Behavioral;

