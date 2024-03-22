
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/05/12, 14:39:21
//----------------------------------------------------
//Method: Form Method: [LB_QueryTable]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/5/12 14:39:22)
	// Modified by: Costas Manousakis-(Designer)-(3/6/12 14:17:24)
	Mods_2012_03
	//  `do not save record on load for a new rec - just make sure there is a unique key
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
	
	If (Is new record:C668([LB_QueryTable:147]))
		Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
	End if 
	
End if 

//End Form Method: [LB_QueryTable]Input