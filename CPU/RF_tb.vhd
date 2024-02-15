library ieee;
use ieee.std_logic_1164.all;

entity RF_tb is
end entity RF_tb;

architecture archi_RF_tb of RF_tb is

	component RF is
		port (
			clk : in std_logic;
			rst : in std_logic;
			en : in std_logic;
			Addr : in std_logic_vector(2 downto 0); -- 3 bits d'adresse pour 8 registres
			Input : in std_logic_vector(7 downto 0);
			AddrRA : in std_logic_vector(2 downto 0);
			AddrRB : in std_logic_vector(2 downto 0);
			rw : in std_logic; -- rw='1' write
			OutA : out std_logic_vector(7 downto 0);
			OutB : out std_logic_vector(7 downto 0)
		);
	end component RF;
	
	signal tb_clk : std_logic := '0';
	signal tb_rst : std_logic := '0';
	signal tb_en : std_logic;
	signal tb_Addr : std_logic_vector(2 downto 0); -- 3 bits d'adresse pour 8 registres
	signal tb_Input : std_logic_vector(7 downto 0);
	signal tb_AddrRA : std_logic_vector(2 downto 0);
	signal tb_AddrRB : std_logic_vector(2 downto 0);
	signal tb_rw : std_logic; -- rw='1' write
	signal tb_OutA : std_logic_vector(7 downto 0);
	signal tb_OutB : std_logic_vector(7 downto 0);
	
begin

	inst_RF : component RF
		port map(
			clk => tb_clk,
			rst => tb_rst,
			en => tb_en,
			Addr => tb_Addr,
			Input => tb_Input,
			AddrRA => tb_AddrRA,
			AddrRB => tb_AddrRB,
			rw => tb_rw,
			outA => tb_outA,
			outB => tb_outB
		);
	
	tb_clk <= not tb_clk after 10 ns;
	
	stimulus: process
	begin
		wait for 5 ns;
		tb_rst <= '1';
		wait for 5 ns;
		tb_rst <= '0';
		wait for 20 ns;
		tb_AddrRA <= "000";
		tb_AddrRB <= "001";
		wait for 50 ns;
		tb_en <= '1';
		tb_Addr <= "000";
		tb_Input <= "00000001";
		tb_rw <= '1';
		wait for 50 ns;
		tb_Addr <= "001";
		tb_Input <= "00000010";
		wait;
	end process;

end architecture archi_RF_tb;