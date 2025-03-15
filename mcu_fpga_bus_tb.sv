module mcu_fpga_bus_tb;

    logic CLK50 = 0;

    initial begin
        forever #5 CLK50 = ~CLK50;
    end

    logic write_enable = 0;
    logic [4:0] address = 4'h0;

    logic mcu_mstr = 0;
    logic [7:0] data = 0;
    logic fpga_ack;

    logic [7:0] input_pins_state [0:15];
    logic [7:0] output_pins_state [0:15]; 

    mcu_fpga_bus mf_bus (
        CLK50,
        write_enable,
        address,
        mcu_mstr,
        data,
        fpga_ack,
        input_pins_state,
        output_pins_state
    );

    initial begin
        #5;
        address = 4'h1;
        data = 8'hAA;
        #5;
        mcu_mstr = 1;
        write_enable = 1;
        #5;
        #5;
        #5;
        write_enable = 0;
        mcu_mstr = 0;
        #5;
        $finish;


    end



    initial begin
        $dumpfile("mcu_fpga_bus_tb_waves.vcd"); // Имя VCD-файла
        $dumpvars(0, mcu_fpga_bus_tb); // Запись всех сигналов в тестбенче
    end;

    
endmodule