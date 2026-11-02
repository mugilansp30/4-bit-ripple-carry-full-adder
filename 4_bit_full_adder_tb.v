
`timescale 1ns/1ps

module tb_four_bit_full_adder;

    reg [3:0] A, B;
    reg CIN;

    wire [3:0] SUM;
    wire COUT;

    reg [4:0] expected;

    integer i, j, k;
    integer errors;

    // Instantiate the 4-bit Full Adder
    four_bit_full_adder DUT (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    initial begin

        errors = 0;

        $display("-------------------------------------");
        $display("    4-BIT FULL ADDER TESTBENCH");
        $display("-------------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin

                    A = i;
                    B = j;
                    CIN = k;

                    expected = {1'b0, A} + {1'b0, B} + CIN;

                    #10;

                    if ({COUT, SUM} !== expected) begin

                        $display("FAILED: A=%b B=%b CIN=%b SUM=%b COUT=%b EXPECTED=%b",
                                 A, B, CIN, SUM, COUT, expected);

                        errors = errors + 1;

                    end

                end
            end
        end

        $display("-------------------------------------");

        if (errors == 0)
            $display("ALL 512 TEST CASES PASSED!");
        else
            $display("TEST FAILED: %0d ERRORS", errors);

        $display("-------------------------------------");

        $finish;

    end

endmodule
