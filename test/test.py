# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


async def reset(dut):
    # 10 us period (100 kHz), matching the template; raise it once the core has a timing target.
    cocotb.start_soon(Clock(dut.clk, 10, unit="us").start())
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1


@cocotb.test()
async def test_reset_state(dut):
    """Every output is known after reset, and the bidirectional pins start as inputs."""
    await reset(dut)
    assert dut.uo_out.value == 0
    assert dut.uio_out.value == 0
    assert dut.uio_oe.value == 0


@cocotb.test()
async def test_placeholder_passthrough(dut):
    """Placeholder behaviour (uo_out registers ui_in). Replace with protocol tests as the core lands."""
    await reset(dut)
    for v in (0x00, 0x5A, 0xA5, 0xFF):
        dut.ui_in.value = v
        await ClockCycles(dut.clk, 2)
        assert dut.uo_out.value == v
