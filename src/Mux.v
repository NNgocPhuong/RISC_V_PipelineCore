module Mux (a,b,s,c);

    input [31:0]a,b;       // Hai đầu vào 32-bit (a và b).
    input s;               // Tín hiệu chọn (1-bit).
    output [31:0]c;        // Đầu ra 32-bit (c).

    assign c = (~s) ? a : b; // Nếu s = 0, c = a. Nếu s = 1, c = b.
    
endmodule

module Mux_3_by_1 (a,b,c,s,d);
    input [31:0] a,b,c;    // Ba đầu vào 32-bit (a, b, c).
    input [1:0] s;         // Tín hiệu chọn (2-bit).
    output [31:0] d;       // Đầu ra 32-bit (d).

    assign d = (s == 2'b00) ? a : 
               (s == 2'b01) ? b : 
               (s == 2'b10) ? c : 32'h00000000;
                           // Nếu s = 00, d = a.
                           // Nếu s = 01, d = b.
                           // Nếu s = 10, d = c.
                           // Nếu s = 11, d = 0.
endmodule