library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity halfAdder is
    Port (
        a : in std_logic := '0';
        b : in std_logic := '0';
        s : out std_logic := '0';
        c : out std_logic := '0'
    );
end halfAdder;

architecture Behavioral of halfAdder is

begin

s <= a xor b;
c <= a and b;

end Behavioral;