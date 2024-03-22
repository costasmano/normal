//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/17/07, 08:27:03
	// ----------------------------------------------------
	// Method: ut_SelectTableNum
	// Description
	// Select a table number.
	// 
	// Parameters
	// $0 : Table number (L)
	// ----------------------------------------------------
	Mods_2007_CM04
End if 
C_LONGINT:C283($0; $TableNum_L)
//Select table,
C_LONGINT:C283($numTables; $i; $selectedTbl)
$TableNum_L:=0
$numTables:=Get last table number:C254
ARRAY LONGINT:C221($TablePtr_aL; $numTables)
ARRAY TEXT:C222(PickTableName_as; $numTables)  //Command Replaced was o_ARRAY string length was 32
For ($i; 1; $numTables)
	$TablePtr_aL{$i}:=$i
	PickTableName_as{$i}:=Table name:C256($i)
End for 
SORT ARRAY:C229(PickTableName_as; $TablePtr_aL)
$selectedTbl:=G_PickFromList(->PickTableName_as)
If ($selectedTbl>0)
	$TableNum_L:=$TablePtr_aL{$selectedTbl}
End if 
ARRAY TEXT:C222(PickTableName_as; 0)  //Command Replaced was o_ARRAY string length was 32
ARRAY LONGINT:C221($TablePtr_aL; 0)

$0:=$TableNum_L