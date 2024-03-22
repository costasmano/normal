
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/08/13, 10:39:15
//----------------------------------------------------
//Method: Object Method: CloneTables.FieldNames_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

If (FieldNames_atxt>0)
	If (FieldNames_atxt{FieldNames_atxt}#"----------")
		C_LONGINT:C283($Column_l; $Row_l; $Loop_L)
		LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
		LISTBOX SELECT ROW:C912(ProcessListBox_l; $Row_l)
		RemoteKeyName_atxt{$Row_l}:=FieldNames_atxt{FieldNames_atxt}
		SQL_TEXT:="WHERE "+"["+Table name:C256(ProcessTableNumber_al{$Row_l})+"].["+FieldNames_atxt{FieldNames_atxt}+"] "
	Else 
		ALERT:C41("You must select a field from the list")
	End if 
End if 
//End Object Method: CloneTables.FieldNames_atxt

