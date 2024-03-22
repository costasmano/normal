//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/30/13, 13:09:13
//----------------------------------------------------
//Method: Clone_UpdateRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_TEXT:C284($1)
C_LONGINT:C283($Position_L; $Loop_L)
C_POINTER:C301($Table_ptr; $Field_ptr; $Array_ptr)

$Position_L:=Find in array:C230(clone_TablesWithUniqueKey_atxt; $1)
If ($Position_L>0)
	$Table_ptr:=clone_Table_aPtr{$Position_L}
	$Field_ptr:=clone_UniqueKeys_aptr{$Position_L}
	$Array_ptr:=clone_Array_aptr{$Position_L}
	For ($Loop_L; 1; Size of array:C274($Array_ptr->))
		QUERY:C277($Table_ptr->; $Field_ptr->=$Array_ptr->{$Loop_L})
		If (Records in selection:C76($Table_ptr->)=0)
			CREATE RECORD:C68($Table_ptr->)
		End if 
		If (clone_LoadRecord($Table_ptr; 100))
			
			clone_UpdateLocalTable(Table:C252($Table_ptr); $Loop_L)
			
			SAVE RECORD:C53($Table_ptr->)
			UNLOAD RECORD:C212($Table_ptr->)
		End if 
	End for 
	
	If (Size of array:C274($Array_Ptr->)<SQL_Limit_L) | (Offset_l>=Count_l)
		Offset_l:=Count_l
	Else 
		Offset_l:=Offset_l+SQL_Limit_L
	End if 
End if 
//End Clone_UpdateRecords