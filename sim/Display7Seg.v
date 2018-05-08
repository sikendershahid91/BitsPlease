module Display7Seg(
	input [31:0] userID_score,
	output[6:0]  display0,
	output[6:0]  display1,
	output[6:0]  display2,
	output[6:0]  display3,
	output[6:0]  display4,
	output[6:0]  display5,
	output[6:0]  display6,
	output[6:0]  display7 
	); 

	Dec7Seg _display0(userID_score[31:28],display7),  // 4bits in 
			_display1(userID_score[27:24],display6),
			_display2(userID_score[23:20],display5),
			_display3(userID_score[19:16],display4),
			_display4(userID_score[15:12],display3),
			_display5(userID_score[11:8],display2),
			_display6(userID_score[7:4],display1),
			_display7(userID_score[3:0],display0);

endmodule 