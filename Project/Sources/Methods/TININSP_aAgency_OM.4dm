//%attributes = {"invisible":true}
//Method: TININSP_aAgency_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:42:49
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	Mods_2018_04  //Make sure no error if no match for agency 
End if 
//
C_BOOLEAN:C305($reset)

REDRAW:C174(aAgency)
If ((Form event code:C388=On Clicked:K2:4) & (aAgency>0))
	$reset:=True:C214
Else 
	$reset:=False:C215
End if 
POPUPMENUC(->aAgency; ->aAgency; ->[TIN_Inspections:184]Agency:13)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[TIN_Inspections:184]Agency:13)
End if 
If ($reset | (Form event code:C388=On Load:K2:1))
	If (aAgency<0)
		aAgency:=0
		aAgency{0}:="Select Agency"
	End if 
	vAgency:=aAgency{aAgency}
	//Set up the team leader and team member arrays.
	REDRAW:C174(aTeamLeader)
	// need to just load a BIN in the right district - used to build the tm ldrs / tm members
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([TunnelInfo:151])
	QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]NTI_i1_s:33=[TIN_Inspections:184]NTI_i1_S:1)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[TunnelInfo:151]BIN:1)
	
	InitPers(vAgency)
	//InitPers recreates the Team Leader array; and Projmgrs reset tehn.  
	If ([TIN_Inspections:184]TeamLeader:11=0)
		If (Size of array:C274(aTeamLeader)=0)
			vTmLeader:="No Team leaders on file."
		Else 
			vTmLeader:="Select Team Leader"
		End if 
		aTeamLeader:=0
		aTeamLeader{0}:=vTmLeader
	Else 
		aTeamLeader:=Find in array:C230(aTeamLdrID; [TIN_Inspections:184]TeamLeader:11)
		If (aTeamLeader<=0)  //Just in case nothing was found in array
			aTeamLeader:=0
			aTeamLeader{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]TeamLeader:11)
		End if 
		
	End if 
	
	If ([TIN_Inspections:184]ProjManager:14=0)
		If (Size of array:C274(TnlInspPrjMgr_atxt)=0)
			vTnlInspProjMgr:="No Proj. Mgrs. on file."
		Else 
			vTnlInspProjMgr:="Select Proj. Mgr."
		End if 
		TnlInspPrjMgr_atxt:=0
		TnlInspPrjMgr_atxt{0}:=vTnlInspProjMgr
	Else 
		INSERT IN ARRAY:C227(TnlInspPrjMgr_atxt; 0; 1)
		INSERT IN ARRAY:C227(TnlInspPrjMgrID_aL; 0; 1)
		TnlInspPrjMgr_atxt{1}:=".. Clear Proj. Mgr."
		TnlInspPrjMgrID_aL{1}:=0
		TnlInspPrjMgr_atxt:=Find in array:C230(TnlInspPrjMgrID_aL; [TIN_Inspections:184]ProjManager:14)
		If (TnlInspPrjMgr_atxt<=0)  //Just in case nothing was found in array
			TnlInspPrjMgr_atxt:=0
			TnlInspPrjMgr_atxt{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]ProjManager:14)
		End if 
		
	End if 
	
End if 
//End TININSP_aAgency_OM