
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 16:09:58
//----------------------------------------------------
//Method: Object Method: CloneTables.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Compiler_clone
End if 
ARRAY TEXT:C222($Files_atxt; 0)
C_LONGINT:C283($UniqueFldNumber_l; $InnerLoop_l; $Offset_L; $Row_L; $TableNumber_l)

C_TEXT:C284($Variable_txt)
C_TEXT:C284($FileName_txt)
$FileName_txt:=Select document:C905(""; ""; "Select Document containing tables to be cloned"; Multiple files:K24:7; $Files_atxt)
ARRAY LONGINT:C221($ProcessTableNumber_al; 0)
ARRAY TEXT:C222($ProcessTableNames_atxt; 0)
ARRAY TEXT:C222($RemoteKeyName_atxt; 0)
ARRAY TEXT:C222($RemoteQueryType_atxt; 0)
ARRAY TEXT:C222($RemoteKey_atxt; 0)
ARRAY TEXT:C222($RemoteCustomQuery_atxt; 0)

ARRAY LONGINT:C221($RemoteType_al; 0)

$Offset_L:=0
C_BLOB:C604($TablesToBeCloned_blb)
SET BLOB SIZE:C606($TablesToBeCloned_blb; $0)
clone_MoveElements("<<")
DOCUMENT TO BLOB:C525($Files_atxt{1}; $TablesToBeCloned_blb)

BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $ProcessTableNumber_al; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $ProcessTableNames_atxt; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $RemoteKeyName_atxt; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $RemoteQueryType_atxt; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $RemoteKey_atxt; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $RemoteCustomQuery_atxt; $Offset_L)
BLOB TO VARIABLE:C533($TablesToBeCloned_blb; $RemoteType_al; $Offset_L)

For ($Offset_L; 1; Size of array:C274($ProcessTableNumber_al))
	LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
	$Row_L:=Find in array:C230(TableNumber_al; $ProcessTableNumber_al{$Offset_L})
	If ($Row_L>0)
		
		$TableNumber_l:=FromArray_ptr{4}->{$Row_l}
		
		clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
		If ($UniqueFldNumber_l>0)
			RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
		End if 
		For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
			ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Row_L}
		End for 
		
		
		ProcessLocalCount_al{$Offset_L}:=LocalCount_al{$Row_L}
		ProcessRemoteCount_al{$Offset_L}:=RemoteCount_al{$Row_L}
		LISTBOX DELETE ROWS:C914(LocalListBox_l; $Row_l)
	End if 
End for 

REDRAW:C174(ProcessListBox_l)
//End Object Method: CloneTables.Button1

