library ieee;
use ieee.std_logic_1164.all;

entity Decode is
	port (
		clk, rst : in std_logic;
		inStack, inA, inB, inMem : in std_logic_vector(7 downto 0);
		status: in std_logic;
		instruction : in std_logic_vector(15 downto 0);
		AddrDest, AddrRA, AddrRB : out std_logic_vector(2 downto 0);
		EnStack, EnRF, EnMem, EnFetch, EnROM : out std_logic;
		outA, outB: out std_logic_vector(7 downto 0);
		SelR : out std_logic_vector(1 downto 0);
		rwStack, rwRF, rwMem : out std_logic;
		address : out std_logic_vector(7 downto 0);
		PC_load : out std_logic
	);
end entity Decode;

architecture archi_Decode of Decode is

	signal format : std_logic_vector(1 downto 0);
	signal op : std_logic_vector(2 downto 0);
	signal RDest : std_logic_vector(2 downto 0);
	signal RA : std_logic_vector(2 downto 0);
	signal RB : std_logic_vector(2 downto 0);
	signal short_imm : std_logic_vector(3 downto 0);
	signal long_imm : std_logic_vector(7 downto 0);
	signal En : std_logic_vector(4 downto 0);
	signal rw : std_logic_vector(2 downto 0);
	
	signal counter : integer range 0 to 5 := 0;
	
