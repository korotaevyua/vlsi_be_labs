/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_1_V
`define SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_1_V

/**
 * lpflow_lsbuf_lh_hl_isowell_tap: Level-shift buffer, low-to-high,
 *                                 isolated well on input buffer,
 *                                 vpb/vnb taps, double-row-height
 *                                 cell.
 *
 * Verilog wrapper for lpflow_lsbuf_lh_hl_isowell_tap with
 * size of 1 units.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`include "sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap.v"

`ifdef USE_POWER_PINS
/*********************************************************/

`celldefine
module sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1 (
    X     ,
    A     ,
    VPWRIN,
    VPWR  ,
    VGND  ,
    VPB
);

    output X     ;
    input  A     ;
    input  VPWRIN;
    input  VPWR  ;
    input  VGND  ;
    input  VPB   ;
    sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap base (
        .X(X),
        .A(A),
        .VPWRIN(VPWRIN),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB)
    );

endmodule
`endcelldefine

/*********************************************************/
`else // If not USE_POWER_PINS
/*********************************************************/

`celldefine
module sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1 (
    X,
    A
);

    output X;
    input  A;

    // Voltage supply signals
    wire    VPWRIN;
    supply1 VPWR  ;
    supply0 VGND  ;
    supply1 VPB   ;

    sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap base (
        .X(X),
        .A(A)
    );

endmodule
`endcelldefine

/*********************************************************/
`endif // USE_POWER_PINS

`default_nettype wire
`endif  // SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_1_V
