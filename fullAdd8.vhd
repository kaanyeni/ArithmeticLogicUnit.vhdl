library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fullAdd8 is
  Port ( 
  in1_8   :   in   std_logic_vector(7 downto 0);
  in2_8   :   in   std_logic_vector(7 downto 0);
  c_in_8  :   in   std_logic;
  sum_8   :   out  std_logic_vector(7 downto 0);
  c_out_8 :   out  std_logic
  );
end fullAdd8;

architecture Behavioral of fullAdd8 is

component fullAdd4 is
  Port ( 
  in1_4   :   in   std_logic_vector(3 downto 0);
  in2_4   :   in   std_logic_vector(3 downto 0);
  c_in_4  :   in   std_logic;
  sum_4   :   out  std_logic_vector(3 downto 0);
  c_out_4 :   out  std_logic
  );
end component;

signal s0_8 : std_logic_vector(3 downto 0);
signal s1_8 : std_logic_vector(3 downto 0);

signal c_out0_8 : std_logic;
signal c_out1_8 : std_logic;

begin

zero : fullAdd4 port map(in1_8(3 downto 0), in2_8(3 downto 0), c_in_8, s0_8, c_out0_8);
two  : fullAdd4 port map(in1_8(7 downto 4), in2_8(7 downto 4), c_out0_8, s1_8, c_out1_8);

sum_8   <= s1_8 & s0_8;
c_out_8 <= c_out1_8;

end Behavioral;