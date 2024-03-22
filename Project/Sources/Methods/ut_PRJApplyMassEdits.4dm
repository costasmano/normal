//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJApplyMassEdits
// User name (OS): cjmiller
// Date and time: 04/12/07, 12:48:07
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(10/3/08 15:36:49)
	Mods_2008_CM_5404  // ("MASSEDITSTRPRJ")
	//  `edit Str Prj Mgr
End if 
USE SET:C118("◊MassEditSet")
CLEAR SET:C117("◊MassEditSet")
READ ONLY:C145(*)
READ WRITE:C146([PRJ_ProjectDetails:115])

C_TEXT:C284($NewValue_txt)
C_LONGINT:C283($NumericValue_l)
C_LONGINT:C283($process_l)
C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)
C_BOOLEAN:C305($Complete_b)
C_POINTER:C301($FieldPtr)
If ((<>FieldToChange_txt="Project File No") | (<>FieldToChange_txt="Struct. Prj. Mgr."))  //Mods_PRJSELECTION
	$NumericValue_l:=Num:C11(<>PRJ_DENewValue_txt)
	Case of 
		: (<>FieldToChange_txt="Project File No")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PF_FileID_l:3
		: (<>FieldToChange_txt="Struct. Prj. Mgr.")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39
	End case 
	
	Repeat 
		APPLY TO SELECTION:C70([PRJ_ProjectDetails:115]; $FieldPtr->:=$NumericValue_l)
		If (Records in set:C195("Lockedset")#0)
			USE SET:C118("Lockedset")
			LOAD RECORD:C52([PRJ_ProjectDetails:115])
			LOCKED BY:C353([PRJ_ProjectDetails:115]; $process_l; $User_txt; $Machine_txt; $ProcessName_txt)
			CONFIRM:C162("There are "+String:C10(Records in set:C195("LockedSet"))+" locked records. The first is locked by "+$User_txt+" on machine "+$Machine_txt; "Continue Trying"; "Skip Remainder")
			If (OK=1)
			Else 
				$Complete_b:=True:C214
			End if 
		Else 
			$Complete_b:=True:C214
		End if 
	Until ($Complete_b)
	
Else 
	Case of 
		: (<>FieldToChange_txt="Program")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_Program_s:23
		: (<>FieldToChange_txt="Federal Aid")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25
		: (<>FieldToChange_txt="Responsible Bridge Group")  //Mods_PRJSELECTION
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44
		: (<>FieldToChange_txt="Entered Design EWO")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43
		: (<>FieldToChange_txt="Entered Construction EWO")
			$FieldPtr:=->[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31
			
	End case 
	$Complete_b:=False:C215
	Repeat 
		APPLY TO SELECTION:C70([PRJ_ProjectDetails:115]; $FieldPtr->:=<>PRJ_DENewValue_txt)
		If (Records in set:C195("Lockedset")#0)
			
			USE SET:C118("Lockedset")
			LOAD RECORD:C52([PRJ_ProjectDetails:115])
			LOCKED BY:C353([PRJ_ProjectDetails:115]; $process_l; $User_txt; $Machine_txt; $ProcessName_txt)
			CONFIRM:C162("There are "+String:C10(Records in set:C195("LockedSet"))+" locked records. The first is locked by "+$User_txt+" on machine "+$Machine_txt; "Continue Trying"; "Skip Remainder")
			If (OK=1)
			Else 
				$Complete_b:=True:C214
			End if 
		Else 
			$Complete_b:=True:C214
		End if 
	Until ($Complete_b)
End if 
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
READ ONLY:C145([PRJ_ProjectDetails:115])

<>MassEdit_l:=0

//End ut_PRJApplyMassEdits