library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux3 is
  Port (
  a        : in  std_logic_vector(31 downto 0):= X"00001111";
  b        : in  std_logic_vector(31 downto 0):= X"01010101";
  aluc     : in  std_logic_vector(3 downto 0) := "0000";
  mux1_out : out std_logic_vector(31 downto 0)
  );
end mux3;

architecture Behavioral of mux3 is

----------------------------------------------------
function mux(
    mux1 : std_logic_vector(31 downto 0);
    mux2 : std_logic_vector(31 downto 0);
    mux3 : std_logic_vector(31 downto 0);
    mux4 : std_logic_vector(31 downto 0);
    aluc : std_logic_vector(1 downto 0)
)return std_logic_vector is
variable mux_out : std_logic_vector(31 downto 0);
variable temp    : std_logic_vector(31 downto 0);

begin

if aluc    = "00" then
    mux_out := mux1(31 downto 0);
elsif aluc = "01" then
    mux_out := mux2(31 downto 0);
elsif aluc = "10" then
    mux_out := mux3(31 downto 0);
elsif aluc = "11" then
    mux_out := mux4(31 downto 0);
end if;

return mux_out;
end function;
----------------------------------------------------
component addSub32 is
  Port ( 
  a   :   in   std_logic_vector;
  b   :   in   std_logic_vector;
  sub :   in   std_logic_vector ;
  s   :   out  std_logic_vector
  );
end component;

----------------------------------------------------
component mux1 is
  Port (
  a        : in  std_logic_vector;
  b        : in  std_logic_vector;
  aluc     : in  std_logic_vector;
  mux1_out : out std_logic_vector
  );
end component;

----------------------------------------------------
component mux2 is
  Port (
  a        : in  std_logic_vector;
  b        : in  std_logic_vector ;
  aluc     : in  std_logic_vector;
  mux2_out : out std_logic_vector
  );
end component;

----------------------------------------------------
component shift is
  Generic (
    lenght : integer := 32
    );
   Port (
   sa     : in std_logic_vector;           
   d      : in std_logic_vector;  
   right  : in std_logic ;                              
   aright : in std_logic;                               
   sh     : out std_logic_vector     
   ); 
end component;

----------------------------------------------------
signal addSub32_o : std_logic_vector(31 downto 0);
signal mux_1_o : std_logic_vector(31 downto 0);
signal mux_2_o : std_logic_vector(31 downto 0);
signal shift_o : std_logic_vector(31 downto 0);

begin

mux1_o : addSub32 port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0),addSub32_o);
mux2_o : mux1     port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0), mux_1_o);
mux3_o : mux2     port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0), mux_2_o);
mux4_o : shift    port map(a(4  downto 0), b(31 downto 0),aluc(2), aluc(3), shift_o);

mux1_out <= mux(addSub32_o, mux_1_o, mux_2_o, shift_o, aluc(1 downto 0));

end Behavioral;
