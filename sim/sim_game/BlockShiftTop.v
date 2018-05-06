module BlockShiftTop(blockLoc, adjClkPulse, newBlockLoc);
  input [7:0] blockLoc;
  input adjClkPulse;
  output [7:0] newBlockLoc;

  reg [7:0] tempBlock;

  BlockShift BS1(blockLoc, adjClkPulse, newBlockLoc);
  // BlockShift BS1(8'b10000000, adjClkPulse, newBlockLoc);

  always @ (newBlockLoc) begin
    tempBlock = newBlockLoc;
  end

  assign blockLoc = tempBlock;
endmodule
