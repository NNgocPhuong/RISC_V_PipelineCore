module PC_Adder (a,b,c);

    input [31:0]a,b;       // Hai đầu vào 32-bit (a và b).
    output [31:0]c;        // Đầu ra 32-bit (c).

    assign c = a + b;      // Cộng hai giá trị đầu vào và gán kết quả cho c.
    
endmodule