`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 22:28:09
// Design Name: 
// Module Name: firtop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module firtop(
    input clk_100MHz,
    input [7:0]ADC_Data,
    output clk_DAC,
    output DAC_Din,
    output DAC_Sync,
    output ADC_En,
    output clk_ADC   
    );
   wire clk_100MHz_System;
   wire clk_system;
   wire[7:0]ADC_Data_Out; 
   wire [7:0]dac_data;     
   wire [20:0]Offset;
  // wire[17:0]Read_Addr;  
   clk_division clk_division(.clk_out1(clk_DAC),.clk_out2(clk_100MHz_System),.clk_out3(clk_system),.clk_in1(clk_100MHz));
  
    Driver_ADC_0 Driver_ADC0(
        .clk_100MHz(clk_100MHz), //System clock              
        .clk_system(clk_system),        //Clock reading signal
        .Rst(1),                        //Reset signal, low reset
        .ADC_Data(ADC_Data),            //ADC sampling data
        .Read_Addr(Offset),          //Read signal address
        .Trigger_Gate(128),             //Trigger threshold
        .Period(Offset),
        .clk_ADC(clk_ADC),              //ADC clock
        .ADC_En(ADC_En),                //ADC enable signal
        .ADC_Data_Out(ADC_Data_Out)     //Storage signal output
        );  
   fir fir0(
        .clk(clk_100MHz),
        .reset_n(1),
        .data_in(ADC_Data_Out),
        .fir_data(dac_data)
        );
        
   Driver_DAC Driver_DAC0(
        .clk_DAC(clk_DAC),
        .DAC_Data(dac_data),
        .DAC_Din(DAC_Din),
        .DAC_Sync(DAC_Sync)
        );    
endmodule

