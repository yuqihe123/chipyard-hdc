//see LICENSE for license
//authors: Colin Schmidt, Adam Izraelevitz
package hpu

import Chisel._
import chisel3.util.{HasBlackBoxResource}
import freechips.rocketchip.tile._
import freechips.rocketchip.config._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.rocket.{TLBConfig, HellaCacheReq}

/*
 * Enable specific printf's. This is used to demonstrate MIDAS
 * printf's during the MICRO2019 tutorial.
 */
case object HPUPrintfEnable extends Field[Boolean](false)

/*
 * Use a Blackbox verilog version of the inner HPU accelerator
 */
// case object HPUBlackBox extends Field[Boolean](false)
// case object HPUTLB extends Field[Option[TLBConfig]](None)

class WrapBundle(nPTWPorts: Int)(implicit p: Parameters) extends Bundle {
  val io = new RoCCIO(nPTWPorts)
  val clock = Clock(INPUT)
  val reset = Input(UInt(1.W))
}

class HPUBlackBox(implicit p: Parameters) extends BlackBox with HasBlackBoxResource {
  val io = IO(new WrapBundle(0))

  addResource("/vsrc/HPUBlackBox.v")
}
class AdderBlackBox(implicit p: Parameters) extends BlackBox{
  val io = IO(new Bundle{
	  val in1 = Bits(Input,4)
	  val in2= Bits(Input,4)
	  val out= Bits(OUTPUT,4)}

  addResource("/vsrc/AdderBlackBox.v") 
  io.in1.setName("in1")
  io.in2.setName("in2")
  io.out.setName("out")
  moduleName="adder"
	    
}


class HPUAccel(opcodes: OpcodeSet)(implicit p: Parameters) extends LazyRoCC(
    opcodes = opcodes, nPTWPorts = if (p(HPUTLB).isDefined) 1 else 0) {
  override lazy val module = new HPUAccelImp(this)
  val dmemOpt = p(HPUTLB).map { _ =>
    val dmem = LazyModule(new DmemModule)
    tlNode := dmem.node
    dmem
  }
}

class HPUAccelImp(outer: HPUAccel)(implicit p: Parameters) extends LazyRoCCModuleImp(outer) {
  // Suppress DCE to ensure that the module ports are kept consistent
  // between the regular generated Verilog and HPUBlackBox version
  chisel3.dontTouch(io)

  //RoCC Interface defined in testMems.scala
  //cmd
  //resp
	// Should we change resp.valid for HPU?
  io.resp.valid := Bool(false) //Sha3 never returns values with the resp
  //mem
  //busy
  require(!p(HPUTLB).isDefined, "Blackbox HPU does not support Dmemmodule")
  
  val hpubb = Module(new HPUBlackBox)
  io <> hpubb.io.io
  hpubb.io.clock := clock
  hpubb.io.reset := reset
}

class WithHPUAccel extends Config ((site, here, up) => {
  case HPUTLB => None  // Blackbox HPU does not support dmem
  case BuildRoCC => up(BuildRoCC) ++ Seq(
    (p: Parameters) => {
      val hpu = LazyModule.apply(new HPUAccel(OpcodeSet.custom2)(p))
      hpu
    }
  )
})

class WithHPUPrintf extends Config((site, here, up) => {
  case HPUPrintfEnable => true
})
