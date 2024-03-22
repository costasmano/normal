
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/01/11, 10:39:29
//----------------------------------------------------
//Method: Object Method: CloneTables.ProcessListBox_l
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		clone_MoveElements("<")
	: (Form event code:C388=On Clicked:K2:4)
		
	: (Form event code:C388=On Drop:K2:12)
		C_LONGINT:C283($Column_l; $Row_l)
		LISTBOX GET CELL POSITION:C971(LocalListBox_l; $Column_l; $Row_l)
		LISTBOX SELECT ROW:C912(LocalListBox_l; $Row_l)
		If (RemoteCount_al{$Row_l}>0)
			LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
			C_LONGINT:C283($InnerLoop_l)
			For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
				ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Row_l}
			End for 
			
			LISTBOX DELETE ROWS:C914(LocalListBox_l; $Row_l)
			LISTBOX SORT COLUMNS:C916(ProcessListBox_l; 3; >)
		End if 
End case 
//End Object Method: CloneTables.ProcessListBox_l

