
// ----------------------------------------------------
// Object Method: bDone
// User name (OS): cjmiller
// Date and time: 03/15/07, 12:50:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //Make array names uniform 
End if 

If (PRJ_PT_ValidEntry)
	C_TEXT:C284($msg)
	$msg:="Current data for "+PRJ_ConsultantReviewers_atxt{PRJ_ConsultantReviewers_atxt}
	If (PT_CostCodeName_atxt>0)
		$msg:=$msg+" on "+PT_CostCodeName_atxt{PT_CostCodeName_atxt}
	Else 
		C_LONGINT:C283($ItemSelected_L; $ItemRef_L)
		C_TEXT:C284($Itemname_txt)
		Case of 
			: (aViewDesign=1)
				$ItemSelected_L:=Selected list items:C379(PT_DesignProjectList_HL)
				GET LIST ITEM:C378(PT_DesignProjectList_HL; $ItemSelected_L; $ItemRef_L; $Itemname_txt)
			: (aViewConstruction=1)
				$ItemSelected_L:=Selected list items:C379(PT_ConstructionProjectList_HL)
				GET LIST ITEM:C378(PT_ConstructionProjectList_HL; $ItemSelected_L; $ItemRef_L; $Itemname_txt)
		End case 
		$msg:=$msg+" on Project "+$Itemname_txt
	End if 
	
	$msg:=$msg+" for WeekEnding "+String:C10(PRJ_PT_WeekEnding_d)
	$msg:=$msg+" not saved! Save them?"
	CONFIRM:C162($msg; "Save and exit"; "Exit w/out Saving")
	If (OK=1)
		PRJ_PT_ValidateTime_OM
	End if 
End if 

//End Object Method: bDone