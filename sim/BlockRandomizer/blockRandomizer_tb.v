`timescale 1ns/1ns

module blockRandomizer_tb();
  reg clk, rst;
  wire [4:0] out;

  blockRandomizer DUT_blockRandomizer(clk, rst, out);

  always begin
    #10 clk = 0;
    #10 clk = 1;
  end

  initial begin
    rst = 1;
    #100 rst = 0;
    #100 rst = 1;
  end
endmodule
