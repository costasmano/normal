//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/12/10, 16:35:01
	// ----------------------------------------------------
	// Method: PRJ_QR_NumBridgesSamePFILE
	// Description
	// Return the number of Bridges (BDEPTS) with the same Proj File No
	// 
	// Parameters
	// $0 : $NumBridges_L
	// $1 : $PFile_L  (optional)
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_LONGINT:C283($0; $NumBridges_L)
C_LONGINT:C283($PFile_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$PFile_L:=$1
Else 
	$PFile_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
End if 

SET QUERY DESTINATION:C396(Into variable:K19:4; $NumBridges_L)
QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=$PFile_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=$NumBridges_L