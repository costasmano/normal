//Method: [Activity Log].Input.FileIDRes_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/11/22, 12:58:55
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
End if 
//
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		
		If ([FileIDRes Table:60]File Number:1>0)
			vTablNam:=Table name:C256([FileIDRes Table:60]File Number:1)
		End if 
End case 
//End [Activity Log].Input.FileIDRes_LB