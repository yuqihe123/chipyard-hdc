module HPUBlackBox (
	input         clk,
	input         rst,
	input  [63:0] rs1,
	input  [63:0] rs2,
	output [63:0] rd
);
	assign rd = rs1 + rs2;

endmodule
