
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/09/13, 12:14:04
//----------------------------------------------------
//Method: Object Method: CloneTables.KeyValue_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	
End if 
C_LONGINT:C283($Column_l; $Row_l; $Loop_L)
LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
LISTBOX SELECT ROW:C912(ProcessListBox_l; $Row_l)
If (RemoteQueryType_atxt{$Loop_l}="like")
	If (Position:C15("%"; KeyValue_txt)>0)
	Else 
		KeyValue_txt:=KeyValue_txt+"%"
	End if 
End if 
RemoteKey_atxt{$Row_l}:=KeyValue_txt
RemoteCustomQuery_atxt{$Row_l}:=SQL_TEXT
//End Object Method: CloneTables.KeyValue_txt

