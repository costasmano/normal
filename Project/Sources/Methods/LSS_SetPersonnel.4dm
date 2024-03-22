//%attributes = {"invisible":true}
//Method: LSS_SetPersonnel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/11/15, 16:09:26
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
End if 
//
ARRAY TEXT:C222(LSS_TeamLeaders_atxt; 0)
ARRAY LONGINT:C221(LSS_TeamLeaderIDs_aL; 0)
ARRAY TEXT:C222(LSS_TeamMembers_atxt; 0)
ARRAY LONGINT:C221(LSS_TeamMemberIDs_aL; 0)
ARRAY TEXT:C222(LSS_ProjManagers_atxt; 0)
ARRAY LONGINT:C221(LSS_ProjManagerIDs_aL; 0)

ARRAY INTEGER:C220($CompanyIDS_aL; 0)
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Employer:9=[LSS_Inspection:164]LSS_ConsultantName_txt:10)
ORDER BY:C49([Personnel:42]; [Personnel:42]First Name:3; >; [Personnel:42]Last Name:5; >)
SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $CompanyIDS_aL)

C_LONGINT:C283($loop_L; $nameIndx_L)
For ($loop_L; 1; Size of array:C274($CompanyIDS_aL))
	$nameIndx_L:=Find in array:C230(aPeople_ID; $CompanyIDS_aL{$loop_L})
	If ($nameIndx_L>0)
		If (Find in array:C230(LSS_AllTeamLeaders_aL; $CompanyIDS_aL{$loop_L})>0)
			APPEND TO ARRAY:C911(LSS_TeamLeaderIDs_aL; $CompanyIDS_aL{$loop_L})
			APPEND TO ARRAY:C911(LSS_TeamLeaders_atxt; aPeople{$nameIndx_L})
			APPEND TO ARRAY:C911(LSS_TeamMemberIDs_aL; $CompanyIDS_aL{$loop_L})
			APPEND TO ARRAY:C911(LSS_TeamMembers_atxt; aPeople{$nameIndx_L})
		Else 
			If (Find in array:C230(LSS_AllTeamMembers_aL; $CompanyIDS_aL{$loop_L})>0)
				APPEND TO ARRAY:C911(LSS_TeamMemberIDs_aL; $CompanyIDS_aL{$loop_L})
				APPEND TO ARRAY:C911(LSS_TeamMembers_atxt; aPeople{$nameIndx_L})
			End if 
			
		End if 
		If (Find in array:C230(LSS_AllProjManagers_aL; $CompanyIDS_aL{$loop_L})>0)
			APPEND TO ARRAY:C911(LSS_ProjManagerIDs_aL; $CompanyIDS_aL{$loop_L})
			APPEND TO ARRAY:C911(LSS_ProjManagers_atxt; aPeople{$nameIndx_L})
		End if 
		
	End if 
	
End for 

If (Form event code:C388=On Load:K2:1)
	If ([LSS_Inspection:164]LSS_TeamLeaderId_L:8>0)
		POPUPMENUC(->LSS_TeamLeaders_atxt; ->LSS_TeamLeaderIDs_aL; ->[LSS_Inspection:164]LSS_TeamLeaderId_L:8)
	Else 
		LSS_TeamLeaders_atxt:=0
	End if 
	If ([LSS_Inspection:164]LSS_ProjectManagerId_L:9>0)
		POPUPMENUC(->LSS_ProjManagers_atxt; ->LSS_ProjManagerIDs_aL; ->[LSS_Inspection:164]LSS_ProjectManagerId_L:9)
	Else 
		LSS_ProjManagers_atxt:=0
	End if 
	
End if 

//End LSS_SetPersonnel