module tb();

    reg clk=0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end

    initial begin
    rst <= 1'b0;  // Đặt reset ban đầu.
    #200;
    rst <= 1'b1;  // Kích hoạt hệ thống sau 200 đơn vị thời gian.
    #1000;
    $finish;      // Kết thúc mô phỏng sau 1000 đơn vị thời gian.
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    Pipeline_top dut (.clk(clk), .rst(rst));
endmodule