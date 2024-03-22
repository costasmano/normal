//%attributes = {"invisible":true}
//Method: TNL_QAQCEngr_L
//Description
//
// Parameters
// $0 : $QAQCEngrID_L
// $1 : $DistrNo_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/13, 17:15:05
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
C_TEXT:C284($1)

C_LONGINT:C283($QAQCEngrID_L)
$QAQCEngrID_L:=GRP_GetGroupRepID("TunnelEngineerD"+$1)

$0:=$QAQCEngrID_L
//End TNL_QAQCEngr_L