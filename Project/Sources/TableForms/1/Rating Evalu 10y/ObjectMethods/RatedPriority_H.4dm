//Method: [Bridge MHD NBIS].Rating Evalu 10y.Invisible Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/18/17, 12:31:53
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($Title_txt)
	$Title_txt:=OBJECT Get title:C1068(*; "HighPriority")
	If ($Title_txt="") | ($Title_txt=" ")
		OBJECT SET TITLE:C194(*; "HighPriority"; "X")
		OBJECT SET TITLE:C194(*; "MediumPriority"; "")
		OBJECT SET TITLE:C194(*; "LowPriority"; "")
		
	Else 
		
		OBJECT SET TITLE:C194(*; "HighPriority"; "")
	End if 
End if 
//End [Bridge MHD NBIS].Rating Evalu 10y.Invisible Button