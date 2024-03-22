//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/13/09, 13:40:51
	// ----------------------------------------------------
	// Method: SIA_ScourRank_OM
	// Description
	// define and control display/printing of Scour Priority values in SIA forms
	// Uses 4D User group "BridgeScourRankDisplay"
	// 
	// Parameters
	// $1 : $FormEvent (optional)
	// ----------------------------------------------------
	
	Mods_2009_10
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
C_TEXT:C284(SIA_ScCat_s)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283(SIA_ScRank_L)
C_BOOLEAN:C305($SCPRIO_RO_B)
Case of 
	: (($FormEvent=On Load:K2:1) | ($FormEvent=On Printing Detail:K2:18) | ($FormEvent=On Display Detail:K2:22))
		OBJECT SET VISIBLE:C603(*; "@_Scour@"; (User in group:C338(<>CurrentUser_Name; "BridgeScourRankDisplay") | (<>CurrentUser_Name="Designer")))
		SIA_ScCat_s:=""
		SIA_ScRank_L:=0
		$SCPRIO_RO_B:=Read only state:C362([ScourPriorityRank:108])
		If ($SCPRIO_RO_B)
		Else 
			READ ONLY:C145([ScourPriorityRank:108])
		End if 
		
		QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		If (Records in selection:C76([ScourPriorityRank:108])=1)
			LOAD RECORD:C52([ScourPriorityRank:108])
			SIA_ScCat_s:=[ScourPriorityRank:108]Category:5
			SIA_ScRank_L:=[ScourPriorityRank:108]Rank:6
			UNLOAD RECORD:C212([ScourPriorityRank:108])
		End if 
		If ($SCPRIO_RO_B)
		Else 
			READ WRITE:C146([ScourPriorityRank:108])
		End if 
		
End case 