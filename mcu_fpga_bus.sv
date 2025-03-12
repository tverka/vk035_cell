module mcu_fpga_bus (
    input logic CLK50,
    input logic write_enable,
    input logic [4:0] address,
    input logic mcu_mstr,
    inout logic [7:0] data,
    output logic fpga_ack,

    input logic [7:0] input_pins_state [0:16], 
    output logic [7:0] output_pins_state [0:16] 
    

);

    initial begin
        fpga_ack = 1'b0;
    end

    always_ff @( posedge CLK50 ) begin
        if (mcu_mstr) begin
        
            if (write_enable) begin
                //assign output_pins_state[address] = data;
                assign data = 8'hz;
                output_pins_state[address] <= data;
                for (int i = 0; i < 2; i = i + 1) begin
                    fpga_ack <= ~fpga_ack;
                end
                
            end else begin
                //assign data = input_pins_state[address];
                assign data = input_pins_state[address];
                for (int i = 0; i < 2; i = i + 1) begin
                    fpga_ack <= ~fpga_ack;
                end
            end     
        end
    end
    
    
endmodule