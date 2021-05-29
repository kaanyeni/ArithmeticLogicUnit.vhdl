library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift is
  Generic (
    lenght : integer := 32
    );
   Port (
   sa     : in std_logic_vector(4 downto 0) := "00100";             --a input value
   d      : in std_logic_vector(lenght -1 downto 0) := X"00001000"; --b input value
   right  : in std_logic := '0';                                    --aluc 2 
   aright : in std_logic;                                           --aluc 3
   sh     : out std_logic_vector(lenght -1 downto 0)                -- output
   ); 
end shift;

architecture Behavioral of shift is

function shiftting(
    input  : std_logic_vector(lenght -1 downto 0);
    amount : integer;
    op     : std_logic;
    arith  : std_logic
) return std_logic_vector is
variable temp   : std_logic_vector(31 downto 0);
variable temp2  : std_logic;
variable result : std_logic_vector(31 downto 0);
variable status : std_logic_vector(1 downto 0);

begin
temp := input;
status := arith & op;

for i in 1 to amount loop
    if status = "00" then                   --Logic Left
        temp := temp(lenght -2 downto 0) & '0';
    elsif status = "01" then                --Logic Right
        temp := '0' & temp(lenght -1 downto 1);
    elsif status = "11" then               --Arithmetic Right
        temp2 := temp(0);
        temp  := temp2 & temp(lenght -1 downto 1);
    end if;
end loop;
result := temp;
return result;
end function;

begin

sh <= shiftting(d, TO_INTEGER(unsigned(sa)), right, aright);

end Behavioral;
