vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/bancoReg.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/bancoReg_two.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/registrador32.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/registrador32_two.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/Shifter.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/somadorCompleto.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/sum32.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/ULA.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/ULA_two.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/UlaControl.vhd}
vcom -work work -2002 -explicit {C:/Users/huber/OneDrive/Área de Trabalho/ulafinalfinal/UlaControl_TB.vhd}
vsim -gui work.ulacontrol_tb 
do wave.do
run 20 us