
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/07/15, 13:19:55
//----------------------------------------------------
//Method: Form Method: [LSS_refStructureCoating]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/7/15 13:19:56)
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

FM_RefStructureCoatingInput
//End Form Method: [LSS_refStructureCoating]Input

