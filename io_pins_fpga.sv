module io_pins_fpga (
    inout  [127:0] io_pins,          // 132 двунаправленных пина
    input  [15:0]  write_read,  // Сигналы разрешения записи в регистры
    
    input  [7:0]   reg_data_in [15:0], // Входные данные для записи в регистры
    output [7:0]   reg_data_out [15:0] // Выходные данные для чтения из регистров
);

    // 17 восьмиразрядных регистров
    reg [7:0] registers [15:0];

    

    // Управление направлением передачи данных
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : reg_loop
            // Чтение из регистров
            assign reg_data_out[i] = registers[i];

            // Запись в регистры
            always @(posedge write_read[i]) begin
                registers[i] <= reg_data_in[i];
            end

            // Управление пинами
            assign io_pins[8*i +: 8] = !write_read[i] ? registers[i] : 8'bz;
        end
        
    endgenerate

endmodule
