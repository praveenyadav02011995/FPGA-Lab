## This file is a general .xdc for the EDGE Artix 7 board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property -dict { PACKAGE_PIN N11    IOSTANDARD LVCMOS33 } [get_ports { clk }];

set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { distance[0] }];#LSB
set_property -dict { PACKAGE_PIN H3    IOSTANDARD LVCMOS33 } [get_ports { distance[1] }];
set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { distance[2] }];
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { distance[3] }];
set_property -dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33 } [get_ports { distance[4] }];
set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { distance[5] }];
set_property -dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { distance[6] }];
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { distance[7] }];
set_property -dict { PACKAGE_PIN K5    IOSTANDARD LVCMOS33 } [get_ports { distance[8] }];
set_property -dict { PACKAGE_PIN P6    IOSTANDARD LVCMOS33 } [get_ports { distance[9] }];
set_property -dict { PACKAGE_PIN R7    IOSTANDARD LVCMOS33 } [get_ports { distance[10] }];
set_property -dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { distance[11] }];
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { distance[12] }];
# set_property -dict { PACKAGE_PIN R5    IOSTANDARD LVCMOS33 } [get_ports { distance[13] }];
# set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { distance[14] }];
# set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { distance[15] }];#MSB


set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {trig}];
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports {echo}];

# set_property -dict { PACKAGE_PIN L5    IOSTANDARD LVCMOS33 } [get_ports { echo }];#LSB
# set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { trig }];#LSB