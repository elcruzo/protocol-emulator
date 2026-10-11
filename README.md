![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Protocol Emulator

Our entry to the Jane Street protocol emulator ASIC competition: a chip on the Tiny Tapeout IHP CMOS5L shuttle
that can be reprogrammed after fabrication to speak serial protocols.

- **Deadline:** 18 January 2027 (repo must be public by then)
- **Shuttle:** IHP SG13CMOS5L, March 2027
- **Area:** 6x4 tiles now, 8x4 once Tiny Tapeout ships the template (expected mid-October)
- **Pins:** 8 in, 8 out, 8 bidirectional, plus `clk` and `rst_n`. 3.3 V I/O on the demo board, no analog pads

## Goals

| Tier | Protocols |
|---|---|
| Baseline | UART (common baud rates), SPI modes 0 to 3, I2C at 100 and 400 kHz |
| Stretch | Low-speed USB, 10 Mbit Ethernet (line coding, CRC, clock recovery on chip) |
| Plus | Concurrent protocols, controller and target roles |

Judging weighs flexibility most (can it run a protocol it was not designed for), then protocols shown, what the
architecture uniquely enables, and how it was designed and verified.

## Layout

| Path | What lives there |
|---|---|
| `src/` | RTL. Every file must be listed in `info.yaml` and `test/Makefile` |
| `test/` | cocotb tests (`make -B`, gate level with `make -B GATES=yes`) |
| `sw/` | Assembler or toolchain, loader, and example programs per protocol |
| `docs/info.md` | Tiny Tapeout datasheet page |
| `docs/architecture.md` | Architecture and pin mapping |
| `docs/isa.md` | Instruction set |
| `docs/verification.md` | How we verified it |
| `docs/ai-usage.md` | How we used AI tools (the rules ask for this) |

## Running tests

```sh
pip install -r test/requirements.txt   # cocotb; also needs iverilog
cd test && make -B
```

Pushing runs `test`, `gds` (LibreLane harden, precheck, gate-level test) and `docs`. A full 8x4 design can hit the
6 hour Actions limit; if it does, harden locally with the same flow: https://tinytapeout.com/guides/local-hardening/

## What we submit

1. Public repo with RTL, tests and a passing GDS and precheck from the Tiny Tapeout flow
2. Architecture and instruction set docs
3. Assembler or toolchain with example programs
4. Verification write-up
5. AI usage write-up
6. Optional video or demo

## Reference

- Competition contact: asic-competition@janestreet.com, and the competitions channel on the Tiny Tapeout Discord
- SRAM macro on a CMOS5L tile: https://kdp1965.github.io/ihp-um-janestreet-prism/ihp_sram_macro.html
- Demo board and Pmods: https://tinytapeout.com/specs/pcb-etr/ and https://tinytapeout.com/specs/pinouts/
- FPGA to ASIC notes: https://tinytapeout.com/hdl/fpga_vs_asic/
