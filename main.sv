//`include "mcu_fpga_bus.sv"
//`include "io_pins_fpga.sv"
module main #(
    parameter PINS_CONT = 128
) (
    //from/to mcu
    inout wire [7:0] data,
    input logic [4:0] address,
    input logic mcu_mstr,
    input logic write_enable,
    output logic fpga_ready,
    output logic fpga_ack,

    //pins_fpga
    inout wire [128 - 1:0] io_pins,

    //input clk
    input logic CLK50
);
    logic [15:0] write_read;

    assign data = 8'bzzzz_zzzz;
    initial begin
        
        
            
            // for (int i = 0; i < 8; i = i + 1) begin
                
            //     data[i] = 1'bz;
            // end
            
        

        fpga_ready = 1'hz;
        for (int i  = 0; i < PINS_CONT; i = i + 1) begin
            io_pins[i] = 1'hZ;
        end
    end

    logic [7:0] reg_data_in [0:15];
    logic [7:0] reg_data_out [0:15];
    
    io_pins_fpga pins_process (
        io_pins,
        write_read,
        reg_data_in,
        reg_data_out
        
        
    );

    mcu_fpga_bus mf_bus(
        CLK50,
        write_enable,
        address,
        mcu_mstr,
        data,
        write_read,
        fpga_ack,
        reg_data_in,
        reg_data_out

    );

    
    
endmodule
