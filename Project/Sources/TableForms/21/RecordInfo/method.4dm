//Method: [Dialogs];"RecordInfo"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 11, 2022, 12:45:20
	Mods_2022_07
	// ----------------------------------------------------
	//named label object for modified by to modifiedLabel.
	//in form method change the title according to property modifiedLabel of Form object
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		If (OB Is defined:C1231(Form:C1466; "modifiedLabel"))
			OBJECT SET TITLE:C194(*; "modifiedLabel"; Form:C1466.modifiedLabel)
		End if 
		
End case 

//End [Dialogs];"RecordInfo" 