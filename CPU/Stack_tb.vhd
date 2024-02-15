library ieee;
use ieee.std_logic_1164.all;

entity Stack_tb is
end entity Stack_tb;

architecture archi_Stack_tb of Stack_tb is

	component Stack is
		port(
			rw		:	in std_logic; -- rw='1' alors PUSH ("write") sinon POP ("read")
			en 		:  in std_logic;
			clk		:	in std_logic;
			rst		:	in std_logic;
			index		:	in std_logic_vector(7 downto 0);
			Data_in	:	in std_logic_vector(7 downto 0);
			Data_out :	out std_logic_vector(7 downto 0)
		);
	end component Stack;
	
	signal rw : std_logic;
	signal en : std_logic;
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal index : std_logic_vector(7 downto 0);
	signal Data_in : std_logic_vector(7 downto 0);
	signal Data_out : std_logic_vector(7 downto 0);
	
begin

	inst_Stack : component Stack
		port map(
			rw => rw,
			en => en,
			clk => clk,
			rst => rst,
			index => index,
			Data_in => Data_in,
			Data_out => Data_out
		);
	
	clk <= not clk after 10 ns;
	rst <= '0' after 50 ns;
	
	stimulus: process
	begin
		wait for 50 ns;
		wait until rising_edge(clk) for 20 ns;
		-- PUSH 1
		en <= '1';
		rw <= '1';
		Data_in <= "00000001";
		wait until rising_edge(clk) for 20 ns;
		-- PUSH 4
		rw <= '1';
		Data_in <= "00000100";
		wait until rising_edge(clk) for 20 ns;
		-- POP 1 -> 1
		rw <= '0';
		index <= "00000001";
		wait until rising_edge(clk) for 20 ns;
		-- POP 0 -> 4
		rw <= '0';
		index <= "00000000";
		wait for 30 ns;
		en <= '0';
		wait;
	end process;

end architecture archi_Stack_tb;