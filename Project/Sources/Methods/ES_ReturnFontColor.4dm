//%attributes = {"invisible":true}
//Method: ES_ReturnFontColor
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/19, 13:33:02
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
End if 
//
C_LONGINT:C283($0)
If (([ElementsSafety:29]ElementNo:1=300) | ([ElementsSafety:29]ElementNo:1=313) | ([ElementsSafety:29]ElementNo:1=325))
	$0:=0x00FF  //Blue
Else 
	$0:=0x00FF  //8572373  //light blue
End if 
//End ES_ReturnFontColor 