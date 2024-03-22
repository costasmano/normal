//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/04/09, 10:54:25
	// ----------------------------------------------------
	// Method: DCM_ContractNo_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(10/28/10 16:37:57)
	Mods_2010_10
	//  `Added calls to update the Bridge proj manager  and contract status dropdowns
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 

Case of 
		
	: ($FormEvent=On Data Change:K2:15)
		If (Read only state:C362([PRJ_ConstructionProject:116]))
		Else 
			READ ONLY:C145([PRJ_ConstructionProject:116])
		End if 
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=[DCM_Contracts:136]ContractNo:1)
		If (Records in selection:C76([PRJ_ConstructionProject:116])=1)
			DCM_ContrBidItems("LOAD")
			[DCM_Contracts:136]AwardContractDate:4:=[PRJ_ConstructionProject:116]CP_Awarded_d:4
			[DCM_Contracts:136]InitialCompleteDate:5:=[PRJ_ConstructionProject:116]CP_Completion_d:8
			[DCM_Contracts:136]InitContractTotal:12:=[PRJ_ConstructionProject:116]CP_LowBid_r:7
			[DCM_Contracts:136]ApproxRemainingFund:19:=[DCM_Contracts:136]InitContractTotal:12-[DCM_Contracts:136]ApproxSpent:17
			C_LONGINT:C283($kIndex_L)
			
			DCM_BridgeProjMgr_OM(On Load:K2:1)
			$kIndex_L:=Find in array:C230(cboBridgePrjMgr; [DCM_Contracts:136]BridgePrjMgr:33)
			If ($kIndex_L>0)
				cboBridgePrjMgr:=$kIndex_L
			End if 
			
			If (Current date:C33<[DCM_Contracts:136]InitialCompleteDate:5)
				[DCM_Contracts:136]ContractStatus:7:="Open"
			End if 
			$kIndex_L:=Find in array:C230(cboStatus; [DCM_Contracts:136]ContractStatus:7)
			If ($kIndex_L>0)
				cboStatus:=$kIndex_L
			End if 
			
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
			DCM_ProjFileNo_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			DCM_ContrDesc_txt:=[PRJ_ConstructionProject:116]CP_AEDescription_txt:22
			QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=DCM_ProjFileNo_L)
			If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])>0)
				SELECTION TO ARRAY:C260([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $pf_attrIDs_aL)
				QUERY WITH ARRAY:C644([PRJ_Attributes:130]ATTR_ID_l:1; $pf_attrIDs_aL)
				SELECTION TO ARRAY:C260([PRJ_Attributes:130]ATTR_Name_s:2; $pf_attrNames_atxt)
				If (Find in array:C230($pf_attrNames_atxt; "Pot@Accel@Bridge@")>0)
					DCM_ABPStatus_L:=2
				Else 
					If (Find in array:C230($pf_attrNames_atxt; "@ABP@")>0)
						DCM_ABPStatus_L:=1
					End if 
				End if 
			End if 
			
			QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=[PRJ_ConstructionProject:116]CTR_ContractorID_l:2)
			[DCM_Contracts:136]ConsultantName:3:=[PRJ_Contractor:114]CTR_CompanyName_s:2
		Else 
			DCM_ProjFileNo_L:=0
			DCM_ContrBidItems("LOAD")
			
		End if 
		POPUPMENUC(->cboStatus; ->cboStatus; ->[DCM_Contracts:136]ContractStatus:7)
		
End case 
