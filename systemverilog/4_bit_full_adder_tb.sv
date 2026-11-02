
`timescale 1ns/1ps

module tb_four_bit_full_adder;

    logic [3:0] A, B;
    logic CIN;

    logic [3:0] SUM;
    logic COUT;

    logic [4:0] expected;

    int i, j, k;
    int errors;

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
        $display("  4-BIT FULL ADDER TESTBENCH");
        $display("-------------------------------------");

        for (i = 0; i < 16; i++) begin

            for (j = 0; j < 16; j++) begin

                for (k = 0; k < 2; k++) begin

                    A = i;
                    B = j;
                    CIN = k;

                    expected = {1'b0, A} + {1'b0, B} + CIN;

                    #10;

                    if ({COUT, SUM} !== expected) begin

                        $display(
                            "FAILED: A=%b B=%b CIN=%b SUM=%b COUT=%b EXPECTED=%b",
                            A, B, CIN, SUM, COUT, expected
                        );

                        errors++;

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
