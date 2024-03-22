//%attributes = {"invisible":true,"publishedSql":true}
//Method: ut_StructListsToBlob
//Description
// Return in a blob the structure lists. Mainly for calls via SQL connection
// attribute : available through SQL = true
// Parameters
// $0 : $StructureLists_blob
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/06/17, 16:30:33
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_BLOB:C604(ut_StructListsToBlob; $0)
End if 
//

C_BLOB:C604($StructureLists_blob; $0)
TRACE:C157
ARRAY LONGINT:C221($listNums_aL; 0)
ARRAY TEXT:C222($listNames_atxt; 0)

LIST OF CHOICE LISTS:C957($listNums_aL; $listNames_atxt)
C_TEXT:C284($ListName_txt)
C_LONGINT:C283($ListID_l; $Loop_l)
SET BLOB SIZE:C606($StructureLists_blob; 0)

For ($Loop_l; 1; Size of array:C274($listNames_atxt))
	$ListID_l:=Load list:C383($listNames_atxt{$Loop_l})
	$ListName_txt:=$listNames_atxt{$Loop_l}
	VARIABLE TO BLOB:C532($ListName_txt; $StructureLists_blob; *)
	LIST TO BLOB:C556($ListID_l; $StructureLists_blob; *)
	CLEAR LIST:C377($ListID_l; *)
End for 

$0:=$StructureLists_blob

//End ut_StructListsToBlob