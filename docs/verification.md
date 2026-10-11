# Verification

The judges weigh this as heavily as protocol count. Keep it current as we go.

## Plan

- **Unit tests** per block in cocotb (`test/`)
- **Protocol tests** run each example program against a reference model of the far side (UART receiver, SPI
  target, I2C target)
- **Formal** checks on the core and loader with SymbiYosys
- **Gate level** reruns of the cocotb suite on the hardened netlist (CI does this on every push)
- **FPGA** bring-up on the iCE40 flow before tapeout

## Coverage

What each protocol test covers and what it leaves out goes here.
