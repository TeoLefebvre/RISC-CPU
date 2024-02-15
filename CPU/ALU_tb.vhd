library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity ALU_tb;

architecture archi_ALU_tb of ALU_tb is

	component ALU is
		port (
			A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0);
			SelR : in std_logic_vector(1 downto 0);
			R : out std_logic_vector(7 downto 0);
			Status : out std_logic
		);
	end component ALU;
	
	signal tb_A : std_logic_vector(7 downto 0);
	signal tb_B : std_logic_vector(7 downto 0);
	signal tb_SelR : std_logic_vector(1 downto 0);
	signal tb_R : std_logic_vector(7 downto 0);
	signal tb_Status : std_logic;
	
begin

	inst_ALU : component ALU
		port map(
			A => tb_A,
			B => tb_B,
			SelR => tb_SelR,
			R => tb_R,
			Status => tb_Status
		);
	
	process
	begin
		wait for 100 ns;
		tb_A <= "00000110"; -- 6
		tb_B <= "00000010"; -- 2
		wait for 50 ns;
		tb_SelR <= "00"; -- R = 6+2 = 8
		wait for 50 ns;
		tb_SelR <= "01"; -- R = 6-2 = 4
		wait for 50 ns;
		tb_SelR <= "10"; -- R = 6*2 = 12
		wait for 50 ns;
		tb_A <= "00000001";
		tb_B <= "00000001";
		tb_SelR <= "01";
		wait;
	end process;

end architecture archi_ALU_tb;