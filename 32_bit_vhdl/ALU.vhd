library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for the ALU
entity alu is
  Port (
    inp_a : in STD_LOGIC_VECTOR(31 downto 0);  -- 32-bit input A
    inp_b : in STD_LOGIC_VECTOR(31 downto 0);  -- 32-bit input B
    alu_control : in STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit control signal to determine ALU operation
    alu_result : out STD_LOGIC_VECTOR(31 downto 0);  -- 16-bit output result
    zero_flag, sign_flag : out std_logic  -- Output flags: zero flag and sign flag
  );
end alu;

-- Architecture definition for the ALU
architecture Behavioral of alu is
  signal out_alu : std_logic_vector(31 downto 0);  -- Internal signal for ALU output
begin
  -- Process to perform ALU operations based on control signal
  process(inp_a, inp_b, alu_control) 
  begin
    if (ieee.std_logic_signed."="(alu_control,"000")) then 
      -- Addition operation
      out_alu <= inp_a + inp_b; 
    elsif (ieee.std_logic_signed."="(alu_control,"001")) then 
      -- Subtraction operation
      out_alu <= inp_a - inp_b;
    elsif (ieee.std_logic_signed."="(alu_control,"010")) then 
      -- Multiplication operation
      out_alu <= std_logic_vector(to_unsigned((to_integer(unsigned(inp_a)) * to_integer(unsigned(inp_b))),32));
    elsif (ieee.std_logic_signed."="(alu_control,"011")) then 
      -- Division operation
      out_alu <= std_logic_vector(to_unsigned((to_integer(unsigned(inp_a)) / to_integer(unsigned(inp_b))),32));
    elsif (ieee.std_logic_signed."="(alu_control,"100")) then 
      -- AND operation
      out_alu <= inp_a and inp_b;
    elsif (ieee.std_logic_signed."="(alu_control,"101")) then 
      -- OR operation
      out_alu <= inp_a or inp_b;
    elsif (ieee.std_logic_signed."="(alu_control,"110")) then 
      -- XOR operation
      out_alu <= inp_a xor inp_b;
    elsif (ieee.std_logic_signed."="(alu_control,"111")) then 
      -- NOT operation
      out_alu <= not inp_a;
    end if;
  end process;

  -- Set zero flag if the result is zero
  zero_flag <= '1' when (ieee.std_logic_signed."="(out_alu,x"00000")) else '0';

  -- Set sign flag if inp_a is less than inp_b
  sign_flag <= '1' when (ieee.std_logic_signed."<"(inp_a,inp_b)) else '0';

  -- Assign the ALU result to the output
  alu_result <= out_alu;

end Behavioral;
