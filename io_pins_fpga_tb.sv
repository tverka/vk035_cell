module io_pins_fpga_tb;

    logic CLK50;

    logic [131:0] io_pins;
    logic write_enable;
    
    logic [7:0] memory_pin_state [0:16];

    initial begin
        CLK50 = 0;
        io_pins = 0;

        
        
        forever #10 CLK50 = ~CLK50;
    end

    initial begin
        // for (int i = 0; i < 131; i = i + 1) begin
        //     io_pins[i] = io_pins[i] + 1;
        //     #5;
        // end

        // #100;
        // $finish;
                // Инициализация
        write_enable = 0;
        io_pins = 132'b0;

        // Запись данных
        #20;
        write_enable = 1;
        io_pins = 132'h123456789ABCDEF; // Пример данных
        #20;
        write_enable = 0;

        // Чтение данных
        #20;
        $display("Memory state: %h", memory_pin_state);

        // Завершение симуляции
        #100;
        $finish;

    end

    io_pins_fpga test1(
        CLK50,
        write_enable,
        io_pins,
        memory_pin_state
    );

    initial begin
        $dumpfile("waves.vcd"); // Имя VCD-файла
        $dumpvars(0, io_pins_fpga_tb); // Запись всех сигналов в тестбенче
    end;
    


endmodule