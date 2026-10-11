/*
 * Copyright (c) 2026 elcruzo
 * SPDX-License-Identifier: Apache-2.0
 *
 * Protocol emulator top level. Placeholder until the core lands: every output is held at a known value out of
 * reset so the GDS, precheck and gate-level flows run green from day one.
 */

`default_nettype none

module tt_um_elcruzo_protocol_emulator (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Flops don't power up at 0 on silicon, so everything stateful resets through rst_n.
  reg [7:0] out_q;

  always @(posedge clk) begin
    if (!rst_n) out_q <= 8'h00;
    else        out_q <= ui_in;
  end

  assign uo_out  = out_q;
  assign uio_out = 8'h00;
  assign uio_oe  = 8'h00;  // all bidirectional pins are inputs until the pin mux exists

  wire _unused = &{ena, uio_in, 1'b0};

endmodule
