package hpu

import chisel3._
import chisel3.util._
import freechips.rocketchip.tile._
import freechips.rocketchip.config._
import freechips.rocketchip.diplomacy._

class WithHPUAccel extends Config((site, here, up) => {
  case BuildRoCC => up(BuildRoCC) ++ Seq((p: Parameters) => {
    val hpu = LazyModule(new HPUAccel(OpcodeSet.custom0)(p))
    hpu
  })
})
