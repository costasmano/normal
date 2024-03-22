
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 15:42:46
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection]Inspection_Template
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 16:05:13)
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
//End Form Method: [LSS_Inspection]Inspection_Template

