library ieee;
use ieee.std_logic_1164.all;

entity ROM_tb is
end entity ROM_tb;

architecture archi_ROM_tb of ROM_tb is

	component ROM is
		port(
			en			:	in std_logic;
			clk		:	in std_logic;
			rst		:	in std_logic;
			Adress	:	in std_logic_vector(7 downto 0);
			Data_out :	out std_logic_vector(15 downto 0)
		);
	end component ROM;
	
	signal tb_clk : std_logic := '0';
	signal tb_rst : std_logic := '0';
	signal tb_en : std_logic;
	signal tb_Adress : std_logic_vector(7 downto 0);
	signal tb_Data_out : std_logic_vector(15 downto 0);
	
begin

	inst_ROM : component ROM
		port map(
			clk => tb_clk,
			rst => tb_rst,
			en => tb_en,
			Adress => tb_Adress,
			Data_out => tb_Data_out
		);
	
	tb_clk <= not tb_clk after 10 ns;
	
	stimulus: process
	begin
		wait for 5 ns;
		tb_rst <= '1';
		wait for 5 ns;
		tb_rst <= '0';
		wait for 20 ns;
		tb_en <= '1';
		tb_Adress <= "00000000";
		wait for 50 ns;
		tb_Adress <= "00000010";
		wait for 50 ns;
		tb_en <= '0';
		tb_Adress <= "00000100";
		wait;
	end process;

end architecture archi_ROM_tb;