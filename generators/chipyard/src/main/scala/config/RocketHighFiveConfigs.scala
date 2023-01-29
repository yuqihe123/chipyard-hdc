package chipyard

import freechips.rocketchip.config.{Config}
import freechips.rocketchip.diplomacy.{AsynchronousCrossing}

// --------------
// Rocket+HighFive Configs
// These live in a separate file to simplify patching out for the tutorials.
// --------------

// DOC include start: HighFiveRocket
class HighFiveRocketConfig extends Config(
  new hpu.WithHPUAccel ++                                // add HighFive rocc accelerator
  new freechips.rocketchip.subsystem.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
// DOC include end: HighFiveRocket
