//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/10, 16:25:15
	// ----------------------------------------------------
	// Method: QR_GetPFILEDesigner
	// Description
	//  ` Retrieve the Designer for the current ProjectFIle
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($0; $PRJ_ConsultantName_txt)
$0:=""
READ ONLY:C145([PRJ_DCPFJoin:135])
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([Conslt_Name:127])
QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
C_LONGINT:C283($Loc_l)
Case of 
	: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
		$PRJ_ConsultantName_txt:=""
		If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
			$PRJ_ConsultantName_txt:=[Conslt_Name:127]ConsultantName_s:2
		Else 
			PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
			If ($Loc_l>0)
				$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
			End if 
		End if 
		
	: (Records in selection:C76([PRJ_DCPFJoin:135])<2)
		
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2)
		If (False:C215)
			$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
			If ($Loc_l>0)
				$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
			End if 
		End if 
		PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
		If ($Loc_l>0)
			$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
		End if 
	Else 
		
		C_LONGINT:C283($ConsultantIDToUse_l)
		PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
		If ($Loc_l>0)
			$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
		End if 
		
End case 
$0:=$PRJ_ConsultantName_txt
