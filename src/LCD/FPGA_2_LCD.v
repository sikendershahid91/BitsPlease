`timescale 1ns / 1ps

module FPGA_2_LCD(
	CLK, LCD_RS, LCD_RW, LCD_E, LCD_DB, RST, LCD_ON, LCD_CHAR_ARRAY
);
input CLK;			
input RST;

input [3:0] LCD_CHAR_ARRAY;         

output reg LCD_RS, LCD_RW, LCD_E, LCD_ON;
output reg [7:0] LCD_DB = 0;

reg clk_400hz_enable; 					
reg [7:0] next_char; 					
reg [19:0] clk_count_400hz;         
reg [4:0] char_count;               

wire [7:0] string1 [31:0];wire [7:0] string2 [31:0];wire [7:0] string3 [31:0];
wire [7:0] string4 [31:0];wire [7:0] string5 [31:0];wire [7:0] string6 [31:0];
wire [7:0] string7 [31:0];wire [7:0] string [31:0];
//-----------------------Hex Characters Used----------------------
reg [7:0] W = 8'h57;reg [7:0] E = 8'h45;reg [7:0] L = 8'h4C;reg [7:0] C = 8'h43;
reg [7:0] O = 8'h4F;reg [7:0] M = 8'h4D;
reg [7:0] G = 8'h47;reg [7:0] I = 8'h49;reg [7:0] N = 8'h4E;reg [7:0] R = 8'h52;
reg [7:0] Q = 8'h51;reg [7:0] U = 8'h55;reg [7:0] T = 8'h54;
reg [7:0] A = 8'h41;reg [7:0] V = 8'h56;reg [7:0] D = 8'h44;reg [7:0] P = 8'h50;
reg [7:0] S = 8'h53;reg [7:0] Y = 8'h59;reg [7:0] H = 8'h48;
reg [7:0] B = 8'h42;reg [7:0] SP = 8'h20;
reg [7:0] EX = 8'h21;reg [7:0] QU = 8'h3F;reg [7:0] _3 = 8'h33;reg [7:0]arrow = 8'h7E;
//-----------------------Assign Char to Strings-----------------
// string 1 "WELCOME!        LOGIN OR QUIT?"
assign string1[0] = W;assign string1[8] = SP;assign string1[16] = L;assign string1[24] = SP;
assign string1[1] = E;assign string1[9] = SP;assign string1[17] = O;assign string1[25] = Q;
assign string1[2] = L;assign string1[10] = SP;assign string1[18] = G;assign string1[26] = U;
assign string1[3] = C;assign string1[11] = SP;assign string1[19] = I;assign string1[27] = I;
assign string1[4] = O;assign string1[12] = SP;assign string1[20] = N;assign string1[28] = T;
assign string1[5] = M;assign string1[13] = SP;assign string1[21] = SP;assign string1[29] = QU;
assign string1[6] = E;assign string1[14] = SP;assign string1[22] = O;assign string1[30] = SP;
assign string1[7] = EX;assign string1[15] = SP;assign string1[23] = R;assign string1[31] = SP;
// string 2
assign string2[0] = E;assign string2[8] = V;assign string2[16] = A;assign string2[24] = W;
assign string2[1] = N;assign string2[9] = A;assign string2[17] = N;assign string2[25] = O;
assign string2[2] = T;assign string2[10] = L;assign string2[18] = D;assign string2[26] = R;
assign string2[3] = E;assign string2[11] = I;assign string2[19] = SP;assign string2[27] = D;
assign string2[4] = R;assign string2[12] = D;assign string2[20] = P;assign string2[28] = SP;
assign string2[5] = SP;assign string2[13] = SP;assign string2[21] = A;assign string2[29] = SP;
assign string2[6] = A;assign string2[14] = I;assign string2[22] = S;assign string2[30] = SP;
assign string2[7] = SP;assign string2[15] = D;assign string2[23] = S;assign string2[31] = SP;
// string 3
assign string3[0] = W;assign string3[8] = SP;assign string3[16] = E;assign string3[24] = P;
assign string3[1] = E;assign string3[9] = SP;assign string3[17] = N;assign string3[25] = A;
assign string3[2] = L;assign string3[10] = SP;assign string3[18] = T;assign string3[26] = S;
assign string3[3] = C;assign string3[11] = SP;assign string3[19] = E;assign string3[27] = S;
assign string3[4] = O;assign string3[12] = SP;assign string3[20] = R;assign string3[28] = W;
assign string3[5] = M;assign string3[13] = SP;assign string3[21] = SP;assign string3[29] = O;
assign string3[6] = E;assign string3[14] = SP;assign string3[22] = A;assign string3[30] = R;
assign string3[7] = EX;assign string3[15] = SP;assign string3[23] = SP;assign string3[31] = D;
// string 4
assign string4[0] = P;assign string4[8] = E;assign string4[16] = O;assign string4[24] = C;
assign string4[1] = L;assign string4[9] = QU;assign string4[17] = R;assign string4[25] = O;
assign string4[2] = A;assign string4[10] = SP;assign string4[18] = SP;assign string4[26] = R;
assign string4[3] = Y;assign string4[11] = Q;assign string4[19] = S;assign string4[27] = E;
assign string4[4] = SP;assign string4[12] = U;assign string4[20] = E;assign string4[28] = S;
assign string4[5] = G;assign string4[13] = I;assign string4[21] = E;assign string4[29] = QU;
assign string4[6] = A;assign string4[14] = T;assign string4[22] = SP;assign string4[30] = SP;
assign string4[7] = M;assign string4[15] = QU;assign string4[23] = S;assign string4[31] = SP;
// string 5
assign string5[0] = T;assign string5[8] = E;assign string5[16] = H;assign string5[24] = R;
assign string5[1] = R;assign string5[9] = T;assign string5[17] = I;assign string5[25] = E;
assign string5[2] = Y;assign string5[10] = SP;assign string5[18] = G;assign string5[26] = EX;
assign string5[3] = SP;assign string5[11] = T;assign string5[19] = H;assign string5[27] = SP;
assign string5[4] = T;assign string5[12] = H;assign string5[20] = SP;assign string5[28] = SP;
assign string5[5] = O;assign string5[13] = E;assign string5[21] = S;assign string5[29] = SP;
assign string5[6] = SP;assign string5[14] = SP;assign string5[22] = C;assign string5[30] = SP;
assign string5[7] = G;assign string5[15] = SP;assign string5[23] = O;assign string5[31] = SP;
// string 6
assign string6[0] = T;assign string6[8] = E;assign string6[16] = T;assign string6[24] = O;
assign string6[1] = H;assign string6[9] = SP;assign string6[17] = O;assign string6[25] = R;
assign string6[2] = E;assign string6[10] = T;assign string6[18] = P;assign string6[26] = E;
assign string6[3] = S;assign string6[11] = H;assign string6[19] = SP;assign string6[27] = S;
assign string6[4] = E;assign string6[12] = E;assign string6[20] = _3;assign string6[28] = EX;
assign string6[5] = SP;assign string6[13] = SP;assign string6[21] = SP;assign string6[29] = SP;
assign string6[6] = A;assign string6[14] = SP;assign string6[22] = S;assign string6[30] = SP;
assign string6[7] = R;assign string6[15] = SP;assign string6[23] = C;assign string6[31] = SP;
//string 7 "goodbye"
assign string7[0] = SP;assign string7[8] = SP;assign string7[16] = G;assign string7[24] = B;
assign string7[1] = G;assign string7[9] = B;assign string7[17] = SP;assign string7[25] = SP;
assign string7[2] = SP;assign string7[10] = SP;assign string7[18] = O;assign string7[26] = Y;
assign string7[3] = O;assign string7[11] = Y;assign string7[19] = SP;assign string7[27] = SP;
assign string7[4] = SP;assign string7[12] = SP;assign string7[20] = O;assign string7[28] = E;
assign string7[5] = O;assign string7[13] = E;assign string7[21] = SP;assign string7[29] = SP;
assign string7[6] = SP;assign string7[14] = SP;assign string7[22] = D;assign string7[30] = EX;
assign string7[7] = D;assign string7[15] = EX;assign string7[23] = SP;assign string7[31] = SP;
// string
assign string[0] = SP;assign string[8] = A;assign string[16] = SP;assign string[24] = P;
assign string[1] = SP;assign string[9] = M;assign string[17] = SP;assign string[25] = L;
assign string[2] = SP;assign string[10] = SP;assign string[18] = arrow;assign string[26] = E;
assign string[3] = SP;assign string[11] = SP;assign string[19] = B;assign string[27] = A;
assign string[4] = SP;assign string[12] = SP;assign string[20] = I;assign string[28] = S;
assign string[5] = SP;assign string[13] = SP;assign string[21] = T;assign string[29] = E;
assign string[6] = T;assign string[14] = SP;assign string[22] = S;assign string[30] = SP;
assign string[7] = E;assign string[15] = SP;assign string[23] = SP;assign string[31] = SP;

/*----------------------SOME NOTES-------------------
when RS and R/W change STATE...wait for at least 40ns ( ~1clock cycle )
after that period of time bring E high and invert E every 250ns (can be larger) ( ~6 clock cycles)
while E is HI, set DATA
when E goes LOW, maintain DATA for atleast 10ns

CLOCK=24MHz ==> 41.667ns
-------------------------END OF NOTES-------------------*/

//===============================================================================================
//------------------------------___State Interface Messages_-------------------------------------
//===============================================================================================
parameter WELCOME = 4'b0000, IDEN = 4'b0001, PWRD = 4'b0010, OPTIONS = 4'b0011, GAME = 4'b0100, SCORES = 4'b0101, BYE = 4'b0110;
parameter INIT1 = 0, INIT2 = 1, INIT3 = 2, FCNSET = 3, DISPOFF = 4, DISPON = 5, 
	DISPCLR = 6, MODESET = 7, DROP_LCD_E = 8, HOLD = 9, LINE2 = 10, PRINT_STRING = 11, RETURN = 12;

//--=====================================================================-- 
//--======================= 400HZ CLOCK SIGNAL ============================--  
//--=====================================================================-- 
always @(posedge CLK) begin
	if (RST == 0) begin
		clk_count_400hz <= 20'h00000;              //x"00000";
        clk_400hz_enable <= 1'b0;
	end
    else begin
        if (clk_count_400hz <= 20'h0F424) begin    // x"0F424"        
            clk_count_400hz <= clk_count_400hz + 1;                                   
            clk_400hz_enable <= 1'b0; 
		end            
        else begin
            clk_count_400hz <= 20'h00000;          //x"00000";
            clk_400hz_enable <= 1'b1;
        end 
    end 
end
//--==================================================================--   

//------------------------------------ STATE MACHINE FOR LCD SCREEN MESSAGE SELECT -----------------------------
//---------------------------------------------------------------------------------------------------------------
always @(LCD_CHAR_ARRAY) begin 
//-- get next character in display string based on the LCD_CHAR_ARRAY (switches or Multiplexer)
     case (LCD_CHAR_ARRAY)
//          -- Welcome message
		WELCOME: begin 
			next_char <= string1[char_count];
		end
		// ENTER A VALID ID AND PASSWORD
		IDEN: begin 
            next_char <= string2[char_count];
		end
		// ENTER A VALID PASSWORD *not being used by ProcessControl
		PWRD: begin 
            next_char <= string3[char_count];
		end
		// PLAY? QUIT? SCORES?
		OPTIONS: begin 
            next_char <= string4[char_count];
		end
		// GAME IN PROGRESS
		GAME: begin 
			next_char <= string5[char_count];
		end
		// (DISPLAY TOP 3)
		SCORES: begin 
            next_char <= string6[char_count];
		end
		// goodbye message on "logout"
		BYE: begin
			next_char <= string7[char_count];
		end
		// TEAM NAME
		default: begin
			next_char <= string[char_count];
		end
	endcase 
end 

//##########################################################################################
//-----------------------------Create the STATE MACHINE------------------------------------
//##########################################################################################
reg [3:0] STATE = 0, NXT_CMD = 0;

always @(posedge CLK) begin
	if (RST == 0) begin
        LCD_DB <= 8'h38;//x"38"; -- RESET
        LCD_E <= 1'b1;
        LCD_RS <= 1'b0;
        LCD_RW <= 1'b0;
			STATE <= INIT1;
			NXT_CMD <= INIT2;		
	end // end if part RST == 0
	else begin
		if (clk_400hz_enable == 1'b1) begin
		case(STATE)
//--======================= INITIALIZATION START ============================--
		    INIT1: begin//reset1 =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h38;//x"38"; -- EXTERNAL RESET
				char_count <= 5'b00000;
				STATE <= DROP_LCD_E;
				NXT_CMD <= INIT2;
			end
		    INIT2: begin//reset2 =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h38;//x"38"; -- EXTERNAL RESET
				STATE <= DROP_LCD_E;
				NXT_CMD <= INIT3;
			end
			INIT3: begin//reset3 =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h38;//x"38"; -- EXTERNAL RESET
				STATE <= DROP_LCD_E;
				NXT_CMD <= FCNSET;
			end
//         -- Function Set
//         --==============--
		    FCNSET: begin//func_set =>                
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h38;//x"38";  -- Set Function to 8-bit transfer, 2 line display and a 5x8 Font size
				STATE <= DROP_LCD_E;
				NXT_CMD <= DISPOFF;
			end
//         -- Turn off Display
//         --==============-- 
		    DISPOFF: begin//display_off =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h08;//x"08"; -- Turns OFF the Display, Cursor OFF and Blinking Cursor Position OFF.......(0F = Display ON and Cursor ON, Blinking cursor position ON)
				STATE <= DROP_LCD_E;
				NXT_CMD <= DISPCLR;
			end
//         -- Clear Display 
//         --==============--
		    DISPCLR: begin//display_clear =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h01;//x"01"; -- Clears the Display    
				STATE <= DROP_LCD_E;
				NXT_CMD <= DISPON;
			end
//         -- Turn on Display and Turn off cursor
//         --===================================--
		    DISPON: begin//display_on =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h0C;//x"0C"; -- Turns on the Display (0E = Display ON, Cursor ON and Blinking cursor OFF) 
				STATE <= DROP_LCD_E;
				NXT_CMD <= MODESET;
			end
//         -- Set write mode to auto increment address and move cursor to the right
//         --====================================================================--
		    MODESET: begin//mode_set =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h06;//x"06"; -- Auto increment address and move cursor to the right
				STATE <= DROP_LCD_E;
				NXT_CMD <= PRINT_STRING; 
			end
			PRINT_STRING: begin //when print_string =>          
            	STATE <= DROP_LCD_E;
                LCD_E <= 1'b1;
                LCD_RS <= 1'b1;
                LCD_RW <= 1'b0;
					
					LCD_DB <= next_char; // prints character of string sequence

                STATE <= DROP_LCD_E; 
                          
               //-- Loop to send out 32 characters to LCD Display (16 by 2 lines)
               if ((char_count < 8'b00011111) && (next_char != 8'hFE)) begin
                 	char_count <= char_count + 1'b1;  
					end
               else begin
                	char_count <= 5'b00000;
               end
               //-- Jump to second lineQU
               if (char_count == 4'b1111) begin 
                	NXT_CMD <= LINE2;
					end
               //-- Return to first lineQU
               else if ((char_count == 8'b00011111) || (next_char == 8'hFE)) begin
                	NXT_CMD <= RETURN;
					end	 
               else begin
                    NXT_CMD <= PRINT_STRING; 
               end 
			end	
//			-- Set write address to line 2 character 1
//		   --======================================--
		    LINE2: begin// line2 =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'hC0; //x"c0";
				STATE <= DROP_LCD_E;
				NXT_CMD <= PRINT_STRING;  
			end
//		   -- Return write address to first character position on line 1
//		   --=========================================================--
		    RETURN: begin // return_home =>
				LCD_E <= 1'b1;
				LCD_RS <= 1'b0;
				LCD_RW <= 1'b0;
				LCD_DB <= 8'h80; //x"80";
				STATE <= DROP_LCD_E;
				NXT_CMD <= PRINT_STRING; 
			end
//		 -- lcd_e will match clk_CUSTOM_hz_enable line when instructed to go LOW, however, if the clk_CUSTOM_hz_enable source clock must be a lower count value or it will reset LOW anyhow.
//       -- The next states occur at the end of each command or data transfer to the LCD
//       -- Drop LCD E line - falling edge loads inst/data to LCD controller
//       --============================================================================--
			DROP_LCD_E: begin//drop_lcd_e =>
				LCD_E <= 1'b0;
				LCD_ON <= 1'b1;
				STATE <= HOLD;
			end
//       -- Hold LCD inst/data valid after falling edge of E line
//       --====================================================--
			HOLD: begin//hold =>
				LCD_ON <= 1'b1;
				STATE <= NXT_CMD;
			end
			default: begin
				STATE <= INIT1;
			end
		endcase
		end // end if part
	end // end else part
end // end always block

endmodule
