//%attributes = {"shared":true,"publishedSql":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/19/09, 09:02:02
	// ----------------------------------------------------
	// Method: QR_PersonName
	// Description
	// Return the name of the person passed by person ID
	// 
	// Parameters
	// $0 : $PersonName_txt
	// $1 : $PersonID_i
	// ----------------------------------------------------
	
	Mods_2009_11
End if 
C_LONGINT:C283($1; $PersonID_i)
C_TEXT:C284($0; $PersonName_txt)
C_LONGINT:C283($Pos_L)
$PersonName_txt:=""
$PersonID_i:=$1
$Pos_L:=Find in array:C230(aPeople_ID; $PersonID_i)
If ($Pos_L>0)
	$PersonName_txt:=aPeople{$Pos_L}
End if 

$0:=$PersonName_txt