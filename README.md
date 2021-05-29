# ArithmeticLogicUnit.vhdl
Kodun Yaptiklari: 32 bitlik bir Arihmetic Logic Unit (ALU) fonksiyonudur. Yapabildigi ozellikler ise ADD SUB AND OR XOR LUI SLL SRL SRA'dir.
Kod Aciklamalari:
FULL ADDER
a)Tasarım Yakla¸sımım
Genel tasarımıma ilk olarak ’Fulladder’ yaparak ba¸sladım. Giri¸sinden alaca˘gı 2 biti
toplayarak ¸cıkı¸sında carry ve sonucumuzu d¨ond¨urecek.
b)Kodun C¸alı¸sma Mantı˘gı
Toplama i¸slemini Karnaugh map ile incelersek toplam bitinin, giri¸steki 2 bit ile ve
carry bitimiz ile xor’lanması oldu˘gunu g¨or¨ur¨uz. Tasarımıma da bundan yararlanarak i¸slem
yaptım. Aynı mantık carry bitini bulmak i¸cinde ge¸cerlidir.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fullAdd is
Port (
a : in std_logic;
b : in std_logic;
c_in : in std_logic;
1s : out std_logic;
c_out : out std_logic
);
end fullAdd;
architecture Behavioral of fullAdd is
begin
s <= a xor b xor c_in;
c_out <= (a and b) or (a and c_in) or (b and c_in);
end Behavioral;
---------------------------------------------------
---------------------------------------------------
4 Bitlik FULL ADDER
a)Tasarım Yakla¸sımım
Tasarlamı¸s oldu˘gum bir bitlik toplama i¸slemini component olarak kullanarak 4 bitlik
toplama i¸slemini yapacak kodu tasarladım.
b)Kodun C¸alı¸sma Mantı˘gı
Giri¸sten alınacak olan d¨ort bitlik veriyi, carry bilgisini de alarak bir bitlik
toplayıcıya tek tek atacak ve 4 bitlik toplam verisi ile carry bilgisini d¨ond¨urecektir.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fullAdd4 is
Port (
in1_4 : in std_logic_vector(3 downto 0);
in2_4 : in std_logic_vector(3 downto 0);
c_in_4 : in std_logic;
sum_4 : out std_logic_vector(3 downto 0);
c_out_4 : out std_logic
);
end fullAdd4;
architecture Behavioral of fullAdd4 is
component fullAdd is
Port (
a : in std_logic;
b : in std_logic;
c_in : in std_logic;
2s : out std_logic;
c_out : out std_logic
);
end component;
signal s0 : std_logic;
signal s1 : std_logic;
signal s2 : std_logic;
signal s3 : std_logic;
signal c_out0 : std_logic;
signal c_out1 : std_logic;
signal c_out2 : std_logic;
signal c_out3 : std_logic;
begin
zero : fullAdd port map(in1_4(0),in2_4(0),c_in_4 ,s0,c_out0);
one : fullAdd port map(in1_4(1),in2_4(1),c_out0,s1,c_out1);
two : fullAdd port map(in1_4(2),in2_4(2),c_out1,s2,c_out2);
three : fullAdd port map(in1_4(3),in2_4(3),c_out2,s3,c_out3);
sum_4 <= s3 & s2 & s1 & s0;
c_out_4 <= c_out3;
end Behavioral;
8 Bitlik FULL ADDER
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
Tasarlamı¸s oldu˘gum d¨ort bitlik toplama i¸slemini component olarak kullanarak 8 bitlik
toplama i¸slemini yapacak kodu tasarladım.
b)Kodun C¸alı¸sma Mantı˘gı
D¨ort bit ile aynı mantıkta ¸calı¸smaktadır.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fullAdd8 is
Port (
in1_8 : in std_logic_vector(7 downto 0);
in2_8 : in std_logic_vector(7 downto 0);
c_in_8 : in std_logic;
sum_8 : out std_logic_vector(7 downto 0);
3c_out_8 : out std_logic
);
end fullAdd8;
architecture Behavioral of fullAdd8 is
component fullAdd4 is
Port (
in1_4 : in std_logic_vector(3 downto 0);
in2_4 : in std_logic_vector(3 downto 0);
c_in_4 : in std_logic;
sum_4 : out std_logic_vector(3 downto 0);
c_out_4 : out std_logic
);
end component;
signal s0_8 : std_logic_vector(3 downto 0);
signal s1_8 : std_logic_vector(3 downto 0);
signal c_out0_8 : std_logic;
signal c_out1_8 : std_logic;
begin
zero : fullAdd4 port map(in1_8(3 downto 0), in2_8(3 downto 0), c_in_8, s0_8, c_out0_8);
two : fullAdd4 port map(in1_8(7 downto 4), in2_8(7 downto 4), c_out0_8, s1_8, c_out1_8);
sum_8 <= s1_8 & s0_8;
c_out_8 <= c_out1_8;
end Behavioral;
32 Bitlik FULL ADDER
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
Tasarlamı¸s oldu˘gum sekiz bitlik toplama i¸slemini component olarak kullanarak 32 bitlik
toplama i¸slemini yapacak kodu tasarladım.
b)Kodun C¸alı¸sma Mantı˘gı
Sekiz bit toplama i¸slemini yapan ile aynı mantıkta ¸calı¸smaktadır. D¨ort adet sekiz bit
kullanmakta.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
4entity fullAdd32 is
Port (
in1_32 : in std_logic_vector(31 downto 0);
in2_32 : in std_logic_vector(31 downto 0);
sum_32 : out std_logic_vector(31 downto 0);
c_out_32 : out std_logic
);
end fullAdd32;
architecture Behavioral of fullAdd32 is
component fullAdd8 is
Port (
in1_8 : in std_logic_vector(7 downto 0);
in2_8 : in std_logic_vector(7 downto 0);
c_in_8 : in std_logic;
sum_8 : out std_logic_vector(7 downto 0);
c_out_8 : out std_logic
);
end component;
signal c_in0_32 : std_logic := ’0’;
signal s0_32 : std_logic_vector(7 downto 0);
signal s1_32 : std_logic_vector(7 downto 0);
signal s2_32 : std_logic_vector(7 downto 0);
signal s3_32 : std_logic_vector(7 downto 0);
signal c_out0_32 : std_logic;
signal c_out1_32 : std_logic;
signal c_out2_32 : std_logic;
signal c_out3_32 : std_logic;
begin
zero : fullAdd8 port map(in1_32(7 downto 0) , in2_32(7 downto 0) , c_in0_32, s0_32, c_out
one : fullAdd8 port map(in1_32(15 downto 8) , in2_32(15 downto 8) , c_out0_32, s1_32, c_ou
two : fullAdd8 port map(in1_32(23 downto 16), in2_32(23 downto 16), c_out1_32, s2_32, c_out2
three : fullAdd8 port map(in1_32(31 downto 24), in2_32(31 downto 24), c_out2_32, s3_32, c_o
sum_32 <= s3_32 & s2_32 & s1_32 & s0_32 ;
c_out_32 <= c_out3_32;
end Behavioral;
532 Bitlik ADD SUB KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
Tasarlamı¸s oldu˘gum 32 bitlik toplama i¸slemini referans alarak, toplama ve ¸cıkarma
yapan kodumu tasarladım. C¸ıkarma i¸slemiminin aslında bir ile xor’unun alınması ve 1
eklenmesiyle ¸cıkan sonucun direk toplama yapılması bize farkı vermektedir.
b)Kodun C¸alı¸sma Mantı˘gı
a - b = a + (b xor 1) + 1 yukarıda a¸cıkladı˘gım mantı˘gı kullandım. Sub bilgisi 1 ise
fark alacak, 0 ise toplama yapacaktır. E˘ger sub bilgisi 1 ise b’yi 1 ile xor’layıp
bx’e atadım. 1 toplamamız gereken i¸slemi ise carry bitini g¨onderdi˘gimiz yerden
yaptım yani carry0 de˘geri 1 ise 1 ile toplama i¸slemi ger¸cekle¸smi¸s olacaktır. Zaten
sub bilgisi de 1 olursa oldu˘gu i¸cin carry0 yerine direk sub bilgisini g¨ondererek fark alma
ve toplama i¸slemini ger¸cekle¸stirdim.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity addSub32 is
Port (
a : in std_logic_vector(31 downto 0) := X"00000010";
b : in std_logic_vector(31 downto 0) := X"00000001";
sub : in std_logic_vector(3 downto 0) := "0100";
s : out std_logic_vector(31 downto 0)
);
end addSub32;
architecture Behavioral of addSub32 is
component fullAdd8 is
Port (
in1_8 : in std_logic_vector(7 downto 0);
in2_8 : in std_logic_vector(7 downto 0);
c_in_8 : in std_logic;
sum_8 : out std_logic_vector(7 downto 0);
c_out_8 : out std_logic
);
end component;
signal c_in0_32 : std_logic := ’0’;
signal s0_32 : std_logic_vector(7 downto 0);
signal s1_32 : std_logic_vector(7 downto 0);
signal s2_32 : std_logic_vector(7 downto 0);
signal s3_32 : std_logic_vector(7 downto 0);
6signal c_out0_32 : std_logic;
signal c_out1_32 : std_logic;
signal c_out2_32 : std_logic;
signal c_out3_32 : std_logic;
signal bx : std_logic_vector(31 downto 0) := (others => ’0’);
signal ones : std_logic_vector(31 downto 0) := (others => ’1’);
signal zeros : std_logic_vector(31 downto 0) := (others => ’0’);
signal aluc_2 : std_logic;
begin
with sub select
bx <= b xor ones when "0100",
b xor zeros when "0000",
X"00000000" when others;
zero : fullAdd8 port map(a(7 downto 0) , bx(7 downto 0) , sub(2 , s0_32, c_out0_32);
one : fullAdd8 port map(a(15 downto 8) , bx(15 downto 8) , c_out0_32, s1_32, c_out1_32);
two : fullAdd8 port map(a(23 downto 16), bx(23 downto 16), c_out1_32, s2_32, c_out2_32);
three : fullAdd8 port map(a(31 downto 24), bx(31 downto 24), c_out2_32, s3_32, c_out3_32);
s <= s3_32 & s2_32 & s1_32 & s0_32 ;
end Behavioral;
SHIFT KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
sa bilgisi bize kaydırma miktarını veren 5 bitlik bir input. Kodumuzda giri¸s sinyali
bu de˘gere g¨ore logic olarak sa˘ga veya sola ayrıca aritmetik olarak sa˘ga kayma i¸slemi
ger¸cekle¸stirecektir. Aritmetik olması u¸ctaki de˘gerlerin kaybolmadan soldan devam etmesidir.
b)Kodun C¸alı¸sma Mantı˘gı
Numeric k¨ut¨uphanesini kullanmamın sebebi vekt¨or formdaki bir de˘geri integer
¸cevirmek i¸cin. Generic i¸cide uzunluk belirtmemin sebebi derste ¨orneklerde ¨oyle yaptı˘gımız
i¸cin. ¨ Odevde uzunluk zaten 32 olarak belirtilmi¸s oldu˘gu i¸cin gerekli bir durum oldu˘gunu
d¨u¸s¨unm¨uyorum.
Kaydırma i¸slerini belirtilen miktarı tam sayıya ¸cevirerek bir loop d¨ong¨us¨u i¸cinde tek
tek kaydırmaktadır.
Kaydırma y¨on¨u ve y¨ontemi bilgisini status adlı bir de˘gi¸skende 2 bitlik bir forma ¸cevirip
kontrol¨un¨u o ¸sekilde yaptım.
---------------------------------------------------
7library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity shift is
Generic (
lenght : integer := 32
);
Port (
sa : in std_logic_vector(4 downto 0) := "00100"; --a input value
d : in std_logic_vector(lenght -1 downto 0) := X"00001000"; --b input value
right : in std_logic := ’0’; --aluc 2
aright : in std_logic; --aluc 3
sh : out std_logic_vector(lenght -1 downto 0) --output
);
end shift;
architecture Behavioral of shift is
function shiftting(
input : std_logic_vector(lenght -1 downto 0);
amount : integer;
op : std_logic;
arith : std_logic
) return std_logic_vector is
variable temp : std_logic_vector(31 downto 0);
variable temp2 : std_logic;
variable result : std_logic_vector(31 downto 0);
variable status : std_logic_vector(1 downto 0);
begin
temp := input;
status := arith & op;
for i in 1 to amount loop
if status = "00" then --Logic Left
temp := temp(lenght -2 downto 0) & ’0’;
elsif status = "01" then --Logic Right
temp := ’0’ & temp(lenght -1 downto 1);
elsif status = "11" then --Arithmetic Right
temp2 := temp(0);
temp := temp2 & temp(lenght -1 downto 1);
end if;
end loop;
result := temp;
return result;
8end function;
begin
sh <= shiftting(d, TO_INTEGER(unsigned(sa)), right, aright);
end Behavioral;
MUX2(LUI ve XOR) KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
MUX’un ¸calı¸sma mantı˘gı dı¸sarıdan gelen index verisine g¨ore dı¸sarı 0. veya 1.
¸cıkı¸sı vermektir. 2. olarak aldı˘gım MUX’un giri¸slerinde bir LUI ve XOR vardı.
LUI LSB’16 yı MSB’16 ya atamaktır. Bu tasarımda MUX, XOR, ve LUI tek bir component
olarak d¨u¸s¨unerek tasarladım.
b)Kodun C¸alı¸sma Mantı˘gı
a ve b XOR’lanarak bir sinyal i¸cinde tutulmakta. Aynı ¸sekilde b sinyali
sola kaydırma y¨ontemini kullanarak LUI fonksiyonu i¸cinde yapılıp bir sinyalde tutulmakta.
En son bu sinyaller MUX fonksiyonu i¸cinde aluc de˘gerine g¨ore karar verilip ¸cıktı alınıyor.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2 is
Port (
a : in std_logic_vector(31 downto 0) := X"00110011" ;
b : in std_logic_vector(31 downto 0) := X"00001100";
aluc : in std_logic_vector(3 downto 0) := "0000";
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
9--------------------------------------------------
function LUI(
input : std_logic_vector(31 downto 0)
) return std_logic_vector is
variable temp : std_logic_vector(15 downto 0) := X"0000";
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
variable temp : std_logic_vector(31 downto 0);
begin
if aluc = ’0’ then
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
10MUX1(AND ve OR) KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
MUX’un ¸calı¸sma mantı˘gı dı¸sarıdan gelen index verisine g¨ore dı¸sarı 0. veya 1.
¸cıkı¸sı vermektir. 2. olarak aldı˘gım MUX’un giri¸slerinde bir AND ve OR vardı.Bu tasarımda
MUX, OR, ve AND tek bir component olarak d¨u¸s¨unerek tasarladım.
b)Kodun C¸alı¸sma Mantı˘gı
AND ve OR birer fonksiyon i¸cinde tanımlı ve geri d¨on¨u¸sleri yukarıdaki ile aynı
mantıkta ¸calı¸san bir MUX ile kararı verilip, geri sinyali d¨ond¨urmekte.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux1 is
Port (
a : in std_logic_vector(31 downto 0):= X"00001111";
b : in std_logic_vector(31 downto 0):= X"01010101";
aluc : in std_logic_vector(3 downto 0) := "0000";
mux1_out : out std_logic_vector(31 downto 0)
);
end mux1;
architecture Behavioral of mux1 is
function mux(
mux1 : std_logic_vector(31 downto 0);
mux2 : std_logic_vector(31 downto 0);
aluc : std_logic
)return std_logic_vector is
variable mux_out : std_logic_vector(31 downto 0);
variable temp : std_logic_vector(31 downto 0);
begin
if aluc = ’0’ then
mux_out := mux1(31 downto 0);
else
mux_out := mux2(31 downto 0);
end if;
return mux_out;
end function;
--------------------------------------------------
11signal x1 : std_logic_vector(31 downto 0);
signal x2 : std_logic_vector(31 downto 0);
begin
x1 <= a and b;
x2 <= a or b;
mux1_out <= mux(x1,x2,aluc(2));
end Behavioral;
MUX3(ADDSUB32,MUX1,MUX2 ve SHIFT) KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
B¨ut¨un ¸cıkı¸sları tek bir MUX’ta birle¸stirip kullandım. B¨ut¨un giri¸sleri
component olarak tanımladım.
b)Kodun C¸alı¸sma Mantı˘gı
Yukarıdaki MUX’un mantı˘gı ile aynı sadece giri¸sler artık direk component olarak
tasarladı˘gım ¸cıkı¸slardan gelmekte. C¸ıkı¸sın karar verilmesi i¸cin ise 0 ve 1 bilgisini
else if fonksiyonu i¸cinde kullanarak kararını verdirdim.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux3 is
Port (
a : in std_logic_vector(31 downto 0):= X"00001111";
b : in std_logic_vector(31 downto 0):= X"01010101";
aluc : in std_logic_vector(3 downto 0):= "0000";
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
variable temp : std_logic_vector(31 downto 0);
12begin
if aluc = "00" then
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
a : in std_logic_vector;
b : in std_logic_vector;
sub : in std_logic_vector ;
s : out std_logic_vector
);
end component;
----------------------------------------------------
component mux1 is
Port (
a : in std_logic_vector;
b : in std_logic_vector;
aluc : in std_logic_vector;
mux1_out : out std_logic_vector
);
end component;
----------------------------------------------------
component mux2 is
Port (
a : in std_logic_vector;
b : in std_logic_vector ;
aluc : in std_logic_vector;
mux2_out : out std_logic_vector
);
end component;
----------------------------------------------------
component shift is
Generic (
lenght : integer := 32
13);
Port (
sa : in std_logic_vector;
d : in std_logic_vector;
right : in std_logic ;
aright : in std_logic;
sh : out std_logic_vector
);
end component;
----------------------------------------------------
signal addSub32_o : std_logic_vector(31 downto 0);
signal mux_1_o : std_logic_vector(31 downto 0);
signal mux_2_o : std_logic_vector(31 downto 0);
signal shift_o : std_logic_vector(31 downto 0);
begin
mux1_o : addSub32 port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0), addSub32_o);
mux2_o : mux1 port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0), mux_1_o) ;
mux3_o : mux2 port map(a(31 downto 0), b(31 downto 0),aluc(3 downto 0), mux_2_o) ;
mux4_o : shift port map(a(4 downto 0), b(31 downto 0),aluc(2), aluc(3), shift_o) ;
mux1_out <= mux(addSub32_o, mux_1_o, mux_2_o, shift_o, aluc(1 downto 0));
end Behavioral;
ALU KODUM
---------------------------------------------------
---------------------------------------------------
a)Tasarım Yakla¸sımım
En son ana kodum ALU i¸cinde tasarladım. a,b ve aluc sinyallerini kullanıcıdan alıp
MUX3 olarak belirtti˘gim componentden gelen ¸cıkı¸sı vermektedir. Zero flag, MUX ¸cıkı¸sı
0 ise 1 de˘gerini vermekte.
b)Kodun C¸alı¸sma Mantı˘gı
Zero flag i¸slemi bir fonksiyon i¸cinde, giri¸s de˘gerini integer ¸cevirip, sıfır olup
olmadı˘gını kontrol eden bir i¸slem. _ Integer ¸cevirme i¸slemini numeric k¨ut¨uphanesini
kullanarak yaptım.
14---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU is
Port (
a : in std_logic_vector(31 downto 0):= X"00001111";
b : in std_logic_vector(31 downto 0):= X"01010101";
aluc : in std_logic_vector(3 downto 0) := "0000";
z : out std_logic;
r : out std_logic_vector(31 downto 0)
);
end ALU;
architecture Behavioral of ALU is
---------------------------------------------
component mux3 is
Port (
a : in std_logic_vector;
b : in std_logic_vector;
aluc : in std_logic_vector;
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
op := ’1’;
else
op := ’0’;
end if;
return op;
end function;
---------------------------------------------
15Signal out_value : std_logic_vector(31 downto 0);
---------------------------------------------
begin
value : mux3 port map(a(31 downto 0), b(31 downto 0), aluc(3 downto 0), out_value(31 downto
z <= zero_flag(out_value);
r <= out_value;
end Behavioral;
