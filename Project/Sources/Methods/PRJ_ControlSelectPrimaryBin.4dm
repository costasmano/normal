//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelectPrimaryBin
// User name (OS): cjmiller
// Date and time: 11/27/07, 11:23:41
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:23:43
End if 
If (Form event code:C388=On Clicked:K2:4)
	Case of 
		: (PRJ_SelectedBins_as{PRJ_SelectedBins_as}="")
			C_LONGINT:C283($Loc_l)
			$Loc_l:=Find in array:C230(PRJ_SelectedBins_as; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
			If ($Loc_l>0)
				PRJ_SelectedBins_as:=$Loc_l
			Else 
				PRJ_SelectedBins_as:=1
			End if 
			PRJ_SelectedBins_as{0}:=PRJ_SelectedBins_as{PRJ_SelectedBins_as}
		: (PRJ_SelectedBins_as{PRJ_SelectedBins_as}#"") & ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
			[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=PRJ_SelectedBins_as{PRJ_SelectedBins_as}
			PRJ_DEBin_s:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
			PRJ_CreateIncludedBINRecord([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
			PRJ_SetEntryCheckBoxes
			PRJ_LoadPage2Bins
		: (PRJ_SelectedBins_as{PRJ_SelectedBins_as}#[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
			CONFIRM:C162("Change from "+[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34+" Primary Bin, to "+PRJ_SelectedBins_as{PRJ_SelectedBins_as}; "Change"; "No Change")
			If (OK=1)
				[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=PRJ_SelectedBins_as{PRJ_SelectedBins_as}
				PRJ_DEBin_s:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
				PRJ_SetEntryCheckBoxes
				PRJ_LoadPage2Bins
			End if 
		Else 
			
	End case 
End if 
//End PRJ_ControlSelectPrimaryBin