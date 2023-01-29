package hpu

import chisel3._
import chisel3.util._
import freechips.rocketchip.tile._
import freechips.rocketchip.config._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.rocket._
import freechips.rocketchip.tilelink._


class HPUAccel(opcodes: OpcodeSet)
    (implicit p: Parameters) extends LazyRoCC(opcodes) {
  override lazy val module = new HPUAccelModule(this)
}

class HPUAccelModule(outer: HPUAccel)
    extends LazyRoCCModuleImp(outer) {

  val HPUTop = Module(new HPUTop())

  io.cmd <> HPUTop.io.cmd
  io.resp <> HPUTop.io.resp
  io.busy <> HPUTop.io.busy   

}
