//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 12:50:12
//----------------------------------------------------
//Method: LB_ShowSelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 12:50:13)
	// Modified by: Costas Manousakis-(Designer)-(2/11/13 11:49:28)
	Mods_2013_02
	//  `Run only if records have been selected
End if 

If (Records in set:C195("SelectedRecordsSet")>0)
	USE SET:C118("SelectedRecordsSet")
	LB_SetWindowTitle
	LB_ClearHeaders
Else 
	ALERT:C41("No Records have been Selected!")
End if 

//End LB_ShowSelection