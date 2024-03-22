//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpPrimaryBinDD
// User name (OS): cjmiller
// Date and time: 04/11/06, 11:09:17
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)

SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; PRJ_SelectedBins_as)
If (Size of array:C274(PRJ_SelectedBins_as)=0)
	
Else 
	
	INSERT IN ARRAY:C227(PRJ_SelectedBins_as; 0; 1)
	PRJ_SelectedBins_as{1}:=""
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])=1)
		If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
			[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=PRJ_SelectedBins_as{1}
		End if 
	End if 
	C_LONGINT:C283($Loc_l)
	$Loc_l:=Find in array:C230(PRJ_SelectedBins_as; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	If ($Loc_l>0)
		PRJ_SelectedBins_as:=$Loc_l
	Else 
		PRJ_SelectedBins_as:=1
	End if 
	PRJ_SelectedBins_as{0}:=PRJ_SelectedBins_as{PRJ_SelectedBins_as}
End if 
//End PRJ_SetUpPrimaryBinDD