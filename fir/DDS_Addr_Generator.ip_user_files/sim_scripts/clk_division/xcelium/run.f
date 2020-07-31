-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/learn/vivado1/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/learn/vivado1/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/learn/vivado1/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../DDS_Addr_Generator.srcs/sources_1/ip/clk_division/clk_division_clk_wiz.v" \
  "../../../../DDS_Addr_Generator.srcs/sources_1/ip/clk_division/clk_division.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

