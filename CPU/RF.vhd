library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF is
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
end entity RF;

architecture archi_RF of RF is

	type registerFile is array(0 to 7) of std_logic_vector(7 downto 0);
	signal Data_RF : registerFile ;

begin

	process(rst, clk)
	begin
		if rst='1' then
			for k in 0 to 7 loop
				Data_RF(k) <= (others=>'0');
			end loop;
		else
			if rising_edge(clk) then
				if en='1' then
					if(rw='1') then 
					-- write
						Data_RF(to_integer(unsigned(Addr))) <= Input;
					end if;
					OutA <= Data_RF(to_integer(unsigned(AddrRA)));
					OutB <= Data_RF(to_integer(unsigned(AddrRB)));
				end if;
			end if;
		end if;
	end process;

end architecture archi_RF;
