//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/05, 11:28:17
	// ----------------------------------------------------
	// Method: WKHR_RenumberItemList
	// Description
	// Renumber the List of Items 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($LastID; $i)
$LastID:=Num:C11(arrPtr_1->{1})
ARRAY TEXT:C222($arr_ReplacedIDs_S; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($arr_NewIDs_S; 0)  //Command Replaced was o_ARRAY string length was 3
C_TEXT:C284($vOldID_S)  // Command Replaced was o_C_STRING length was 3
For ($i; 2; Size of array:C274(arrPtr_1->))
	$vOldID_S:=arrPtr_1->{$i}
	arrPtr_1->{$i}:=String:C10($LastID+$i-1)
	If (($vOldID_S#arrPtr_1->{$i}) & ($vOldID_S#""))
		INSERT IN ARRAY:C227($arr_ReplacedIDs_S; 0)
		INSERT IN ARRAY:C227($arr_NewIDs_S; 0)
		$arr_replacedIDs_S{1}:=$vOldID_S
		$arr_NewIDs_S{1}:=arrPtr_1->{$i}
	End if 
	
End for 
If (Size of array:C274($arr_ReplacedIDs_S)>0)
	C_LONGINT:C283($vPosInCmts)
	For ($i; 1; Size of array:C274($arr_ReplacedIDs_S))
		$vPosInCmts:=Find in array:C230(Arr_WKHR_CommentsRef; Num:C11($arr_ReplacedIDs_S{$i}))
		If ($vPosInCmts>0)
			Arr_WKHR_CommentsRef{$vPosInCmts}:=Num:C11($arr_NewIDs_S{$i})
		End if 
		
	End for 
	
End if 
ARRAY TEXT:C222($arr_ReplacedIDs_S; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($arr_NewIDs_S; 0)  //Command Replaced was o_ARRAY string length was 3
