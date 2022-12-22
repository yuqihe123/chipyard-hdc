package chipyard

import freechips.rocketchip.config.{Config}
import freechips.rocketchip.diplomacy.{AsynchronousCrossing}

// --------------
// Rocket+HighFive Configs
// These live in a separate file to simplify patching out for the tutorials.
// --------------

// DOC include start: HighFiveRocket
class HighFiveRocketConfig extends Config(
  new highfive.WithSha3Accel ++                                // add HighFive rocc accelerator
  new freechips.rocketchip.subsystem.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
// DOC include end: HighFiveRocket

/*
class Sha3RocketPrintfConfig extends Config(
  new sha3.WithSha3Printf ++
  new sha3.WithSha3Accel ++                                // add SHA3 rocc accelerator
  new freechips.rocketchip.subsystem.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
*/
