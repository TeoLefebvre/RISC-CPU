library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		SelR : in std_logic_vector(1 downto 0); -- 2 bits donc 4 opérations possibles
		R : out std_logic_vector(7 downto 0);
		Status : out std_logic
	);
end entity ALU;

architecture archi_ALU of ALU is
	
	signal add : signed(7 downto 0);
	signal sub : signed(7 downto 0);
	signal mul : signed(15 downto 0);

begin

	add <= signed(A) + signed(B);
	sub <= signed(A) - signed(B);
	mul <= signed(A) * signed(B);
	
	R <= 
		std_logic_vector(add) when SelR = "00" else
		std_logic_vector(sub) when SelR = "01" else
		std_logic_vector(mul(7 downto 0)) when SelR = "10";
	
	status <= 
		'1' when SelR = "00" and add = 0 else 
		'1' when SelR = "01" and sub = 0 else
		'1' when SelR = "10" and mul = 0 else
		'0'; 

--	process (A, B, add, sub, mul, selR)
--	begin
--		
--		case SelR is
--			when "00" =>
--				R <= std_logic_vector(add);
--				if to_integer(add) = 0 then
--					status <= '1';
--				else
--					status <= '0';
--				end if;
--			when "01" =>
--				R <= std_logic_vector(sub);
--				if to_integer(sub) = 0 then
--					status <= '1';
--				else
--					status <= '0';
--				end if;
--			when "10" =>
--				R <= std_logic_vector(mul(7 downto 0));
--				if to_integer(mul) = 0 then
--					status <= '1';
--				else
--					status <= '0';
--				end if;
--			when others => 
--				R <= "00000000";
--				status <= '0';
--		end case;
--	end process;

end architecture archi_ALU;