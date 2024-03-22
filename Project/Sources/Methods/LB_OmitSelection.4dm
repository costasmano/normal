//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 12:51:31
//----------------------------------------------------
//Method: LB_OmitSelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 12:51:31)
	// Modified by: Costas Manousakis-(Designer)-(2/11/13 11:47:55)
	Mods_2013_02
	//  `Run only if records have been selected
End if 

If (Records in set:C195("SelectedRecordsSet")>0)
	C_POINTER:C301($Table_ptr)
	$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)
	CREATE SET:C116($Table_ptr->; "MyLocalSet")
	
	DIFFERENCE:C122("MyLocalSet"; "SelectedRecordsSet"; "SelectedRecordsSet")
	
	USE SET:C118("SelectedRecordsSet")
	LB_SetWindowTitle
	CLEAR SET:C117("MyLocalSet")
	//CLEAR SET("SelectedRecordsSet")
	LB_ClearHeaders
	
Else 
	ALERT:C41("No Records have been Selected to Omit!")
End if 

//End LB_OmitSelection