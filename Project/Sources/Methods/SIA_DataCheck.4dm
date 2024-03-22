//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/17/10, 13:17:31
	// ----------------------------------------------------
	// Method: SIA_DataCheck
	// Description
	//  ` Execute Data checks on NBI data; Return a text with errors
	// 
	// Parameters
	// $0 := $Error_txt
	// ----------------------------------------------------
	
	Mods_2010_12
	// Modified by: Costas Manousakis-(Designer)-(3/28/16 13:08:05)
	Mods_2016_03_bug
	//  `added and error line prefix
End if 
C_TEXT:C284($0; $Error_txt; $ErrPrefix_txt)
$Error_txt:=""
$ErrPrefix_txt:=[Bridge MHD NBIS:1]InspResp:173+Char:C90(9)+[Bridge MHD NBIS:1]BIN:3+Char:C90(9)+[Bridge MHD NBIS:1]Item5:59+Char:C90(9)
If (f_TrimStr([Bridge MHD NBIS:1]Item9:66; True:C214; True:C214)="")
	$Error_txt:=$Error_txt+$ErrPrefix_txt+"9"+Char:C90(9)+"DataCheck"+Char:C90(9)+"Item 9 cannot be blank."+<>sCR+<>sLF
End if 

If (f_BridgeOverWater)
	If (Position:C15(("-"+[Bridge MHD NBIS:1]Item113:151+"-"); "-0-1-2-3-4-5-6-7-8-9-T-U-D-")>0)
	Else 
		$Error_txt:=$Error_txt+$ErrPrefix_txt+"113"+Char:C90(9)+Char:C90(9)+"DataCheck"+Char:C90(9)+"Item 42 indicates Bridge Over Water ; Item 113 must be 0-9,T,U,D ."+<>sCR+<>sLF
	End if 
	
End if 
$0:=$Error_txt