begin

	format <= instruction(15 downto 14);
	op <= instruction(13 downto 11);
	RDest <= instruction(10 downto 8);
	RA <= instruction(6 downto 4);
	RB <= instruction(2 downto 0);
	short_imm <= instruction(3 downto 0);
	long_imm <= instruction(7 downto 0);
	
	EnStack <= En(4);
	EnRF <= En(3);
	EnMem <= En(2);
	EnFetch <= En(1);
	EnROM <= En(0);
	
	rwStack <= rw(2);
	rwRF <= rw(1);
	rwMem <= rw(0);

	process(clk, rst)
	begin
		if rst = '1' then
			AddrDest <= "000";
			AddrRA <= "000";
			AddrRB <= "000";
			En <= "00001";
			OutA <= "00000000";
			OutB <= "00000000";
			SelR <= "00";
			rw <= "000";
			address <= "00000000";
			PC_load <= '0';
		elsif rising_edge(clk) then
			if format = "00" then
				case op is
					when "000" => -- ADD : RDest = RA + RB
						if counter = 0 then
							AddrRA <= RA;
							AddrRB <= RB;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then 
							AddrDest <= RDest;
							outA <= inA;
							outB <= inB;
							SelR <= "00";
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "001" => -- SUB : RDest = RA - RB
						if counter = 0 then
							AddrRA <= RA;
							AddrRB <= RB;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then 
							AddrDest <= RDest;
							outA <= inA;
							outB <= inB;
							SelR <= "01";
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "010" => -- MUL : RDest = RA * RB
						if counter = 0 then
							AddrRA <= RA;
							AddrRB <= RB;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then 
							AddrDest <= RDest;
							outA <= inA;
							outB <= inB;
							SelR <= "10";
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "011" => -- MOV : RDest = RA
						if counter = 0 then
							AddrRA <= RA;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then 
							AddrDest <= RDest;
							outA <= inA;
							outB <= "00000000";
							SelR <= "00";
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "100" => -- NOP
						AddrDest <= "000";
						AddrRA <= "000";
						AddrRB <= "000";
						En <= "00000";
						OutA <= "00000000";
						OutB <= "00000000";
						SelR <= "00";
						rw <= "000";
						address <= "00000000";
						PC_load <= '0';
					when "101" =>
						null;
					when "110" => -- LOAD : RDest = donnée à l'adresse dans RA
						if counter = 0 then
							AddrRA <= RA;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							address <= inA;
							En <= "00100";
							rw <= "000";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 4;
						elsif counter <= 4 then
							AddrDest <= RDest;
							outA <= inMem;
							outB <= "00000000";
							SelR <= "00";
							En <= "01001";
							rw <= "010";
							counter <= 5;
						elsif counter <= 5 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "111" => -- WRITE : donnée à l'adresse dans RA = donnée dans RDest
						if counter = 0 then
							AddrRA <= RA; -- adresse dans laquelle écrire
							AddrRB <= RDest; -- donnée à écrire
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							outA <= "00000000";
							outB <= inB;
							selR <= "00";
							address <= inA;
							En <= "00101";
							rw <= "001";
							counter <= 3;
						elsif counter <= 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when others =>
						null;
				end case;
			elsif format = "01" then
				case op is
					when "000" => -- ADD : RDest = RA + short_imm
						if counter = 0 then
							AddrRA <= RA;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							AddrDest <= RDest;
							SelR <= "00";
							OutA <= inA;
							OutB <= "0000" & short_imm;
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "001" => -- SUB : RDest = RA - short_imm
						if counter = 0 then
							AddrRA <= RA;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							AddrDest <= RDest;
							SelR <= "01";
							OutA <= inA;
							OutB <= "0000" & short_imm;
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "010" => -- MUL : RDest = RA * short_imm
						if counter = 0 then
							AddrRA <= RA;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							AddrDest <= RDest;
							SelR <= "10";
							OutA <= inA;
							OutB <= "0000" & short_imm;
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "011" =>
						null;
					when "100" => -- PUSH : ajoute valeur de RDest dans la stack
						if counter = 0 then
							AddrRA <= RDest;
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							outA <= inA;
							outB <= "00000000";
							SelR <= "00";
							En <= "10001";
							rw <= "100";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "101" =>
						null;
					when "110" =>
						null;
					when "111" =>
						null;
					when others =>
						null;
				end case;
			elsif format = "10" then
				case op is
					when "000" => -- JUMP : aller à la ligne long_imm
						if counter = 0 then
							address <= long_imm;
							En <= "00010";
							rw <= "000";
							PC_load <= '1';
							counter <= 1;
						elsif counter = 1 then
							En <= "00001";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "001" => -- ZJUMP : aller à la ligne long_imm si le résultat précédent vaut 0
						if counter = 0 then
							address <= long_imm;
							En <= "00010";
							rw <= "000";
							if status = '1' then
								PC_load <= '1';
							else
								PC_load <= '0';
							end if;
							counter <= 1;
						elsif counter = 1 then
							En <= "00001";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "010" => -- JUMP : aller au numéro de ligne dans RDest
						if counter = 0 then
							AddrRA <= RDest; -- adresse de l'instruction à charger
							En <= "01000";
							rw <= "000";
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							address <= inA;
							En <= "00010";
							rw <= "000";
							PC_load <= '1';
							counter <= 3;
						elsif counter = 3 then
							En <= "00001";
							rw <= "000";
							counter <= 4;
						elsif counter = 4 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "011" => -- MOV : RDest = long_imm
						if counter = 0 then
							AddrDest <= RDest;
							OutA <= long_imm;
							OutB <= "00000000";
							SelR <= "00";
							En <= "01010";
							rw <= "010";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00001";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "100" => -- PUSH : ajoute long_imm à la stack
						if counter = 0 then
							outA <= long_imm;
							outB <= "00000000";
							SelR <= "00";
							En <= "10010";
							rw <= "100";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00001";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "101" => -- POP : pop la valeur à l'index long_imm et la sauvegarde dans RDest
						if counter = 0 then
							address <= long_imm;
							En <= "10010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							outA <= inStack;
							outB <= "00000000";
							SelR <= "00";
							AddrDest <= RDest;
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter = 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "110" => -- LOAD : RDest = donnée à l'adresse long_imm
						if counter = 0 then
							address <= long_imm;
							En <= "00110";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							AddrDest <= RDest;
							outA <= inMem;
							outB <= "00000000";
							En <= "01001";
							rw <= "010";
							counter <= 3;
						elsif counter <= 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when "111" => -- WRITE : donnée à l'adresse long_imm = valeur de RDest
						if counter = 0 then
							AddrRA <= Rdest; -- donnée à écrire
							En <= "01010";
							rw <= "000";
							PC_load <= '0';
							counter <= 1;
						elsif counter = 1 then
							En <= "00000";
							rw <= "000";
							counter <= 2;
						elsif counter = 2 then
							outA <= inA;
							outB <= "00000000";
							selR <= "00";
							address <= long_imm;
							En <= "00101";
							rw <= "001";
							counter <= 3;
						elsif counter <= 3 then
							En <= "00000";
							rw <= "000";
							counter <= 0;
						end if;
					when others =>
						null;
				end case;
			else
				null;
			end if;
		end if;
	end process;
	
end architecture archi_Decode;
