//ECE 5440
//Kaushik Mandiga 5095
//This is the Button Shaper Module
//It will output a single cycle pulse
//when a pushbutton is pressed.

module ButtonShaper(inButtonSignal, outPulse, clk, rst);

    input inButtonSignal;
    output reg outPulse;
    input clk, rst;

    parameter INIT = 0, PULSE = 1, WAIT = 2;

    reg [1:0] State, StateNext;

    always @ (State, inButtonSignal)
        begin
            case(State)
                INIT:
                    begin
                        outPulse <= 0;
                        if(inButtonSignal == 1)
                            begin
                                StateNext <= INIT;
                            end
                        else
                            begin
                                StateNext <= PULSE;
                            end
                    end
                PULSE:
                    begin
                        outPulse <= 1;
                        StateNext <= WAIT;
                    end
                WAIT:
                    begin
                        outPulse <= 0;
                        if(inButtonSignal == 0)
                            begin
                                StateNext <= WAIT;
                            end
                        else
                            begin
                                StateNext <= INIT;
                            end
                    end
		default:
			begin
				outPulse <= 0;
				StateNext <= INIT;
			end
            endcase
        end
    always @ (posedge clk)
        begin
            if(rst == 0)
                begin
                    State <= INIT;
                end
            else
                begin
                    State <= StateNext;
                end
        end
endmodule
