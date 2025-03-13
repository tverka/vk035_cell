`include "mcu_fpga_bus.sv"
`include "io_pins_fpga.sv"
module main #(
    parameter PINS_CONT = 132
) (
    //from/to mcu
    inout logic [7:0] data,
    input logic [4:0] address,
    input logic mcu_mstr,
    input logic write_enable,
    output logic fpga_ready,
    output logic fpga_ack,

    //pins_fpga
    inout logic [PINS_CONT - 1:0] io_pins,

    //input clk
    input logic CLK50
);

    initial begin
        data = 8'hZZ;
        fpga_ready = 1'hz;
        for (int i  = 0; i < PINS_CONT; i = i + 1) begin
            io_pins[i] = 1'hZ;
        end
    end

    logic [7:0] input_pins_state [0:16];
    logic [7:0] output_pins_state [0:16];
    
    io_pins_fpga #(132) pins_process (
        CLK50,
        write_enable,
        io_pins,
        input_pins_state,
        output_pins_state
    );

    mcu_fpga_bus mf_bus(
        CLK50,
        write_enable,
        address,
        mcu_mstr,
        data,
        fpga_ack,
        input_pins_state,
        output_pins_state

    );

    
    
endmodule