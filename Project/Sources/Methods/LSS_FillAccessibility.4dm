//%attributes = {"invisible":true}
// Method: LSS_FillAccessibility
// Description
// 
//
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/23/14, 15:19:53
	// ----------------------------------------------------
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(9/15/15 17:14:40)
	Mods_2015_09_bug
	//  `fixed pointers $Used_ptr and $Need_ptr: were pointing to wrong variables.
End if 

CLEAR VARIABLE:C89(LSS_AccessibilityNeed2_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed2_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed3_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed3_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed4_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed4_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed5_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed5_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed6_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed6_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed7_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed7_s)
CLEAR VARIABLE:C89(LSS_AccessibilityNeed8_s)
CLEAR VARIABLE:C89(LSS_AccessibilityUsed8_s)
CLEAR VARIABLE:C89(LSSOtherDescription_s)

QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)

C_LONGINT:C283($Loop_l)
C_POINTER:C301($Used_ptr; $Need_ptr)
For ($Loop_L; 1; Records in selection:C76([LSS_Accessibility:159]))
	GOTO SELECTED RECORD:C245([LSS_Accessibility:159]; $Loop_L)
	$Need_ptr:=Get pointer:C304("LSS_AccessibilityNeed"+String:C10([LSS_Accessibility:159]LSS_AccessibilityElementId_L:2)+"_s")
	$Used_ptr:=Get pointer:C304("LSS_AccessibilityUsed"+String:C10([LSS_Accessibility:159]LSS_AccessibilityElementId_L:2)+"_s")
	If ([LSS_Accessibility:159]LSS_AccessibilityElementId_L:2=7)
		LSSOtherDescription_s:=[LSS_Accessibility:159]LSS_AccessibilityDescription_s:6
	End if 
	$Used_ptr->:=[LSS_Accessibility:159]LSS_Used_s:5
	$Need_ptr->:=[LSS_Accessibility:159]LSS_Needed_s:4
End for 