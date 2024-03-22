//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/01/10, 10:19:33
	// ----------------------------------------------------
	// Method: ut_showRelStatus
	// Description
	//  ` Show the Relation status on a Field- from command GET FIELD RELATION
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_POINTER:C301($1; $fld_ptr)
C_LONGINT:C283($one_L; $Many_L)
GET FIELD RELATION:C920($1->; $one_L; $Many_L; *)
C_TEXT:C284($0; $Ret_txt)
ARRAY TEXT:C222($cases_txt; 4)
$cases_txt{0}:="NO Relation"
$cases_txt{1}:="Structure"
$cases_txt{2}:="Manual"
$cases_txt{3}:="Auto"

$Ret_txt:=Table name:C256($1)+"."+Field name:C257($1)
$Ret_txt:=$Ret_txt+" Many-One:"+$cases_txt{$one_L}

$Ret_txt:=$Ret_txt+" One-Many:"+$cases_txt{$Many_L}

$0:=$Ret_txt