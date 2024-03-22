//%attributes = {"invisible":true}
//Method: ES_ReturnStyle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/19, 14:55:59
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//
//
C_LONGINT:C283($0)
If (([ElementsSafety:29]ElementNo:1=300) | ([ElementsSafety:29]ElementNo:1=313) | ([ElementsSafety:29]ElementNo:1=325))
	
	$0:=Bold:K14:2
Else 
	
	$0:=Plain:K14:1
End if 
//End ES_ReturnStyle