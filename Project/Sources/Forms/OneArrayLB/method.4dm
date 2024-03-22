
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 06/13/13, 16:06:52
//----------------------------------------------------
//Method: Form Method: ImportUsers
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_06  //r001 ` Add update progress bar and change code to deal with adjusted user names
	//Modified by: Charles Miller (6/13/13 16:27:04)
End if 
If (Form event code:C388=On Load:K2:1)
	OBJECT SET TITLE:C194(*; "Header1"; 1_TXT)
End if 
//End Form Method: ImportUsers

