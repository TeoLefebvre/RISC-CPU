library ieee;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.all ;

entity ROM is
	port(
		en			:	in std_logic;
		clk		:	in std_logic;
		rst		:	in std_logic;
		Adress	:	in std_logic_vector(7 downto 0);
		Data_out :	out std_logic_vector(15 downto 0)
	);
end ROM;

architecture archi_ROM of ROM is

	type rom is array(0 to 255) of std_logic_vector(15 downto 0);
	signal Data_Rom : rom ;

begin

	acces_rom:process(rst, clk)
	begin
		if rst='1' then
			Data_ROM(0) <= "1001100100000001";
			Data_ROM(1) <= "0100100000011000";
			Data_ROM(2) <= "1000100000011101";
			Data_ROM(3) <= "0110000100000000";
			Data_ROM(4) <= "1010000000000110";
			Data_ROM(5) <= "1000000000001010";
			Data_ROM(6) <= "0100000100010001";
			Data_ROM(7) <= "1000000000000001";
			Data_ROM(8) <= "0010000000000000";
			Data_ROM(9) <= "0010000000000000";
			Data_ROM(10) <= "0110000100000000";
			Data_ROM(11) <= "0110001000000000";
			Data_ROM(12) <= "0110001100000000";
			Data_ROM(13) <= "1010100100000100";
			Data_ROM(14) <= "0011001000010000";
			Data_ROM(15) <= "0100100100010001";
			Data_ROM(16) <= "0011001100010000";
			Data_ROM(17) <= "0101001000100011";
			Data_ROM(18) <= "0101001100110010";
			Data_ROM(19) <= "0000101000100011";
			Data_ROM(20) <= "0100000100011001";
			Data_ROM(21) <= "0011101000010000";
			Data_ROM(22) <= "1010101100000000";
			Data_ROM(23) <= "1010101000000000";
			Data_ROM(24) <= "1010100100000000";
			Data_ROM(25) <= "1010100000000000";
			Data_ROM(26) <= "1001000000000000";
			Data_ROM(27) <= "0010000000000000";
			Data_ROM(28) <= "0010000000000000";
			Data_ROM(29) <= "1011000100001000";
			Data_ROM(30) <= "1011000100001001";
			Data_ROM(31) <= "1011000100001010";
			Data_ROM(32) <= "1011000100001011";
			Data_ROM(33) <= "1011000100001100";
			Data_ROM(34) <= "1011000100001101";
			Data_ROM(35) <= "1011000100001110";
			Data_ROM(36) <= "1011000100001111";

--			Data_ROM(0) <= "1001100100000001";
--			Data_ROM(1) <= "1001101000000100";
--			Data_ROM(2) <= "0000101100100001";
			
			for k in 37 to 255 loop
				Data_ROM(k) <= "0010000000000000"; -- Instruction NOP
			end loop;
		else
			if rising_edge(clk) then
				if en='1'then
					Data_out <= Data_Rom(to_integer(unsigned(Adress)));
				end if;
			end if;
		end if;
	end process acces_rom;

end archi_ROM;
