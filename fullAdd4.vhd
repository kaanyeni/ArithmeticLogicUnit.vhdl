library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fullAdd4 is
  Port ( 
  in1_4   :   in   std_logic_vector(3 downto 0);
  in2_4   :   in   std_logic_vector(3 downto 0);
  c_in_4  :   in   std_logic;
  sum_4   :   out  std_logic_vector(3 downto 0);
  c_out_4 :   out  std_logic
  );
end fullAdd4;

architecture Behavioral of fullAdd4 is

component fullAdd is
    Port (
    a :     in  std_logic;
    b :     in  std_logic;
    c_in :  in  std_logic;
    s :     out std_logic;
    c_out : out std_logic
    );
end component;

signal s0     : std_logic;
signal s1     : std_logic;
signal s2     : std_logic;
signal s3     : std_logic;

signal c_out0 : std_logic;
signal c_out1 : std_logic;
signal c_out2 : std_logic;
signal c_out3 : std_logic;

begin

zero  : fullAdd port map(in1_4(0),in2_4(0),c_in_4 ,s0,c_out0);
one   : fullAdd port map(in1_4(1),in2_4(1),c_out0,s1,c_out1);
two   : fullAdd port map(in1_4(2),in2_4(2),c_out1,s2,c_out2);
three : fullAdd port map(in1_4(3),in2_4(3),c_out2,s3,c_out3);

sum_4   <= s3 & s2 & s1 & s0;
c_out_4 <= c_out3;

end Behavioral;
