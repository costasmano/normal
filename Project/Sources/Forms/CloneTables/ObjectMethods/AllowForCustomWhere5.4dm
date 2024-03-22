
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/08/13, 10:51:39
//----------------------------------------------------
//Method: Object Method: CloneTables.QueryTypes_as
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (SQL_TEXT="")
	ALERT:C41("You must select where field part first")
Else 
	C_LONGINT:C283($Column_l; $Row_l; $Loop_L)
	LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
	LISTBOX SELECT ROW:C912(ProcessListBox_l; $Row_l)
	RemoteQueryType_atxt{$Row_l}:=QueryTypes_as{QueryTypes_as}
	SQL_TEXT:=SQL_TEXT+QueryTypes_as{QueryTypes_as}+" :KeyValue_txt; "
End if 
//End Object Method: CloneTables.QueryTypes_as

