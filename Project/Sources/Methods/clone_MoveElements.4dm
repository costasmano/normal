//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 13:56:21
//----------------------------------------------------
//Method: clone_MoveElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 

If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_TEXT:C284($Direction_txt; $1; $Variable_txt)
	$Direction_txt:=$1
	C_LONGINT:C283($FromPosition_l; $InnerLoop_l; $Loop_l; $Column_l; $Row_l; $TableNumber_l; $UniqueFldNumber_l)
	OBJECT SET VISIBLE:C603(*; "AllowForCustomWhere@"; False:C215)
	
	Case of 
		: ($Direction_txt=">")
			
			LISTBOX GET CELL POSITION:C971(LocalListBox_l; $Column_l; $Row_l)
			LISTBOX SELECT ROW:C912(LocalListBox_l; $Row_l)
			If (RemoteCount_al{$Row_l}>0)
				LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
				$TableNumber_l:=FromArray_ptr{4}->{$Row_l}
				
				clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
				If ($UniqueFldNumber_l>0)
					RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
				End if 
				For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
					ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Row_l}
					
				End for 
				
				LISTBOX DELETE ROWS:C914(LocalListBox_l; $Row_l)
				LISTBOX SORT COLUMNS:C916(ProcessListBox_l; 23; >)
			End if 
		: ($Direction_txt=">>")
			For ($Loop_l; Size of array:C274(FromArray_ptr{1}->); 1; -1)
				
				LISTBOX SELECT ROW:C912(LocalListBox_l; $Loop_l)
				If (RemoteCount_al{$Row_l}>0)
					LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
					$TableNumber_l:=FromArray_ptr{4}->{$Row_l}
					
					clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
					If ($UniqueFldNumber_l>0)
						RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
					End if 
					For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
						ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Loop_l}
					End for 
					
					LISTBOX DELETE ROWS:C914(LocalListBox_l; $Loop_l)
				End if 
			End for 
			
			LISTBOX SORT COLUMNS:C916(ProcessListBox_l; 3; >)
		: ($Direction_txt="<")
			LISTBOX GET CELL POSITION:C971(ProcessListBox_l; $Column_l; $Row_l)
			LISTBOX SELECT ROW:C912(ProcessListBox_l; $Row_l)
			LISTBOX INSERT ROWS:C913(LocalListBox_l; 1)
			For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
				FromArray_ptr{$InnerLoop_l}->{1}:=ToArray_ptr{$InnerLoop_l}->{$Row_l}
			End for 
			LISTBOX DELETE ROWS:C914(ProcessListBox_l; $Row_l)
			LISTBOX SORT COLUMNS:C916(LocalListBox_l; 3; >)
			
		: ($Direction_txt="<<")
			For ($Loop_l; Size of array:C274(ToArray_ptr{1}->); 1; -1)
				LISTBOX SELECT ROW:C912(ProcessListBox_l; $Loop_l)
				LISTBOX INSERT ROWS:C913(LocalListBox_l; 1)
				For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
					FromArray_ptr{$InnerLoop_l}->{1}:=ToArray_ptr{$InnerLoop_l}->{$Loop_l}
				End for 
				
				LISTBOX DELETE ROWS:C914(ProcessListBox_l; $Loop_l)
			End for 
			
			LISTBOX SORT COLUMNS:C916(LocalListBox_l; 3; >)
	End case 
	InDoubleClick_B:=False:C215
End if 


//End clone_MoveElements

