<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

A reprogrammable protocol engine. A program loaded from the host after reset decides which pins carry which signals
and how bits are framed, so the same silicon can speak UART, SPI, I2C and protocols it was not designed for.

The core is not in yet. The current build registers `ui_in` onto `uo_out` so the flow stays green.

## How to test

1. Hold `rst_n` low for at least 10 clocks, then release it.
2. Load a program from the demo board's microcontroller (loader protocol to be documented in `architecture.md`).
3. Reload the program whenever the design is deselected, since it loses state when powered down.

## External hardware

None yet. Anything a protocol needs (pull-ups for I2C, a transceiver for USB) will be listed here with its Pmod.
