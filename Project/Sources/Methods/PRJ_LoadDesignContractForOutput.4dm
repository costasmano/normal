//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadDesignContractForOutput
// User name (OS): charlesmiller
// Date and time: 04/29/09, 17:16:54
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 17:17:02 `PRJ Design Contract Changes
	Mods_2009_06  //r002 `06/11/09, 13:28:35   `Merge PRJ Design Contract Changes
	Mods_2009_12  // r001 CJ Miller`12/03/09, 10:24:08     `Fix output display of consultant name
	Mods_2009_12  // r001 CJ Miller`12/10/09, 14:33:42     `Fix bug when returning consultant name
	Mods_2009_12  // r001 CJ Miller`12/10/09, 14:33:42     `Fix bug when returning consultant name
End if 
PRJ_ConsultantName_txt:=""
C_LONGINT:C283($Loc_l; $ConsultantIDToUse_l)
If (False:C215)
	If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
	Else 
		REDUCE SELECTION:C351([PRJ_DesignContracts:123]; 0)
	End if 
End if 

If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
	$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
	If ($Loc_l>0)
		PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
	End if 
	
Else 
	QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	
	Case of 
		: (Records in selection:C76([PRJ_DCPFJoin:135])=0)
			If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If ($Loc_l>0)
					PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
				End if 
			Else 
				PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
				If ($Loc_l>0)
					PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
				End if 
			End if 
			
		: (Records in selection:C76([PRJ_DCPFJoin:135])<2)
			
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2)
			If (False:C215)
				$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
				$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If ($Loc_l>0)
					PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
				End if 
			End if 
			PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
			If ($Loc_l>0)
				PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
			End if 
		Else 
			
			C_LONGINT:C283($ConsultantIDToUse_l)
			PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
			$Loc_l:=Find in array:C230(PRJ_ConsultantID_al; $ConsultantIDToUse_l)  //[PRJ_DesignContracts]ConsultantNameID_l)
			If ($Loc_l>0)
				PRJ_ConsultantName_txt:=PRJ_ConsultantName_atxt{$Loc_l}
			End if 
			
	End case 
	//RELATE ONE([PRJ_ProjectFile]DC_DesignProjectID_l;[PRJ_DesignContracts]DC_DesignProjectID_l)
	//QUERY([PRJ_DesignContracts];[PRJ_DesignContracts]DC_DesignProjectID_l=[PRJ_ProjectFile]DC_DesignProjectID_l)
	
End if 


//End PRJ_LoadDesignContractForOutput