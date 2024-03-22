
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/08/13, 16:44:54
//----------------------------------------------------
//Method: Object Method: CloneTables.RemoteKeyName_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	
End if 
C_LONGINT:C283($Column_l; $Row_l; $Loop_L)

LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
clone_BuildFieldDropDown($Row_l)

$Loop_L:=Pop up menu:C542(ButtonpopupText)
If (FieldNames_atxt{$Loop_L}#"----------")
	RemoteKeyName_atxt{$Row_l}:=FieldNames_atxt{$Loop_L}
	SQL_TEXT:=RemoteCustomQuery_atxt{$Row_l}
	OBJECT SET VISIBLE:C603(*; "AllowForCustomWhere@"; True:C214)
	RemoteType_al{$Row_l}:=FieldTypes_al{$Loop_L}
	FieldNames_atxt:=0
	QueryTypes_as:=0
	
Else 
	ALERT:C41("You must select a field from list")
End if 
//End Object Method: CloneTables.RemoteKeyName_atxt

