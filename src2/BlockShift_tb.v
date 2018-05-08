module BlockShift_tb();
  reg [7:0] blockLoc;
  reg start;
  reg stopBtn;
  reg adjClkPulse;
  wire [7:0] newBlockLoc;
  wire startNext;

  BlockShift DUT_BS(start, blockLoc, stopBtn, adjClkPulse, newBlockLoc, startNext);

  always begin
    adjClkPulse = 1;
    #10;
    adjClkPulse = 0;
    #10;
  end

  initial begin
    blockLoc = 8'b10000000;
    #20;
    start = 0;
    #100;
    start = 1;
    #800;
    stopBtn = 1;
    #200;
    stopBtn = 0;
    // blockLoc = 8'b01000000;
    // blockLoc = 8'b00100000;
    // blockLoc = 8'b00010000;
    // blockLoc = 8'b00001000;
    // blockLoc = 8'b00000100;
    // blockLoc = 8'b00000010;
    // blockLoc = 8'b00000001;
  end
endmodule
