//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/07/10, 08:17:09
	// ----------------------------------------------------
	// Method: Method: DCM_C_Input_FM
	// Description
	// Method for Input Form [DCM_Contracts];"DistrMaintInput"
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_12
	
	//  `  `First copy from Form Method source code
	//  `  `comments carried over below
	// Modified by: costasmanousakis-(Designer)-(6/14/10 12:40:25)
	Mods_2010_06
	//  `On a new record - Clear out related variables used in listboxes and related records;
	//  `Modifed the determination of DCM_ViewOnly_b variable ; only DistrictMaintenance users can edit
	// Modified by: costasmanousakis-(Designer)-(10/28/10 08:36:02)
	Mods_2010_10
	//  `Added a Short message to wait for the on load event
	//  `  `END OF comments carried over 
	// Modified by: costasmanousakis-(Designer)-(12/13/10 12:00:34)
	Mods_2010_12
	//  `Enhancement on Validate Event
	// Modified by: costasmanousakis-(Designer)-(4/6/11 14:00:09)
	Mods_2011_04
	//  `Fixed call to get form properties - was using wrong form name
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
		C_LONGINT:C283($Width; $Height; $TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		FORM GET PROPERTIES:C674([DCM_Contracts:136]; "DistrMaintInput"; $Width; $Height)
		GET WINDOW RECT:C443($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		If (($BottomRightX-$TopLeftX)<$Width)
			$BottomRightX:=$TopLeftX+$Width
		End if 
		If (($BottomRightY-$TopLeftY)<$Height)
			$BottomRightY:=$TopLeftY+$Height
		End if 
		
		SHORT_MESSAGE("Please Wait...")
		DCM_LoadConstrContrList
		C_BOOLEAN:C305(DCM_NewContractRec_b; DCM_ViewOnly_b)
		DCM_NewContractRec_b:=False:C215
		C_TEXT:C284($curUser_txt)
		$curUser_txt:=<>CurrentUser_Name
		DCM_ViewOnly_b:=Not:C34(User in group:C338($curUser_txt; "DistrictMaintenance"))
		InitChangeStack(1)
		C_LONGINT:C283(DCM_ProjFileNo_L; DCM_ABPStatus_L)
		C_TEXT:C284(DCM_ContrDesc_txt)
		//set form sizes
		DCM_ProjFileNo_L:=0
		DCM_ABPStatus_L:=0
		DCM_ContrDesc_txt:=""
		If (Is new record:C668([DCM_Contracts:136]))
			Inc_Sequence("DCMContractMaint"; ->[DCM_Contracts:136]ContractID:2)
			[DCM_Contracts:136]OverheadRate:10:=132  //%
			[DCM_Contracts:136]NetFeeRate:11:=12  //%
			REDUCE SELECTION:C351([PRJ_ConstructionProject:116]; 0)
			REDUCE SELECTION:C351([DCM_WorkOrders:137]; 0)
			REDUCE SELECTION:C351([DCM_Project:138]; 0)
			UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
			UNLOAD RECORD:C212([DCM_WorkOrders:137])
			UNLOAD RECORD:C212([DCM_Project:138])
			DCM_ContrBidItems("LOAD")
			DCM_AssignControl("INIT"; 0)
			
			DCM_NewContractRec_b:=True:C214
		Else 
			DCM_SetupRelated(-1)
			DCM_AssignControl("RELATE")
			DCM_AssignControl("INIT"; Records in selection:C76([DCM_WorkOrders:137]))
			DCM_AssignControl("LOAD")
			DCM_ContrProjControl("INIT"; Records in selection:C76([DCM_Project:138]))
			DCM_ContrProjControl("LOAD")
			If (Read only state:C362([PRJ_ConstructionProject:116]))
			Else 
				READ ONLY:C145([PRJ_ConstructionProject:116])
			End if 
			QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=[DCM_Contracts:136]ContractNo:1)
			If (Records in selection:C76([PRJ_ConstructionProject:116])=1)
				DCM_ContrBidItems("LOAD")
				READ ONLY:C145([PRJ_ProjectFile:117])
				READ ONLY:C145([PRJ_ATTRFileNoXrefs:131])
				QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
				DCM_ProjFileNo_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
				QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=DCM_ProjFileNo_L)
				If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])>0)
					ARRAY LONGINT:C221($pf_attrIDs_aL; 0)
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
				
				DCM_ContrDesc_txt:=[PRJ_ConstructionProject:116]CP_AEDescription_txt:22
			Else 
				DCM_ProjFileNo_L:=0
				DCM_ContrBidItems("LOAD")
				DCM_ContrDesc_txt:=""
			End if 
		End if 
		OBJECT SET ENTERABLE:C238(*; "DEDCMContractNo@"; True:C214)
		CLOSE WINDOW:C154
		
		SET WINDOW RECT:C444($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		
		If (DCM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Add@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		DCM_ContrBidItems("SAVE")
		DCM_ItemQEntered_b:=False:C215
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 