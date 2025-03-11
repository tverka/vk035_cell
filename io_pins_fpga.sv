module io_pins_fpga #(
    parameter PINS_CONT = 132
) (
    input logic CLK50,               // Тактовый сигнал
    input logic write_enable,        // Сигнал разрешения записи (1 - запись, 0 - чтение)
    inout logic [PINS_CONT - 1:0] io_pins, // Входы/выходы пинов
    inout logic [7:0] memory_pin_state [0:16] // Память для хранения состояния пинов
);
    initial begin
        for (int i = 0; i < PINS_CONT+4; i = i + 1) begin
            memory_pin_state[i / 8][i % 8] = 1'hz;
        end
    end
    // Логика чтения и записи
    always_ff @( posedge CLK50 )begin
        if (write_enable) begin
            // Запись данных из io_pins в memory_pin_state
            for (int i = 0; i < PINS_CONT; i = i + 1) begin
                io_pins[i] = memory_pin_state[i / 8][i % 8];
            end
        end else begin
            // Чтение данных из memory_pin_state и передача на io_pins
            for (int i = 0; i < PINS_CONT; i = i + 1) begin
                memory_pin_state[i / 8][i % 8] = io_pins[i];
            end
        end
    end

endmodule