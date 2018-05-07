`timescale 1ns/100ps

module SegRunner_tb ();

  reg[7:0] inputNum;
  wire[7:0] segOut;

  SegRunner DUT_seg_run(inputNum, segOut);

  initial begin
    inputNum = 8'b10000000;
    #10;
    inputNum = 8'b01000000;
    #10;
    inputNum = 8'b00100000;
    #10;
    inputNum = 8'b00010000;
    #10;
    inputNum = 8'b0001000;
    #10;
    inputNum = 8'b0000100;
    #10;
    inputNum = 8'b0000010;
    #10;
    inputNum = 8'b0000001;
    #10;
  end

endmodule
