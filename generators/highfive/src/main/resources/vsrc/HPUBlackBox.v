module CtrlModule(
  input         clock,
  input         reset,
  input         io_rocc_req_val,
  output        io_rocc_req_rdy,
  input  [1:0]  io_rocc_funct,
  input  [63:0] io_rocc_rs1,
  input  [63:0] io_rocc_rs2,
  output        io_busy,
  output        io_dmem_req_val,
  input         io_dmem_req_rdy,
  output [5:0]  io_dmem_req_tag,
  output [39:0] io_dmem_req_addr,
  output [4:0]  io_dmem_req_cmd,
  input         io_dmem_resp_val,
  input  [6:0]  io_dmem_resp_tag,
  input  [63:0] io_dmem_resp_data,
  output [4:0]  io_round,
  output        io_absorb,
  output [4:0]  io_aindex,
  output        io_init,
  output        io_write,
  output [2:0]  io_windex,
  output [63:0] io_buffer_out
);

// TODO: Add control module here

endmodule

module HPUBlackBox(
  input         clock,
  input         reset,
  output        io_cmd_ready,
  input         io_cmd_valid,
  input  [6:0]  io_cmd_bits_inst_funct,
  input  [4:0]  io_cmd_bits_inst_rs2,
  input  [4:0]  io_cmd_bits_inst_rs1,
  input         io_cmd_bits_inst_xd,
  input         io_cmd_bits_inst_xs1,
  input         io_cmd_bits_inst_xs2,
  input  [4:0]  io_cmd_bits_inst_rd,
  input  [6:0]  io_cmd_bits_inst_opcode,
  input  [63:0] io_cmd_bits_rs1,
  input  [63:0] io_cmd_bits_rs2,
  input         io_cmd_bits_status_debug,
  input         io_cmd_bits_status_cease,
  input         io_cmd_bits_status_wfi,
  input  [31:0] io_cmd_bits_status_isa,
  input  [1:0]  io_cmd_bits_status_dprv,
  input         io_cmd_bits_status_dv,
  input  [1:0]  io_cmd_bits_status_prv,
  input         io_cmd_bits_status_v,
  input         io_cmd_bits_status_sd,
  input  [22:0] io_cmd_bits_status_zero2,
  input         io_cmd_bits_status_mpv,
  input         io_cmd_bits_status_gva,
  input         io_cmd_bits_status_mbe,
  input         io_cmd_bits_status_sbe,
  input  [1:0]  io_cmd_bits_status_sxl,
  input  [1:0]  io_cmd_bits_status_uxl,
  input         io_cmd_bits_status_sd_rv32,
  input  [7:0]  io_cmd_bits_status_zero1,
  input         io_cmd_bits_status_tsr,
  input         io_cmd_bits_status_tw,
  input         io_cmd_bits_status_tvm,
  input         io_cmd_bits_status_mxr,
  input         io_cmd_bits_status_sum,
  input         io_cmd_bits_status_mprv,
  input  [1:0]  io_cmd_bits_status_xs,
  input  [1:0]  io_cmd_bits_status_fs,
  input  [1:0]  io_cmd_bits_status_mpp,
  input  [1:0]  io_cmd_bits_status_vs,
  input         io_cmd_bits_status_spp,
  input         io_cmd_bits_status_mpie,
  input         io_cmd_bits_status_ube,
  input         io_cmd_bits_status_spie,
  input         io_cmd_bits_status_upie,
  input         io_cmd_bits_status_mie,
  input         io_cmd_bits_status_hie,
  input         io_cmd_bits_status_sie,
  input         io_cmd_bits_status_uie,
  input         io_resp_ready,
  output        io_resp_valid,
  output [4:0]  io_resp_bits_rd,
  output [63:0] io_resp_bits_data,
  input         io_mem_req_ready,
  output        io_mem_req_valid,
  output [39:0] io_mem_req_bits_addr,
  output [7:0]  io_mem_req_bits_tag,
  output [4:0]  io_mem_req_bits_cmd,
  output [1:0]  io_mem_req_bits_size,
  output        io_mem_req_bits_signed,
  output [1:0]  io_mem_req_bits_dprv,
  output        io_mem_req_bits_dv,
  output        io_mem_req_bits_phys,
  output        io_mem_req_bits_no_alloc,
  output        io_mem_req_bits_no_xcpt,
  output [63:0] io_mem_req_bits_data,
  output [7:0]  io_mem_req_bits_mask,
  output        io_mem_s1_kill,
  output [63:0] io_mem_s1_data_data,
  output [7:0]  io_mem_s1_data_mask,
  input         io_mem_s2_nack,
  input         io_mem_s2_nack_cause_raw,
  output        io_mem_s2_kill,
  input         io_mem_s2_uncached,
  input  [31:0] io_mem_s2_paddr,
  input         io_mem_resp_valid,
  input  [39:0] io_mem_resp_bits_addr,
  input  [7:0]  io_mem_resp_bits_tag,
  input  [4:0]  io_mem_resp_bits_cmd,
  input  [1:0]  io_mem_resp_bits_size,
  input         io_mem_resp_bits_signed,
  input  [1:0]  io_mem_resp_bits_dprv,
  input         io_mem_resp_bits_dv,
  input  [63:0] io_mem_resp_bits_data,
  input  [7:0]  io_mem_resp_bits_mask,
  input         io_mem_resp_bits_replay,
  input         io_mem_resp_bits_has_data,
  input  [63:0] io_mem_resp_bits_data_word_bypass,
  input  [63:0] io_mem_resp_bits_data_raw,
  input  [63:0] io_mem_resp_bits_store_data,
  input         io_mem_replay_next,
  input         io_mem_s2_xcpt_ma_ld,
  input         io_mem_s2_xcpt_ma_st,
  input         io_mem_s2_xcpt_pf_ld,
  input         io_mem_s2_xcpt_pf_st,
  input         io_mem_s2_xcpt_gf_ld,
  input         io_mem_s2_xcpt_gf_st,
  input         io_mem_s2_xcpt_ae_ld,
  input         io_mem_s2_xcpt_ae_st,
  input  [39:0] io_mem_s2_gpa,
  input         io_mem_s2_gpa_is_pte,
  input         io_mem_ordered,
  input         io_mem_perf_acquire,
  input         io_mem_perf_release,
  input         io_mem_perf_grant,
  input         io_mem_perf_tlbMiss,
  input         io_mem_perf_blocked,
  input         io_mem_perf_canAcceptStoreThenLoad,
  input         io_mem_perf_canAcceptStoreThenRMW,
  input         io_mem_perf_canAcceptLoadThenLoad,
  input         io_mem_perf_storeBufferEmptyAfterLoad,
  input         io_mem_perf_storeBufferEmptyAfterStore,
  output        io_mem_keep_clock_enabled,
  input         io_mem_clock_enabled,
  output        io_busy,
  output        io_interrupt,
  input         io_exception,
  input         io_fpu_req_ready,
  output        io_fpu_req_valid,
  output        io_fpu_req_bits_ldst,
  output        io_fpu_req_bits_wen,
  output        io_fpu_req_bits_ren1,
  output        io_fpu_req_bits_ren2,
  output        io_fpu_req_bits_ren3,
  output        io_fpu_req_bits_swap12,
  output        io_fpu_req_bits_swap23,
  output [1:0]  io_fpu_req_bits_typeTagIn,
  output [1:0]  io_fpu_req_bits_typeTagOut,
  output        io_fpu_req_bits_fromint,
  output        io_fpu_req_bits_toint,
  output        io_fpu_req_bits_fastpipe,
  output        io_fpu_req_bits_fma,
  output        io_fpu_req_bits_div,
  output        io_fpu_req_bits_sqrt,
  output        io_fpu_req_bits_wflags,
  output [2:0]  io_fpu_req_bits_rm,
  output [1:0]  io_fpu_req_bits_fmaCmd,
  output [1:0]  io_fpu_req_bits_typ,
  output [1:0]  io_fpu_req_bits_fmt,
  output [64:0] io_fpu_req_bits_in1,
  output [64:0] io_fpu_req_bits_in2,
  output [64:0] io_fpu_req_bits_in3,
  output        io_fpu_resp_ready,
  input         io_fpu_resp_valid,
  input  [64:0] io_fpu_resp_bits_data,
  input  [4:0]  io_fpu_resp_bits_exc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  ctrl_clock; // @[sha3.scala 109:22]
  wire  ctrl_reset; // @[sha3.scala 109:22]
  wire  ctrl_io_rocc_req_val; // @[sha3.scala 109:22]
  wire  ctrl_io_rocc_req_rdy; // @[sha3.scala 109:22]
  wire [1:0] ctrl_io_rocc_funct; // @[sha3.scala 109:22]
  wire [63:0] ctrl_io_rocc_rs1; // @[sha3.scala 109:22]
  wire [63:0] ctrl_io_rocc_rs2; // @[sha3.scala 109:22]
  wire  ctrl_io_busy; // @[sha3.scala 109:22]
  wire  ctrl_io_dmem_req_val; // @[sha3.scala 109:22]
  wire  ctrl_io_dmem_req_rdy; // @[sha3.scala 109:22]
  wire [5:0] ctrl_io_dmem_req_tag; // @[sha3.scala 109:22]
  wire [39:0] ctrl_io_dmem_req_addr; // @[sha3.scala 109:22]
  wire [4:0] ctrl_io_dmem_req_cmd; // @[sha3.scala 109:22]
  wire  ctrl_io_dmem_resp_val; // @[sha3.scala 109:22]
  wire [6:0] ctrl_io_dmem_resp_tag; // @[sha3.scala 109:22]
  wire [63:0] ctrl_io_dmem_resp_data; // @[sha3.scala 109:22]
  wire [4:0] ctrl_io_round; // @[sha3.scala 109:22]
  wire  ctrl_io_absorb; // @[sha3.scala 109:22]
  wire [4:0] ctrl_io_aindex; // @[sha3.scala 109:22]
  wire  ctrl_io_init; // @[sha3.scala 109:22]
  wire  ctrl_io_write; // @[sha3.scala 109:22]
  wire [2:0] ctrl_io_windex; // @[sha3.scala 109:22]
  wire [63:0] ctrl_io_buffer_out; // @[sha3.scala 109:22]
  wire  dpath_clock; // @[sha3.scala 152:23]
  wire  dpath_reset; // @[sha3.scala 152:23]
  wire  dpath_io_absorb; // @[sha3.scala 152:23]
  wire  dpath_io_init; // @[sha3.scala 152:23]
  wire  dpath_io_write; // @[sha3.scala 152:23]
  wire [4:0] dpath_io_round; // @[sha3.scala 152:23]
  wire [4:0] dpath_io_aindex; // @[sha3.scala 152:23]
  wire [63:0] dpath_io_message_in; // @[sha3.scala 152:23]
  wire [63:0] dpath_io_hash_out_0; // @[sha3.scala 152:23]
  wire [63:0] dpath_io_hash_out_1; // @[sha3.scala 152:23]
  wire [63:0] dpath_io_hash_out_2; // @[sha3.scala 152:23]
  wire [63:0] dpath_io_hash_out_3; // @[sha3.scala 152:23]
  wire  _status_T = io_cmd_ready & io_cmd_valid; // @[Decoupled.scala 50:35]
  reg [1:0] status_dprv; // @[Reg.scala 16:16]
  reg  status_dv; // @[Reg.scala 16:16]
  wire [63:0] _GEN_37 = dpath_io_hash_out_0; // @[sha3.scala 155:{15,15}]
  wire [63:0] _GEN_38 = 2'h1 == ctrl_io_windex[1:0] ? dpath_io_hash_out_1 : _GEN_37; // @[sha3.scala 155:{15,15}]
  wire [63:0] _GEN_39 = 2'h2 == ctrl_io_windex[1:0] ? dpath_io_hash_out_2 : _GEN_38; // @[sha3.scala 155:{15,15}]
  CtrlModule ctrl ( // @[sha3.scala 109:22]
    .clock(ctrl_clock),
    .reset(ctrl_reset),
    .io_rocc_req_val(ctrl_io_rocc_req_val),
    .io_rocc_req_rdy(ctrl_io_rocc_req_rdy),
    .io_rocc_funct(ctrl_io_rocc_funct),
    .io_rocc_rs1(ctrl_io_rocc_rs1),
    .io_rocc_rs2(ctrl_io_rocc_rs2),
    .io_busy(ctrl_io_busy),
    .io_dmem_req_val(ctrl_io_dmem_req_val),
    .io_dmem_req_rdy(ctrl_io_dmem_req_rdy),
    .io_dmem_req_tag(ctrl_io_dmem_req_tag),
    .io_dmem_req_addr(ctrl_io_dmem_req_addr),
    .io_dmem_req_cmd(ctrl_io_dmem_req_cmd),
    .io_dmem_resp_val(ctrl_io_dmem_resp_val),
    .io_dmem_resp_tag(ctrl_io_dmem_resp_tag),
    .io_dmem_resp_data(ctrl_io_dmem_resp_data),
    .io_round(ctrl_io_round),
    .io_absorb(ctrl_io_absorb),
    .io_aindex(ctrl_io_aindex),
    .io_init(ctrl_io_init),
    .io_write(ctrl_io_write),
    .io_windex(ctrl_io_windex),
    .io_buffer_out(ctrl_io_buffer_out)
  );
  assign io_cmd_ready = ctrl_io_rocc_req_rdy; // @[sha3.scala 112:18]
  assign io_resp_valid = 1'h0; // @[sha3.scala 97:17]
  assign io_resp_bits_rd = 5'h0;
  assign io_resp_bits_data = 64'h0;
  assign io_mem_req_valid = ctrl_io_dmem_req_val; // @[sha3.scala 122:17]
  assign io_mem_req_bits_addr = ctrl_io_dmem_req_addr; // @[sha3.scala 125:21]
  assign io_mem_req_bits_tag = {{2'd0}, ctrl_io_dmem_req_tag}; // @[sha3.scala 124:20]
  assign io_mem_req_bits_cmd = ctrl_io_dmem_req_cmd; // @[sha3.scala 126:20]
  assign io_mem_req_bits_size = 2'h3; // @[sha3.scala 127:21]
  assign io_mem_req_bits_signed = 1'h0; // @[sha3.scala 129:23]
  assign io_mem_req_bits_dprv = status_dprv; // @[sha3.scala 130:21]
  assign io_mem_req_bits_dv = status_dv; // @[sha3.scala 131:19]
  assign io_mem_req_bits_phys = 1'h0; // @[sha3.scala 132:21]
  assign io_mem_req_bits_no_alloc = 1'h0;
  assign io_mem_req_bits_no_xcpt = 1'h0;
  assign io_mem_req_bits_data = 2'h3 == ctrl_io_windex[1:0] ? dpath_io_hash_out_3 : _GEN_39; // @[sha3.scala 155:{15,15}]
  assign io_mem_req_bits_mask = 8'h0;
  assign io_mem_s1_kill = 1'h0;
  assign io_mem_s1_data_data = 64'h0;
  assign io_mem_s1_data_mask = 8'h0;
  assign io_mem_s2_kill = 1'h0;
  assign io_mem_keep_clock_enabled = 1'h0;
  assign io_busy = ctrl_io_busy; // @[sha3.scala 117:13]
  assign io_interrupt = 1'h0;
  assign io_fpu_req_valid = 1'h0;
  assign io_fpu_req_bits_ldst = 1'h0;
  assign io_fpu_req_bits_wen = 1'h0;
  assign io_fpu_req_bits_ren1 = 1'h0;
  assign io_fpu_req_bits_ren2 = 1'h0;
  assign io_fpu_req_bits_ren3 = 1'h0;
  assign io_fpu_req_bits_swap12 = 1'h0;
  assign io_fpu_req_bits_swap23 = 1'h0;
  assign io_fpu_req_bits_typeTagIn = 2'h0;
  assign io_fpu_req_bits_typeTagOut = 2'h0;
  assign io_fpu_req_bits_fromint = 1'h0;
  assign io_fpu_req_bits_toint = 1'h0;
  assign io_fpu_req_bits_fastpipe = 1'h0;
  assign io_fpu_req_bits_fma = 1'h0;
  assign io_fpu_req_bits_div = 1'h0;
  assign io_fpu_req_bits_sqrt = 1'h0;
  assign io_fpu_req_bits_wflags = 1'h0;
  assign io_fpu_req_bits_rm = 3'h0;
  assign io_fpu_req_bits_fmaCmd = 2'h0;
  assign io_fpu_req_bits_typ = 2'h0;
  assign io_fpu_req_bits_fmt = 2'h0;
  assign io_fpu_req_bits_in1 = 65'h0;
  assign io_fpu_req_bits_in2 = 65'h0;
  assign io_fpu_req_bits_in3 = 65'h0;
  assign io_fpu_resp_ready = 1'h0;
  assign ctrl_clock = clock;
  assign ctrl_reset = reset;
  assign ctrl_io_rocc_req_val = io_cmd_valid; // @[sha3.scala 111:28]
  assign ctrl_io_rocc_funct = io_cmd_bits_inst_funct[1:0]; // @[sha3.scala 113:28]
  assign ctrl_io_rocc_rs1 = io_cmd_bits_rs1; // @[sha3.scala 114:28]
  assign ctrl_io_rocc_rs2 = io_cmd_bits_rs2; // @[sha3.scala 115:28]
  assign ctrl_io_dmem_req_rdy = io_mem_req_ready; // @[sha3.scala 123:28]
  assign ctrl_io_dmem_resp_val = io_mem_resp_valid; // @[sha3.scala 148:28]
  assign ctrl_io_dmem_resp_tag = io_mem_resp_bits_tag[6:0]; // @[sha3.scala 149:28]
  assign ctrl_io_dmem_resp_data = io_mem_resp_bits_data; // @[sha3.scala 150:28]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io_absorb = ctrl_io_absorb; // @[sha3.scala 158:21]
  assign dpath_io_init = ctrl_io_init; // @[sha3.scala 159:19]
  assign dpath_io_write = ctrl_io_write; // @[sha3.scala 160:20]
  assign dpath_io_round = ctrl_io_round; // @[sha3.scala 161:20]
  assign dpath_io_aindex = ctrl_io_aindex; // @[sha3.scala 163:21]
  assign dpath_io_message_in = ctrl_io_buffer_out; // @[sha3.scala 154:25]
  always @(posedge clock) begin
    if (_status_T) begin // @[Reg.scala 17:18]
      status_dprv <= io_cmd_bits_status_dprv; // @[Reg.scala 17:22]
    end
    if (_status_T) begin // @[Reg.scala 17:18]
      status_dv <= io_cmd_bits_status_dv; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  status_dprv = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  status_dv = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
