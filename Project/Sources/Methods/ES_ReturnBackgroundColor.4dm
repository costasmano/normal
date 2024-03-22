//%attributes = {"invisible":true}
//Method: ES_ReturnBackgroundColor
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/19, 15:55:41
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
End if 

C_LONGINT:C283($0)
If (([ElementsSafety:29]ElementNo:1=300) | ([ElementsSafety:29]ElementNo:1=313) | ([ElementsSafety:29]ElementNo:1=325))
	$0:=0x00CCCCCC  // gray
Else 
	$0:=0x00EEEEEE
End if 
//End ES_ReturnBackgroundColor