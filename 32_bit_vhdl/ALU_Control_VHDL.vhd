library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- VHDL code for ALU Control Unit of the MIPS Processor
entity ALU_Control_VHDL is
  port(
    ALU_Control: out std_logic_vector(2 downto 0);  -- 3-bit output for ALU control signal
    ALUOp : in std_logic_vector(5 downto 0);  -- 3-bit input control signal from main control unit
    ALU_Funct : in std_logic_vector(5 downto 0)  -- 6-bit function code from instruction
  );
end ALU_Control_VHDL;

architecture Behavioral of ALU_Control_VHDL is
begin
  -- Process to determine ALU control signal based on ALUOp and ALU_Funct
  process(ALUOp, ALU_Funct)
  begin
    case ALUOp is
      when "000000" => 
        -- Use the function code directly for ALU control
        ALU_Control <= ALU_Funct(2 downto 0);
      when "000001" => 
        -- Set ALU control to 001 (example: might represent a specific operation)
        ALU_Control <= "001";
      when "000010" => 
        -- Set ALU control to 100 (example: might represent a different operation)
        ALU_Control <= "100";
      when "000011" => 
        -- Set ALU control to 000 (example: might represent yet another operation)
        ALU_Control <= "000";
      when "000100" => 
        -- Set ALU control to 101 (example: could represent an additional operation)
        ALU_Control <= "101";
      when "000101" => 
        -- Set ALU control to 110 (example: could represent another additional operation)
        ALU_Control <= "110";
      when others => 
        -- Default case, set ALU control to 000
        ALU_Control <= "000";
    end case;
  end process;
end Behavioral;
