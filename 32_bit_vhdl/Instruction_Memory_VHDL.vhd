library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

-- Entity declaration for the Instruction Memory
entity Instruction_Memory_VHDL is
  port (
    inst_add: in std_logic_vector(4 downto 0);  -- 5-bit instruction address input
    instruction: out std_logic_vector(31 downto 0)  -- 32-bit instruction output
  );
end Instruction_Memory_VHDL;

architecture Behavioral of Instruction_Memory_VHDL is
  -- Internal signal for ROM address
  signal rom_addr: std_logic_vector(4 downto 0);

  -- Type declaration for ROM, an array of 16 locations each 16 bits wide
  type ROM_type is array (0 to 31) of std_logic_vector(31 downto 0);

  -- ROM data constant initialization - 32 bits instruction set architecture
  -- R type: opcode - 6 bits, source1 - 5 bits, source2 - 5 bits, dest - 5 bits, sa- 5 bits, funct - 6 bits
  -- I type: opcode - 6 bits, source - 5 bits, dest - 5 bits, immediate - 16 bits
  -- J type: opcode - 6 bits, address / offset - 26 bits
  -- The registers have beeen initialized with default values in the register file
  
  constant rom_data: ROM_type := (
    "00001000000001000000000000001110", -- addi: reg(0)+reg(4) = 0+4 = 4
    "00000101010010010000000000000000", -- add: reg(10) + reg(9) = 5+5 =10
    "00010011100010100000000000000000", -- andi: reg(10) = reg(28) & 0
    "00100010010000010000000000000001", -- lw: reg(1) = reg(18 + 1) = 5
    "00010110100110000000000000000000", -- ori: reg(24) = reg(20) | 0x"00000000"
    "00001010010000010000000000000001", -- addi:  
    "00100100100000100000000000000010", -- addi operation: reg (2) = reg(2) + 2 = 2 + 2 = 4. ALU result will be 0004.
    "00001100010011110000000000000000", -- beq operation: ALU will perform subtraction = reg(0) - reg(1) = 0 - 55 = -54. ALU result will be ffca (-54 in hex).
    "00111100000000000000000000000101", -- jump operation to target address 5 (instruction 5: subi) no ALU result. ALU will be 0000.
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000",
    "00000000000000000000000000000000", 
    "00000000000000000000000000000000"  
  );

begin
  -- Assign the input address to the internal ROM address signal
  rom_addr <= inst_add;

  -- Fetch the instruction from ROM using the address and assign it to the output
  instruction <= rom_data(to_integer(unsigned(rom_addr)));

end Behavioral;
