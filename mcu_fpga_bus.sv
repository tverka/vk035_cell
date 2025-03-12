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

    // Регистр для управления fpga_ack
    logic [1:0] ack_counter;

    initial begin
        fpga_ack = 1'b0;
        ack_counter = 2'b00;
    end

    always_ff @(posedge CLK50) begin
        if (mcu_mstr) begin
            if (write_enable) begin
                // Запись данных в output_pins_state
                output_pins_state[address] <= data;
            end else begin
                // Чтение данных из input_pins_state
                //data <= input_pins_state[address];
                assign data = input_pins_state[address];
            end

            // Управление сигналом fpga_ack
            if (ack_counter == 2'b00) begin
                fpga_ack <= 1'b1;  // Поднимаем fpga_ack
                ack_counter <= ack_counter + 1;
            end else if (ack_counter == 2'b01) begin
                fpga_ack <= 1'b0;  // Опускаем fpga_ack
                ack_counter <= ack_counter + 1;
            end
        end else begin
            // Сброс счетчика и сигнала fpga_ack, если mcu_mstr не активен
            fpga_ack <= 1'b0;
            ack_counter <= 2'b00;
        end
    end

endmodule