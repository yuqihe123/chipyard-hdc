//see LICENSE for license
//authors: Colin Schmidt, Adam Izraelevitz
package hpu

import Chisel._
import scala.collection.mutable.HashMap
import scala.collection.mutable.ArrayBuffer
import scala.util.Random
import Chisel.ImplicitConversions._
import scala.collection.mutable.HashMap
import freechips.rocketchip.tile.HasCoreParameters
import freechips.rocketchip.rocket.constants.MemoryOpConstants
import freechips.rocketchip.config._

//see LICENSE for license
//authors: Colin Schmidt, Adam Izraelevitz


class CtrlModule(implicit val p: Parameters) extends Module
  with HasCoreParameters
  with MemoryOpConstants {

  val io = new Bundle {
    val rocc_req_val      = Bool(INPUT)
    val rocc_req_rdy      = Bool(OUTPUT)
    val rocc_funct        = Bits(INPUT, 2)
    val rocc_rs1          = Bits(INPUT, 64)
    val rocc_rs2          = Bits(INPUT, 64)
    val rocc_rd           = Bits(INPUT, 5)

    val busy              = Bool(OUTPUT)

    val dmem_req_val      = Bool(OUTPUT)
    val dmem_req_rdy      = Bool(INPUT)
    val dmem_req_tag      = Bits(OUTPUT, coreParams.dcacheReqTagBits)
    val dmem_req_addr     = Bits(OUTPUT, coreMaxAddrBits)
    val dmem_req_cmd      = Bits(OUTPUT, M_SZ)
    val dmem_req_size     = Bits(OUTPUT, log2Ceil(coreDataBytes + 1))

    val dmem_resp_val     = Bool(INPUT)
    val dmem_resp_tag     = Bits(INPUT, 7)
    val dmem_resp_data    = Bits(INPUT, 2) // W = 2

    val sfence            = Bool(OUTPUT)

    // Adder WS 
    val in1  = Input(UInt(4.W))
    val in2  = Input(UInt(4.W))
    val out = Output(UInt(4.W))

   
  }

  //WS adder
  io.out := io.in1 + io.in2


  //RoCC HANDLER
  //rocc pipe state
  val r_idle :: r_eat_addr :: r_eat_len :: Nil = Enum(UInt(), 3)

  val msg_addr = Reg(init = UInt(0,64))
  val hash_addr= Reg(init = UInt(0,64))
  val msg_len  = Reg(init = UInt(0,64))

  val busy = Reg(init=Bool(false))

  val rocc_s = Reg(init=r_idle)
  //register inputs
  val rocc_req_val_reg = Reg(next=io.rocc_req_val)
  val rocc_funct_reg = Reg(init = Bits(0,2))
  rocc_funct_reg := io.rocc_funct
  val rocc_rs1_reg = Reg(next=io.rocc_rs1)
  val rocc_rs2_reg = Reg(next=io.rocc_rs2)
  val rocc_rd_reg = Reg(next=io.rocc_rd)


  //default
  io.rocc_req_rdy := Bool(false)
  io.busy := busy
  /*
  io.dmem_req_val:= Bool(false)
  //io.dmem_req_tag:= rindex
  io.dmem_req_addr:= Bits(0, 32)
  io.dmem_req_cmd:= M_XRD
  io.dmem_req_size:= log2Ceil(8).U
  io.sfence      := Bool(false)
  */
  //val rindex_reg = Reg(next=rindex)


  switch(rocc_s) {
  is(r_idle) {
    io.rocc_req_rdy := !busy
    when(io.rocc_req_val && !busy){
      when(io.rocc_funct === UInt(0)){
        io.rocc_req_rdy := Bool(true)
        msg_addr  := io.rocc_rs1
        hash_addr := io.rocc_rs2
        println("Msg Addr: "+msg_addr+", Hash Addr: "+hash_addr)
        io.busy := Bool(true)
      }.elsewhen(io.rocc_funct === UInt(1)) {
        busy := Bool(true)
        io.rocc_req_rdy := Bool(true)
        io.busy := Bool(true)
        msg_len := io.rocc_rs1
      }
      /*  
      if (p(Sha3TLB).isDefined) {
        when (io.rocc_funct === UInt(2)) {
          io.rocc_req_rdy := Bool(true)
          io.sfence := Bool(true)
        }
      }*/
    }
  }
  }

  //END RoCC HANDLER
  //START MEM HANDLER
}