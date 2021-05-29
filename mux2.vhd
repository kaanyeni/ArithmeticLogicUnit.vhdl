library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2 is
  Port (
  a        : in  std_logic_vector(31 downto 0) ;
  b        : in  std_logic_vector(31 downto 0) ;
  aluc     : in  std_logic_vector(3 downto 0);
  mux2_out : out std_logic_vector(31 downto 0)
  );
end mux2;

architecture Behavioral of mux2 is

function xor_gate(
    x1 : std_logic_vector(31 downto 0);
    x2 : std_logic_vector(31 downto 0)
)return std_logic_vector is
variable xor_out : std_logic_vector(31 downto 0);

begin
xor_out := x1 xor x2;
return xor_out;

end function;
--------------------------------------------------

function LUI(
    input  : std_logic_vector(31 downto 0)
) return std_logic_vector is
variable temp   : std_logic_vector(15 downto 0) := X"0000";
variable result : std_logic_vector(31 downto 0);

begin

result := input;
result := result(15 downto 0) & temp;

return result;
end function;
--------------------------------------------------

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
x1 <= a xor b;
x2 <= LUI(b);
mux2_out <= mux(x1,x2,aluc(2));

end Behavioral;
