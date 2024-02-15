library ieee;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.all ;

entity Fetch is
	port(
		en			:	in std_logic;
		clk		:	in std_logic;
		rst		:	in std_logic;
		PC_load	:	in std_logic;
		PC_Jump	:	in std_logic_vector(7 downto 0);
		PC_out	:	out std_logic_vector(7 downto 0)
	);
end Fetch;

architecture archi_Fetch of Fetch is

	signal PC_counter: std_logic_vector(7 downto 0) := "00000000";

begin

	process (clk, rst)
	begin		
		if rst='1' then
			PC_counter <= (others=>'0');
		else
			if rising_edge(clk) then
				if en='1' then
					if PC_Load='0' then
						PC_counter <= std_logic_vector(unsigned(PC_counter)+1);
					else
						PC_counter <= PC_Jump;
					end if;
				end if;
			end if;
		end if;
	end process;

	PC_out <= PC_counter;

end Architecture archi_Fetch;