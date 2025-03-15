module mcu_fpga_bus (
    input logic CLK50,
    input logic write_enable,
    input logic [4:0] address,
    input logic mcu_mstr,
    inout wire [7:0] data,
    output logic [15:0] write_read,
    output logic fpga_ack,

    input logic [7:0] reg_data_in [0:15], 
    output logic [7:0] reg_data_out [0:15] 
);

    // Регистр для управления fpga_ack
    logic [1:0] ack_counter;

    
    logic [7:0] data_out;
    assign data = (mcu_mstr && !write_enable) ? data_out : 8'bZZZZZZZZ;

    initial begin
        fpga_ack = 1'b0;
        ack_counter = 2'b00;
    end

    always_ff @(posedge CLK50) begin
        if (mcu_mstr) begin
            if (write_enable) begin
                // Запись данных в output_pins_state
                reg_data_out[address] <= data;
                write_read[address] <= 1;
            end else begin
                // Чтение данных из input_pins_state и передача на data_out
                write_read[address] <= 0;
                data_out <= reg_data_in[address];
            end

            
            if (ack_counter == 2'b00) begin
                fpga_ack <= 1'b1;  // Поднимаем fpga_ack
                ack_counter <= ack_counter + 1;
            end else if (ack_counter == 2'b01) begin
                fpga_ack <= 1'b0;  // Опускаем fpga_ack
                ack_counter <= ack_counter + 1;
            end
        end else begin
            
            fpga_ack <= 1'b0;
            ack_counter <= 2'b00;
        end
    end

endmodule
