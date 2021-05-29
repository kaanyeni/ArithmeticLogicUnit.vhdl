library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
  Port (
  a        : in  std_logic_vector(31 downto 0):= X"00001111";
  b        : in  std_logic_vector(31 downto 0):= X"01010101";
  aluc     : in  std_logic_vector(3 downto 0) := "0000";
  z        : out std_logic;
  r        : out std_logic_vector(31 downto 0)
  );
end ALU;

architecture Behavioral of ALU is

---------------------------------------------
component mux3 is
  Port (
  a        : in  std_logic_vector;
  b        : in  std_logic_vector;
  aluc     : in  std_logic_vector;
  mux1_out : out std_logic_vector
  );
end component;
---------------------------------------------
function zero_flag(
    in1 : std_logic_vector(31 downto 0)
)return std_logic is
variable op : std_logic;
variable temp : integer;

begin
temp := TO_INTEGER(unsigned(in1));

if temp = 0 then
    op := '1';
else
    op := '0';
end if;

return op;
end function;
---------------------------------------------
Signal out_value : std_logic_vector(31 downto 0);

---------------------------------------------

begin

value : mux3 port map(a(31 downto 0), b(31 downto 0), aluc(3 downto 0), out_value(31 downto 0));

z <= zero_flag(out_value);
r <= out_value;

end Behavioral;
