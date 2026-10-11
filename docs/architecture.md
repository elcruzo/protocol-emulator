# Architecture

Not decided yet. Record the choice and why here.

## Options on the table

- **Protocol processor.** A small core with shift registers, bit counters and pin-level instructions (set, sample,
  wait for edge, shift). Easiest to toolchain and the most common approach.
- **Several engines sharing a pipeline.** Lets protocols run concurrently.
- **Small eFPGA fabric.** Most flexible, hardest to fit and to write tools for.

## Things any choice must cover

- Program memory: IHP SRAM macro(s) or flops, and how it fits in 6x4 (8x4 later)
- Loader: how the host (the demo board microcontroller) writes a program after reset and after reselect
- Pin mux: which of `ui`, `uo`, `uio` each engine can drive or sample, and `uio_oe` control
- Clocking: target frequency after place-and-route, and how it maps to baud rates and I2C/SPI timing
- Reset: every stateful element resets through `rst_n`
