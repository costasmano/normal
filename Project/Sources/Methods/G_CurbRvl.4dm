//%attributes = {"invisible":true}
//Format Curb Reveal value.
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 3//Curb reveal formatted
C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER//Curb reveal in mm
Case of 
	: ($1=-1)  //-1 = Hidden : H
		$0:="H"
	: ($1=-2)  //-2 = Not applicable : N
		$0:="N"
	Else 
		$0:=String:C10($1; "##0")
End case 