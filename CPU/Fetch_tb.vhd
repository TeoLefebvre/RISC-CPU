library ieee;
use ieee.std_logic_1164.all;

entity Fetch_tb is
end entity Fetch_tb;

architecture archi_Fetch_tb of Fetch_tb is

	component Fetch is
		port(
			en			:	in std_logic;
			clk		:	in std_logic;
			rst		:	in std_logic;
			PC_load	:	in std_logic;
			PC_Jump	:	in std_logic_vector(7 downto 0);
			PC_out	:	out std_logic_vector(7 downto 0)
		);
	end component Fetch;
	
	signal tb_clk : std_logic := '0';
	signal tb_rst : std_logic := '1';
	signal tb_en : std_logic;
	signal tb_PC_load : std_logic;
	signal tb_PC_Jump : std_logic_vector(7 downto 0);
	signal tb_PC_out : std_logic_vector(7 downto 0);
	
begin

	inst_Fetch : component Fetch
		port map(
			clk => tb_clk,
			rst => tb_rst,
			en => tb_en,
			PC_load => tb_PC_load,
			PC_Jump => tb_PC_Jump,
			PC_out => tb_PC_out
		);
	
	tb_clk <= not tb_clk after 10 ns;
	tb_rst <= '0' after 50 ns;
	
	stimulus: process
	begin
		tb_en <= '1';
		-- tb_PC_load <= '0';
		wait for 100 ns;
		tb_PC_load <= '1';
		tb_PC_Jump <= "10000000";
		wait;
	end process;

end architecture archi_Fetch_tb;