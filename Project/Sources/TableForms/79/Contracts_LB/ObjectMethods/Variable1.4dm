If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 11:56:45)
	Mods_2021_10
	//  `modified adding of record to scroll to the new record
	// Modified by: Costas Manousakis-(Designer)-(2023-06-16 13:03:47)
	Mods_2023_06_bug
	//  `Sort by number of contract no.
End if 

C_TEXT:C284($SelectionName_txt)
$SelectionName_txt:="$PREADD"  // local set
ARRAY LONGINT:C221($Recordnums_al; 0)
SELECTION TO ARRAY:C260(Current form table:C627->; $Recordnums_al)
ADD RECORD:C56(pFile->)
If (OK=1)
	C_LONGINT:C283($newRow_L)
	ARRAY LONGINT:C221($newrecords_aL; 0)
	SELECTION TO ARRAY:C260(Current form table:C627->; $newrecords_aL)
	APPEND TO ARRAY:C911($Recordnums_al; $newrecords_aL{1})
	CREATE SELECTION FROM ARRAY:C640(Current form table:C627->; $Recordnums_al)
	ORDER BY FORMULA:C300([Contracts:79]; Num:C11([Contracts:79]ContractNo:1); >)
	SELECTION TO ARRAY:C260(Current form table:C627->; $Recordnums_al)
	$newRow_L:=Find in array:C230($Recordnums_al; $newrecords_aL{1})
	LISTBOX SELECT ROW:C912(*; "Contract_LB"; $newRow_L)
	ADD TO SET:C119(Current form table:C627->; "UserSet")
	OBJECT SET SCROLL POSITION:C906(*; "Contract_LB"; $newRow_L)
	
End if 
UNLOAD RECORD:C212(Current form table:C627->)

WindowTitle
//End of script
