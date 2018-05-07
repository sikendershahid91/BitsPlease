module SegRunner (inputBlock, segOut);

  input [7:0] inputBlock;
  output [7:0] segOut;
  reg [7:0] segOut;

  always @ (inputBlock) begin
    segOut <= (inputBlock);
  end
endmodule
