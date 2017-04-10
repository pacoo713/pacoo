library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity Master is
  Port ( CLK   : in STD_LOGIC;
         BTNC  : in STD_LOGIC;
         BTNL  : in STD_LOGIC;
         BTNR  : in STD_LOGIC;
         reset : in STD_LOGIC;
         LED   : out STD_LOGIC;
         CA    : out STD_LOGIC;
         CB    : out STD_LOGIC;
         CC    : out STD_LOGIC;
         CD    : out STD_LOGIC;
         CE    : out STD_LOGIC;
         CF    : out STD_LOGIC;
         CG    : out STD_LOGIC;
         DP    : out STD_LOGIC;
         AN    : out Std_Logic_Vector (7 downto 0);
         PULSE : out STD_LOGIC);

end Master;

--------------------------------------------------------------------------------

architecture Behavioral of Master is

-- DCC Central component
component sequencer is
  Port (
    clk      : in  STD_LOGIC;
    go       : in  STD_LOGIC := '0';
    addr     : in  Std_Logic_Vector (7 downto 0);
    feat     : in  Std_Logic_Vector (7 downto 0);
    speed    : in  Std_Logic_Vector (7 downto 0);
    which    : in  Std_logic ;
    idle     : in  Std_logic := '0';    
    done     : out  Std_logic;
    pulse    : out STD_LOGIC := '0'
    );      
end component;


-- IHM component
component control_seg is
  Port ( CLK   : in STD_LOGIC;
         reset : in STD_LOGIC;
         CA    : out STD_LOGIC;
         CB    : out STD_LOGIC;
         CC    : out STD_LOGIC;
         CD    : out STD_LOGIC;
         CE    : out STD_LOGIC;
         CF    : out STD_LOGIC;
         CG    : out STD_LOGIC;
         DP    : out STD_LOGIC;
         AN    : out STD_LOGIC_VECTOR (7 downto 0);
         ADD   : out STD_LOGIC_VECTOR (7 downto 0);
         AIG   : out STD_LOGIC_VECTOR (7 downto 0);
         FEAT  : out STD_LOGIC_VECTOR (7 downto 0);
         SPD   : out STD_LOGIC_VECTOR (7 downto 0);
         -- chose setting
         BTNL  : in STD_LOGIC;
         -- increment setting value
         BTNR  : in STD_LOGIC
         );
end component;


component div_clock is
  Port (
    -- 100 MHz signla
    clk : in STD_LOGIC;
    -- 1 MHz signal
    div_clock : out STD_LOGIC);
end component;


signal address_send : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
signal feat_send    : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal speed_send   : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

signal which : STD_LOGIC;
signal idle  : STD_LOGIC := '0';

signal clk1M : STD_LOGIC := '0';

signal go   : STD_LOGIC := '0';
signal done : STD_LOGIC := '0';

signal address   : STD_LOGIC_VECTOR (7 downto 0);
signal feat      : STD_LOGIC_VECTOR (7 downto 0);
signal speed     : STD_LOGIC_VECTOR (7 downto 0);
signal aiguilage : STD_LOGIC_VECTOR (7 downto 0);


signal tmp : integer;

-- for the go signal with a period of ~55 ms 
signal cpt : integer range 0 to 550000 := 0;

--------------------------------------------------------------------------------


begin

 sequencer_1: sequencer
    port map (
      clk     => clk1M,
      go      => go,
      addr    => address_send,
      feat    => feat_send,
      speed   => speed_send,
      which   => which,
      idle    => idle,
      done    => done,
      pulse   => PULSE
      );

 control_seg_1: control_seg
    port map (
      CLK     => CLK,
      reset   => reset,
      CA      => CA,
      CB      => CB,
      CC      => CC,
      CD      => CD,
      CE      => CE,
      CF      => CF,
      CG      => CG,
      DP      => DP,
      AN      => AN,
      ADD     => address,
      AIG     => aiguilage,
      FEAT    => feat,
      SPD     => speed,
      BTNL    => BTNL,
      BTNR    => BTNR
      
      );

 div_clock_1: div_clock
    port map (
      clk         => CLK,
      div_clock   => clk1M
      );

--
--  TODO LIST :
--
--
-- envoyer 4 trames en continues séparée par 400 us (done)
-- rajouter gestion de reset qui remet address et data_send au valeur initiales
-- pareil pour cpt (done)
--
-- a achaque appui sur btc mettre ces valeur :
-- dans address_send <= ADD or AIG
-- dans data_send <= FEAT or SPD
--
-- et je crois que c'est tout ?

   --LED <= PULSE;
 
 process (CLK,reset)
 
   variable tmp1 : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
   variable tmp2 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
   variable tmp3 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
   
 
 begin

   -- RESET gestion
   if RESET = '1' then
     cpt          <= 0;
     address_send <= "11111111";
     feat_send    <= "00000000";
     speed_send   <= "10000000";
     go           <= '1';
     idle         <= '1';
     which        <= '0';
     tmp <= 0;
     
   -- end if reset
   end if;
   
   if rising_edge (CLK) then 
   
      address_send <= tmp1;
      feat_send    <= tmp2;
      speed_send   <= tmp3;
      
     if BTNC = '1' then
       tmp1   := address;-- or aiguilage;
       tmp2   := feat;
       tmp3   := speed;
       idle   <= '1';
       --which  <= '0';
       tmp    <= 0;
     -- end ifbtnc
     end if;   
   -- rising edge
   end if;
    
   if rising_edge (clk1M) then

     if done = '1' then 
       cpt <= cpt + 1;
     end if;
     
     go <= '0';
     
     -- send a periodic go signal to generate à pulse
     if cpt = 399 then
       go <= '1';
       cpt <= 0;

       if tmp > 2 then
         tmp <= 0;
       else
         tmp <= tmp + 1;
       end if;
  

       if tmp = 0 or tmp = 3 then
         idle <= '1';

       else
         idle <= '0';

         if which = '0' then
           which <= '1';
         else
           which <= '0';
         end if;

       end if;


       
  
       
     -- end if cpt
     end if;
     
   end if;
   
 end process;
 
 
end Behavioral;
