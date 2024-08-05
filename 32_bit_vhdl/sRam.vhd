library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

--------------------------------------------------------------

-- Entity declaration for the SRAM module
entity sRam is
  generic(
    width: integer := 16;  -- Word width (bit-width of each location)
    depth: integer := 8;  -- Number of memory locations
    dataaddr: integer := 3  -- Address width (log2(depth))
  );
  port(
    clk: in std_logic;  -- Clock input
    Read: in std_logic;  -- Read enable signal
    Write: in std_logic;  -- Write enable signal
    Addr: in std_logic_vector(dataaddr-1 downto 0);  -- Address input (3 bits for 8 locations)
    Data_in: in std_logic_vector(width-1 downto 0);  -- Data input (16 bits)
    Data_out: out std_logic_vector(width-1 downto 0)  -- Data output (16 bits)
  );
end sRam;

--------------------------------------------------------------

architecture behav of sRam is

  -- Type declaration for RAM, an array of 8 locations each 16 bits wide
  type ram_type is array (0 to depth-1) of std_logic_vector(width-1 downto 0);
  -- Signal declaration for the internal RAM storage
  signal tmp_ram: ram_type;

begin  
  -- Process to handle read and write operations
  process(clk)
  begin
    if (rising_edge(clk)) then
      if (Write = '1') then
        -- Write data to RAM at the given address
        tmp_ram(conv_integer(Addr)) <= Data_in;
      elsif (Read = '1') then
        -- Read data from RAM at the given address
        Data_out <= tmp_ram(conv_integer(Addr)); 
      else
        -- If neither read nor write is enabled, set Data_out to high-impedance
        Data_out <= (Data_out'range => 'Z');
      end if;
    end if;
  end process;

end behav;
----------------------------------------------------------------
