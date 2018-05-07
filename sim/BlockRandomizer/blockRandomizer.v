module blockRandomizer (clk, rst, outputBlock);
  output reg [7:0] outputBlock;
  input clk, rst;

  wire feedback;

  assign feedback = ~(outputBlock[7] ^ outputBlock[3]);

  always @ (posedge clk) begin
    if (rst == 0) begin
      outputBlock = 8'b0;
    end
    else begin
      outputBlock = {outputBlock[7:0], feedback};
    end
  end
endmodule
