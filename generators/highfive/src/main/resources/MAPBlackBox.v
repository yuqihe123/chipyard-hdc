module MAPBlackBox ( //fold width 64
	input         clk,
	input         rst,
  input  [63:0] rs1,//ca_90
  input  [63:0] rs2,//bundler
  input  [6:0] funct7;
	output [63:0] rd
 
);
reg i_hdop_src_sel,               // Source vector selection signal
reg [1:0]  i_hdop_op_sel;
  wire [BUS_WIDTH-1:0] o_res_vec;//will be used when fold width>64   

always @(*) begin
  case(funct7)
  7'd0: begin //hold
            i_hdop_src_sel=1'b1;
            i_hdop_op_sel=2'b00;
         end
    7'd1:begin //permute
            i_hdop_src_sel=1'b1;
            i_hdop_op_sel=2'b11;
         end
    7'd2:begin //load ca 90
            i_hdop_src_sel=1'b0;
            i_hdop_op_sel=2'b01;
         end
    7'd3:begin //load bund
            i_hdop_src_sel=1'b1;
            i_hdop_op_sel=2'b01;
         end
    7'd4:begin //bind ca 90
            i_hdop_src_sel=1'b0;
            i_hdop_op_sel=2'b10;
         end
    7'd5: begin //bind bundler
            i_hdop_src_sel=1'b1;
            i_hdop_op_sel=2'b10;
         end
    default: begin //deafult is hold
            i_hdop_src_sel=1'b1;
            i_hdop_op_sel=2'b00;
         end 
      endcase  
end  
  
hdop map_tester(clk,rst,rs1,rs2,rd, i_hdop_src_sel,i_hdop_op_sel);
	

endmodule
//notes:
                  //can we send multiple instructions without sending back rd?, 
                  //should we have four seperate instructions then to just send back rd?
                  //4*rocc_ss -state machines for constructing both input and output when fold_width >64
                  //4*rocc_d
                
               
               
                  
