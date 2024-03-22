
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/08/13, 16:45:03
//----------------------------------------------------
//Method: Object Method: CloneTables.RemoteQueryType_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	
End if 
C_LONGINT:C283($Column_l; $Row_l; $Loop_L)

LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
QueryPopUp_txt:="=;>;<;>=;<=;NOT =;Begins with;Ends with;Contains"
$Loop_L:=Pop up menu:C542(QueryPopUp_txt)
RemoteQueryType_atxt{$Row_l}:=QueryTypes_as{$Loop_L}
//End Object Method: CloneTables.RemoteQueryType_atxt

