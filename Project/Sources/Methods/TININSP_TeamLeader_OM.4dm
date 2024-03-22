//%attributes = {"invisible":true}
//Method: TININSP_TeamLeader_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:45:00
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
REDRAW:C174(aTeamLeader)
POPUPMENUC(->aTeamLeader; ->aTeamLdrID; ->[TIN_Inspections:184]TeamLeader:11)
If (Form event code:C388=On Clicked:K2:4)
	If (aTeamLeader>0)
		vTmLeader:=aTeamLeader{aTeamLeader}
	End if 
	
End if 
If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($indx_L)
	$indx_L:=aTeamLeader
	If ($indx_L>0)
		vTmLeader:=aTeamLeader{aTeamLeader}
	Else 
		aTeamLeader:=0
		vTmLeader:=""
		If ([TIN_Inspections:184]TeamLeader:11>0)
			aTeamLeader{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]TeamLeader:11)
		Else 
			aTeamLeader{0}:="Select..."
		End if 
		
	End if 
End if 
//End TININSP_TeamLeader_OM