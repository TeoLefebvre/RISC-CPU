library ieee;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.all ;

entity RAM is
	port(
		rw,en		:	in std_logic; -- rw='1' alors ecriture
		clk		:	in std_logic;
		rst		:	in std_logic;
		Adress	:	in std_logic_vector(7 downto 0);
		Data_in	:	in std_logic_vector(7 downto 0);
		Data_out :	out std_logic_vector(7 downto 0)
	);
end RAM;

architecture archi_RAM of RAM is

	type ram is array(0 to 255) of std_logic_vector(7 downto 0);
	signal Data_Ram : ram ;

begin

	acces_ram:process(rst, clk)
	begin
		if rst='1' then
			Data_Ram(0) <= "00010000";
			Data_Ram(1) <= "00010000";
			Data_Ram(2) <= "00000000";
			Data_Ram(3) <= "00000000";
			Data_Ram(4) <= "00000000";
			Data_Ram(5) <= "00010000";
			Data_Ram(6) <= "00010000";
			Data_Ram(7) <= "00010000";
			for k in 8 to 255 loop
				Data_Ram(k) <= (others=>'0');
			end loop;
		else
			if rising_edge(clk) then
				if en='1' then
					if(rw='1') then
						Data_Ram(to_integer(unsigned(Adress))) <= Data_in;
					else
						Data_out <= Data_Ram(to_integer(unsigned(Adress)));
					end if;
				end if;
			end if;
		end if;
	end process acces_ram;

end architecture archi_RAM;
