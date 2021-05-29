library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fullAdd32 is
  Port ( 
  in1_32   :   in   std_logic_vector(31 downto 0);
  in2_32   :   in   std_logic_vector(31 downto 0);
  sum_32   :   out  std_logic_vector(31 downto 0);
  c_out_32 :   out  std_logic
  );
end fullAdd32;

architecture Behavioral of fullAdd32 is

component fullAdd8 is
  Port ( 
  in1_8   :   in   std_logic_vector(7 downto 0);
  in2_8   :   in   std_logic_vector(7 downto 0);
  c_in_8  :   in   std_logic;
  sum_8   :   out  std_logic_vector(7 downto 0);
  c_out_8 :   out  std_logic
  );
end component;

signal c_in0_32 : std_logic := '0';

signal s0_32 : std_logic_vector(7 downto 0);
signal s1_32 : std_logic_vector(7 downto 0);
signal s2_32 : std_logic_vector(7 downto 0);
signal s3_32 : std_logic_vector(7 downto 0);

signal c_out0_32 : std_logic;
signal c_out1_32 : std_logic;
signal c_out2_32 : std_logic;
signal c_out3_32 : std_logic;

begin

zero  : fullAdd8 port map(in1_32(7 downto 0)  , in2_32(7 downto 0)  , c_in0_32, s0_32, c_out0_32);
one   : fullAdd8 port map(in1_32(15 downto 8) , in2_32(15 downto 8) , c_out0_32, s1_32, c_out1_32);
two : fullAdd8 port map(in1_32(23 downto 16), in2_32(23 downto 16), c_out1_32, s2_32, c_out2_32);
three  : fullAdd8 port map(in1_32(31 downto 24), in2_32(31 downto 24), c_out2_32, s3_32, c_out3_32);

sum_32   <= s3_32 & s2_32 & s1_32 & s0_32 ;
c_out_32 <= c_out3_32;

end Behavioral;
