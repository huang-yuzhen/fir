`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 18:09:53
// Design Name: 
// Module Name: fir
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


module fir(
           clk,
           reset_n,
           data_in,
           fir_data
           );
input  clk;
input  reset_n;
input  [7:0]data_in;
wire   clk;
wire   reset_n;

output [7:0]fir_data;
reg    [7:0]fir_data;

reg    [31:0] clk_cnt =32'd0;
reg    clk_div = 1'b0;

always @(posedge clk or negedge reset_n)
 begin
  if(!reset_n)
   begin
    clk_div<=1'b0;
    clk_cnt<=32'd0;
   end
  else
    if(clk_cnt==32'd249)//sample 100K
     begin
      clk_div<=~clk_div;
      clk_cnt<=32'd0;
     end
    else
     clk_cnt<=clk_cnt+1'b1;
 end
 
reg    [7:0] t1[7:0];
wire [31:0]data_reg [5:0];
wire [31:0]data_temp;

assign data_reg[0]=21*(t1[0]+t1[7]);//线性结构，对称结构
assign data_reg[1]=65*(t1[1]+t1[6]);
assign data_reg[2]=166*(t1[2]+t1[5]);
assign data_reg[3]=248*(t1[3]+t1[4]);
assign data_reg[4]=data_reg[0]+data_reg[1];
assign data_reg[5]=data_reg[2]+data_reg[3];   
assign data_temp  =(data_reg[4]+data_reg[5])/1000;

    always @(posedge clk_div or negedge reset_n)
    begin
        if(!reset_n)
        begin
            fir_data<=10'd0;
            t1[0]<=10'd0;
            t1[1]<=10'd0;
            t1[2]<=10'd0;
            t1[3]<=10'd0;
            t1[4]<=10'd0;
            t1[5]<=10'd0;
            t1[6]<=10'd0;
            t1[7]<=10'd0;
        end
        else
        begin
            fir_data<=data_temp[9:0];
            t1[1]<=t1[0];
            t1[2]<=t1[1];
            t1[3]<=t1[2];
            t1[4]<=t1[3];
            t1[5]<=t1[4];
            t1[6]<=t1[5];
            t1[7]<=t1[6];
            t1[0]<=data_in;
        end
    end
endmodule
