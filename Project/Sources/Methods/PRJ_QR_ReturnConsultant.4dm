//%attributes = {"shared":true}
// ----------------------------------------------------
// PRJ_QR_ReturnConsultant
// User name (OS): cjmiller
// Date and time: 03/15/07, 16:40:35
// ----------------------------------------------------
// Description
// This method will return consulant for quick reports
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(2/5/09 16:41:16)
	Mods_2009_CM_5404
	//Adjusted logic to check for cons ID overrrides.
	Mods_2009_05  //r001  `05/07/09, 11:37:13  `Continue changes PRJ Design Contract Changes  
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:37:24   `Merge PRJ Design Contract Changes
	Mods_2009_12  // r001 CJ Miller`12/10/09, 14:33:42     `Fix bug when returning consultant name
End if 
C_TEXT:C284($0; $PRJ_ConsultantName_txt)
$0:=""
If (False:C215)
	C_LONGINT:C283($ConsultantIDToUse_l)
	$ConsultantIDToUse_l:=0
	//PRJ_LoadDesignContractForOutput 
	QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
	If (Records in selection:C76([PRJ_DesignContracts:123])=0)
		
	Else 
		$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
	End if 
	Case of 
		: (([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#[PRJ_DesignContracts:123]ConsultantNameID_l:2) & ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0))
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		Else 
			//$ConsultantIDToUse_l:=[PRJ_DesignContracts]ConsultantNameID_l
	End case 
	
	If ($ConsultantIDToUse_l#0)
		C_LONGINT:C283($Loc_l)
		$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)
		If ($Loc_l>0)
			$0:=PRJ_ConsultantName_atxt{$Loc_l}
		End if 
		
	End if 
End if 

If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
	$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
	If ($Loc_l>0)
		$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
	End if 
	
Else 
	QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	
	Case of 
		: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
			If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If ($Loc_l>0)
					$PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
				End if 
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
	
End if 
$0:=$PRJ_ConsultantName_txt
//End PRJ_QR_ReturnConsultant