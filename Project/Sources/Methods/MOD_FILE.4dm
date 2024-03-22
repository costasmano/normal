//%attributes = {"invisible":true}
//GP MOD_FILE($ptr_file; $ptr_field; $sort)
//© October 1995, Thomas D. Nee, All Rights Reserved.
//$1: $ptr_file: Pointer to file.
//$2: $ptr_field: Optional: Pointer to field for sorting
//$3: $sort: Optional: String: ">" or "<"

C_POINTER:C301($ptr_file; $ptr_field)
C_TEXT:C284($sort)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($noPar)

$ptr_file:=$1

//TRACE

SET MENU BAR:C67(2)
ALL RECORDS:C47($ptr_file->)
WINDOW_TITLE($ptr_file)

$noPar:=Count parameters:C259
If ($noPar>=2)
	$ptr_field:=$2  //A sort field was specified; use it.
	$sort:=">"  //The default sort order is ascending.
	If ($noPar=3)
		$sort:=$3  //A sort order was specified; use it.
	End if 
	If ($sort="<")
		ORDER BY:C49($ptr_file->; $ptr_field->; <)
	Else 
		ORDER BY:C49($ptr_file->; $ptr_field->; >)
	End if 
End if 

MODIFY SELECTION:C204($ptr_file->)
SET WINDOW TITLE:C213("")
SET MENU BAR:C67(1)
