module PointAwarder(stacked, blocksPlaced, heightMultiplier, pntOutput);
  input stacked;
  input [1:0] blocksPlaced;
  input [2:0] heightMultiplier;
  output [4:0] pntOutput;

  reg [4:0] pntMul;
  always @ (posedge stacked) begin
    pntMul <= heightMultiplier * blocksPlaced;
  end

  assign pntOutput = pntMul;
endmodule
