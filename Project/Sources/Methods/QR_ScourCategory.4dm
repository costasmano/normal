//%attributes = {"invisible":true,"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/18/08, 14:24:33
	// ----------------------------------------------------
	//Method: QR_ScourCategory 
	// Description
	// Get the max scour priority ranking for a given BDEPT
	// 
	// Parameters
	// $1 : $BDEPT
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("COMMON")
End if 
C_TEXT:C284($1; $Bdept)
C_TEXT:C284($0; $MaxScCategory)
$MaxScCategory:=""
$Bdept:=$1
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$Bdept)
ARRAY TEXT:C222($BIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BIN_as)
QUERY WITH ARRAY:C644([ScourPriorityRank:108]BIN:1; $BIN_as)
If (Records in selection:C76([ScourPriorityRank:108])>0)
	ORDER BY:C49([ScourPriorityRank:108]; [ScourPriorityRank:108]Category:5; <)
	FIRST RECORD:C50([ScourPriorityRank:108])
	$MaxScCategory:=[ScourPriorityRank:108]Category:5
End if 
$0:=$MaxScCategory