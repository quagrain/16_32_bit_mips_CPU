library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_VHDL is
  port (
    opcode: in std_logic_vector(3 downto 0);  -- 4-bit opcode input
    reset: in std_logic;  -- Reset signal
    alu_op: out std_logic_vector(2 downto 0);  -- ALU operation code output
    reg_dst, mem_to_reg, jump, branch, branch_g, branch_l, mem_read, mem_write, alu_src, reg_write : out std_logic  -- Control signals
  );
end control_unit_VHDL;

architecture Behavioral of control_unit_VHDL is
begin
  process(reset, opcode)
  begin
    if (reset = '1' or opcode = "0000") then
      -- Reset or NOP (No Operation) state
      reg_dst <= '0';
      mem_to_reg <= '0';
      alu_op <= "000";
      jump <= '0';
      branch_g <= '0';
      branch_l <= '0';
      branch <= '0';
      mem_read <= '0';
      mem_write <= '0';
      alu_src <= '0';  -- Default: Second operand from register
      reg_write <= '0';
    else
      case opcode is
        when "0001" => -- Arithmetic and Logic
          reg_dst <= '1';
          mem_to_reg <= '0';
          alu_op <= "000";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';  -- Second operand from register
          reg_write <= '1';
          
        when "0010" => -- ADDI
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "011";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "0011" => -- SUBI
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "001";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "0100" => -- ANDI
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "010";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "0101" => -- ORI
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "100";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "0110" => -- XORI
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "101";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "0111" => -- LI (Load Immediate)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "011";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "1000" => -- LW (Load Word)
          reg_dst <= '0';
          mem_to_reg <= '1';
          alu_op <= "011";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '1';
          mem_write <= '0';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '1';
          
        when "1001" => -- SW (Store Word)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "011";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '1';
          alu_src <= '1';  -- Immediate value as the second operand
          reg_write <= '0';
          
        when "1010" => -- BEQ (Branch if Equal)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "001";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '1';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';
          
        when "1011" => -- BG (Branch if Greater)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "001";
          jump <= '0';
          branch_g <= '1';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';
          
        when "1100" => -- BL (Branch if Less)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "001";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '1';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';
          
        when "1101" => -- BC (Branch on Condition)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "000";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '1';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';
          
        when "1110" => -- BZ (Branch if Zero)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "000";
          jump <= '0';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '1';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';
          
        when "1111" => -- J (Jump)
          reg_dst <= '0';
          mem_to_reg <= '0';
          alu_op <= "000";
          jump <= '1';
          branch_g <= '0';
          branch_l <= '0';
          branch <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';
          reg_write <= '0';

        when others =>   
          -- Default case: Set default values
          reg_dst <= '1';
          mem_to_reg <= '0';
          alu_op <= "000";
          jump <= '0';
          branch <= '0';
          branch_g <= '0';
          branch_l <= '0';
          mem_read <= '0';
          mem_write <= '0';
          alu_src <= '0';  -- Default: Second operand from register
          reg_write <= '1';
      end case;
    end if;
  end process;

end Behavioral;
