module BlockShift_tb();
  reg [7:0] blockLoc;
  reg stopBtn;
  reg adjClkPulse;
  wire [7:0] newBlockLoc;

  BlockShift DUT_BS(blockLoc, stopBtn, adjClkPulse, newBlockLoc);

  always begin
    adjClkPulse = 1;
    #10;
    adjClkPulse = 0;
    #10;
  end

  initial begin
    blockLoc = 8'b10000000;
  end
endmodule
