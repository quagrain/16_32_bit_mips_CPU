library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

-- VHDL code for the register file of the MIPS Processor
entity register_file_VHDL is
  port (
    clk, rst: in std_logic;  -- Clock and reset inputs
    reg_write_en: in std_logic;  -- Register write enable signal
    reg_write_dest: in std_logic_vector(4 downto 0);  -- 5-bit register write destination address
    reg_write_data: in std_logic_vector(31 downto 0);  -- 32-bit data to be written to the register
    reg_read_addr_1: in std_logic_vector(4 downto 0);  -- 5-bit register read address 1
    reg_read_data_1: out std_logic_vector(31 downto 0);  -- 32-bit data read from register address 1
    reg_read_addr_2: in std_logic_vector(4 downto 0);  -- 5-bit register read address 2
    reg_read_data_2: out std_logic_vector(31 downto 0)  -- 32-bit data read from register address 2
  );
end register_file_VHDL;

architecture Behavioral of register_file_VHDL is
  -- Type declaration for an array of 32 registers, each 32 bits wide
  type reg_type is array (0 to 31) of std_logic_vector (31 downto 0);
  -- Signal declaration for the register array
  signal reg_array: reg_type := (others => (others => '0'));
begin
  -- Process to handle register reset and write operations
  process(clk, rst) 
  begin
    if (rst = '1') then
      reg_array(0) <= x"00000000";
      reg_array(1) <= x"00000001";
      reg_array(2) <= x"00000002";
      reg_array(3) <= x"00000003";
      reg_array(4) <= x"00000004";
      reg_array(5) <= x"00000005";
      reg_array(6) <= x"00000005";
      reg_array(7) <= x"00000005";
      reg_array(8) <= x"00000005";
      reg_array(9) <= x"00000005";
      reg_array(10) <= x"00000005";
      reg_array(11) <= x"00000005";
      reg_array(12) <= x"00000005";
      reg_array(13) <= x"00000005";
      reg_array(14) <= x"00000005";
      reg_array(15) <= x"00000005";
      reg_array(16) <= x"00000005";
      reg_array(17) <= x"00000005";
      reg_array(18) <= x"00000005";
      reg_array(19) <= x"00000005";
      reg_array(20) <= x"00000005";
      reg_array(21) <= x"00000005";
      reg_array(22) <= x"00000005";
      reg_array(23) <= x"00000005";
      reg_array(24) <= x"00000005";
      reg_array(25) <= x"00000005";
      reg_array(26) <= x"00000005";
      reg_array(27) <= x"00000005";
      reg_array(28) <= x"00000005";
      reg_array(29) <= x"00000005";
      reg_array(30) <= x"00000005";      
      reg_array(31) <= x"00000005";
    elsif (rising_edge(clk)) then
      if (reg_write_en = '1' and reg_write_dest /= "00000") then -- if write is enabled and it is not register 0
        -- Write data to the specified register on rising clock edge if write enable is asserted
        reg_array(to_integer(unsigned(reg_write_dest))) <= reg_write_data;
      end if;
    end if;
  end process;

  -- Read data from registers; the first register is always zero
  reg_read_data_1 <= x"00000000" when reg_read_addr_1 = "00000" else reg_array(to_integer(unsigned(reg_read_addr_1)));
  reg_read_data_2 <= x"00000000" when reg_read_addr_2 = "00000" else reg_array(to_integer(unsigned(reg_read_addr_2)));

end Behavioral;
