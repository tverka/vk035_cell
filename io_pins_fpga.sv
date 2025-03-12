module io_pins_fpga #(
    parameter PINS_CONT = 132
) (
    input logic CLK50,             
    input logic write_enable,        
    inout wire [PINS_CONT - 1:0] io_pins,
    output logic [7:0] input_pins_state [0:16], 
    input logic [7:0] output_pins_state [0:16] 
);
    
    always_ff @(posedge CLK50) begin
        if (write_enable) begin
            
            
            for (int i = 0; i < PINS_CONT; i = i + 1) begin
                io_pins[i] = output_pins_state[i];
            end
        end else begin
            
            
            for (int i = 0; i < PINS_CONT; i = i + 1) begin
                input_pins_state[i] = io_pins[i];
            end
        end
        
    end
    assign io_pins = write_enable ? output_pins_state : {PINS_CONT{1'bz}};
    // Управление тристатными состояниями
    

endmodule