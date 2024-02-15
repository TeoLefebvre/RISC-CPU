library ieee;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.all ;

entity Stack is
	port(
		rw		:	in std_logic; -- rw='1' alors PUSH ("write") sinon POP ("read")
		en 		:  in std_logic;
		clk		:	in std_logic;
		rst		:	in std_logic;
		index		:	in std_logic_vector(7 downto 0);
		Data_in	:	in std_logic_vector(7 downto 0);
		Data_out :	out std_logic_vector(7 downto 0)
	);
end Stack;

architecture archi_Stack of Stack is

	type stack is array(0 to 255) of std_logic_vector(7 downto 0);
	signal Data_Stack : stack;
	signal top : integer range -1 to 255 := -1;
	signal index_int : integer range 0 to 255;

begin

	index_int <= to_integer(unsigned(index));

	process(rst, clk)
		variable varTop : integer range -1 to 255; 
	begin
		if rst='1' then
			for k in 0 to 255 loop
				Data_Stack(k) <= (others=>'0');
			end loop;
			top <= -1;
		else
			if rising_edge(clk) then
				if en='1' then
					varTop := top;
					if rw='1' then
					-- PUSH section
						varTop := varTop + 1;
						Data_Stack(varTop) <= Data_in;
					else
					-- POP section
						Data_out <= Data_Stack(varTop - index_int);
						for k in 0 to 254 loop
							if (varTop - index_int <= k and k <= varTop - 1) then
								Data_stack(k) <= Data_stack(k+1);
							end if;
						end loop;
						Data_stack(top) <= (others => '0');
						varTop := varTop - 1;
					end if;
					top <= varTop;
				end if;
			end if;
		end if;
	end process;

end architecture archi_Stack;
