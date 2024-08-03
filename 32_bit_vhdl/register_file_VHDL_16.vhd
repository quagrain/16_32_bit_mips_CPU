library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

-- VHDL code for the register file of the MIPS Processor
entity register_file_VHDL is
  port (
    clk, rst: in std_logic;  -- Clock and reset inputs
    reg_write_en: in std_logic;  -- Register write enable signal
    reg_write_dest: in std_logic_vector(2 downto 0);  -- 3-bit register write destination address
    reg_write_data: in std_logic_vector(15 downto 0);  -- 16-bit data to be written to the register
    reg_read_addr_1: in std_logic_vector(2 downto 0);  -- 3-bit register read address 1
    reg_read_data_1: out std_logic_vector(15 downto 0);  -- 16-bit data read from register address 1
    reg_read_addr_2: in std_logic_vector(2 downto 0);  -- 3-bit register read address 2
    reg_read_data_2: out std_logic_vector(15 downto 0)  -- 16-bit data read from register address 2
  );
end register_file_VHDL;

architecture Behavioral of register_file_VHDL is
  -- Type declaration for an array of 8 registers, each 16 bits wide
  type reg_type is array (0 to 7) of std_logic_vector (15 downto 0);
  -- Signal declaration for the register array
  signal reg_array: reg_type;
begin
  -- Process to handle register reset and write operations
  process(clk, rst) 
  begin
    if (rst = '1') then
      -- Initialize registers on reset
      reg_array(0) <= x"0000";
      reg_array(1) <= x"0001";
      reg_array(2) <= x"0002";
      reg_array(3) <= x"0003";
      reg_array(4) <= x"0004";
      reg_array(5) <= x"0005";
      reg_array(6) <= x"0006";
      reg_array(7) <= x"0007";
    elsif (rising_edge(clk)) then
      if (reg_write_en = '1') then
        -- Write data to the specified register on rising clock edge if write enable is asserted
        reg_array(to_integer(unsigned(reg_write_dest))) <= reg_write_data;
      end if;
    end if;
  end process;

  -- Read data from registers; the first register is always zero
  reg_read_data_1 <= x"0000" when reg_read_addr_1 = "000" else reg_array(to_integer(unsigned(reg_read_addr_1)));
  reg_read_data_2 <= x"0000" when reg_read_addr_2 = "000" else reg_array(to_integer(unsigned(reg_read_addr_2)));

end Behavioral;
