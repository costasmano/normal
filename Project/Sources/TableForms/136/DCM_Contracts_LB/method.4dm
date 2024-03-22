//Method: [DCM_Contracts].DCM_Contracts_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/30/20, 15:19:31
	// ----------------------------------------------------
	//Created : 
	
	Mods_2020_06
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 15:49:00)
	Mods_2021_10
	//  `set all tables to RO ; Unload record of form table; set form table to RW 
End if 
//

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
		READ ONLY:C145(*)
		UNLOAD RECORD:C212(Current form table:C627->)
		READ WRITE:C146(Current form table:C627->)
		
		
		
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
//End [DCM_Contracts].DCM_Contracts_LB