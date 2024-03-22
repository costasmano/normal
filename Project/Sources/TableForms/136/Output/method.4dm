If (False:C215)
	// ----------------------------------------------------
	// Method: Form Method: [DCM_Contracts];"Output"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(6/11/10 14:00:32)
	Mods_2010_06
	//  `Allow DistrictMaintenance group to add contracts
	//  `Also reload the CM_SelByStatus array on close detail
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=Current user:C182
		Case of 
			: (User in group:C338($CurrUser_txt; "DistrictMaintenance"))
				OBJECT SET VISIBLE:C603(bzAddCMContract; True:C214)
			: (User in group:C338($CurrUser_txt; "Design Access Group"))
				OBJECT SET VISIBLE:C603(bzAddCMContract; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bzAddCMContract; False:C215)
		End case 
		
		DCM_SortOutputList("INIT")
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283(DCM_ProjInfo_L)
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=[DCM_Contracts:136]ContractNo:1)
		If (Records in selection:C76([PRJ_ConstructionProject:116])=1)
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
			DCM_ProjFileNo_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
		Else 
			DCM_ProjFileNo_L:=0
		End if 
	: (Form event code:C388=On Close Detail:K2:24)
		DISTINCT VALUES:C339([DCM_Contracts:136]ContractStatus:7; CM_SelByStatus)
		SORT ARRAY:C229(CM_SelByStatus)
		CM_SelByStatus{0}:="NoneSelected"
		CM_SelByStatus:=0
		INSERT IN ARRAY:C227(CM_SelByStatus; 1)
		CM_SelByStatus{1}:="Show ALL"
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		WindowTitle
End case 