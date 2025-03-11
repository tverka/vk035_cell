`include "mcu_fpga_bus.sv"
module main #(
    parameter PINS_CONT = 132
) (
    //from/to mcu
    inout logic [7:0] data,
    input logic [7:0] address,
    input logic mcu_mstr,
    input logic write_enable,
    output fpga_ready,

    //pins_fpga
    inout logic [PINS_CONT - 1:0] io_pins,

    //input clk
    input logic CLK50
);

    initial begin
        data = 8'hZZ;
        fpga_ready = 1'hz;
        io_pins = 132'hZZ;
    end

    logic [7:0] memory_pin_state [0:16];

    
    io_pins_fpga pins_process(
        CLK50,
        write_enable,
        io_pins,
        memory_pin_state
    );

    
    
endmodule