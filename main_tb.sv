
module main_tb;

    logic CLK50 = 0;

    initial begin
        forever #20 CLK50 = ~CLK50; //
    end

    logic write_enable = 0;
    logic [4:0] address = 4'h0;

    logic mcu_mstr = 0;
    logic [7:0] data = 0;
    logic fpga_ack;

    logic [7:0] input_pins_state [0:16];
    logic [7:0] output_pins_state [0:16]; 

    logic [131:0] io_pins;
    

    main m_module(
        data,
        address,
        mcu_mstr,
        write_enable,
        fpga_ready,
        fpga_ack,

        io_pins,
        CLK50    
    );

    initial begin
        #20;
        address = 4'h1;
        data = 8'hAA;
        #20;
        mcu_mstr = 1;
        write_enable = 1;
        #20;
        #20;
        #20;
        write_enable = 0;
        mcu_mstr = 0;
        #20;
        #100;
        $finish;
    end


    initial begin
        $dumpfile("waves.vcd"); // Имя VCD-файла
        $dumpvars(0, main_tb); // Запись всех сигналов в тестбенче
    end;
    
endmodule