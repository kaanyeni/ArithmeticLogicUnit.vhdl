library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity addSub32 is
  Port ( 
  a   :   in   std_logic_vector(31 downto 0) := X"00000010";
  b   :   in   std_logic_vector(31 downto 0) := X"00000001";
  sub :   in   std_logic_vector(3 downto 0)  := "0100";
  s   :   out  std_logic_vector(31 downto 0)
  );
end addSub32;

architecture Behavioral of addSub32 is

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

signal bx : std_logic_vector(31 downto 0) :=  (others => '0');
signal ones : std_logic_vector(31 downto 0) :=  (others => '1');
signal zeros : std_logic_vector(31 downto 0) :=  (others => '0');


signal aluc_2 : std_logic;

begin

with sub select
    bx <= b xor ones when "0100",
          b xor zeros when "0000",
          X"00000000" when others;      

zero   : fullAdd8 port map(a(7 downto 0)  , bx(7 downto 0)  , sub(2)          , s0_32, c_out0_32);
one    : fullAdd8 port map(a(15 downto 8) , bx(15 downto 8) , c_out0_32, s1_32, c_out1_32);
two    : fullAdd8 port map(a(23 downto 16), bx(23 downto 16), c_out1_32, s2_32, c_out2_32);
three  : fullAdd8 port map(a(31 downto 24), bx(31 downto 24), c_out2_32, s3_32, c_out3_32);

s   <= s3_32 & s2_32 & s1_32 & s0_32 ;

end Behavioral;
