
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/15/12, 14:55:26
//----------------------------------------------------
//Method: Object Method: CloneActivityLogListBox.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001
	//Modified by: Charles Miller (3/15/12 14:55:29)
	
End if 
C_POINTER:C301($Table_ptr)
C_LONGINT:C283($TableNumber_l)

$TableNumber_l:=TableNumber_al{TableNames_atxt}
$Table_ptr:=Table:C252($TableNumber_l)

CREATE SET:C116($Table_ptr->; "MyLocalSet")


DIFFERENCE:C122("MyLocalSet"; "SelectedRecordsSet"; "SelectedRecordsSet")
CLEAR SET:C117("MyLocalSet")
USE SET:C118("SelectedRecordsSet")
SET WINDOW TITLE:C213("Clone Activity Log for "+String:C10(Records in selection:C76($Table_ptr->))+" "+TableNames_atxt{TableNames_atxt})

//End Object Method: CloneActivityLogListBox.Button

