library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity andGate_tb is
end;

architecture bench of andGate_tb is

  component andGate
      Port (
          a : in std_logic := '0';
          b : in std_logic := '0';
          s : out std_logic := '0';
          c : out std_logic := '0'
      );
  end component;

  signal a: std_logic := '0';
  signal b: std_logic := '0';
  signal s: std_logic := '0';
  signal c: std_logic := '0' ;

begin

  uut: andGate port map ( a => a,
                          b => b,
                          s => s,
                          c => c );

  stimulus: process
  begin
  a <= '0';
  b <= '0';
  wait for 10ns;
  a <= '0';
  b <= '1';
  wait for 10ns;
  a <= '1';
  b <= '0';
  wait for 10ns;
  a <= '1';
  b <= '1';
  wait for 10ns;
    wait;
  end process;


end;