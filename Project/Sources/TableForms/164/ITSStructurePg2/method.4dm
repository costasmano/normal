
// ----------------------------------------------------
// User name (OS): administrator
//  ` Date and time: 10/23/14, 15:20:42
// ----------------------------------------------------
//Form Method: [LSS_Inspection];"ITSStructurePg2"
// Description
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/15/16 10:55:03)
	Mods_2016_01_bug
	//  `made form type detail form for printing; form platform printing; adjust size location of SIN and Routenumber
	//  `replaced Plans and photos  fields with checkboxes with variables; added call to LSS_FillPrintCheckBoxes
	//  `increased  size of boxes for num arms, arm lengths, heights
	
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		FORM_FixHairLine
		LSS_FillVerticalClearance
		LSS_FillGeometricData
		LSS_FillAccessibility
		LSS_FillPrintCheckBoxes
		LSS_SetUpP2Recommendation
		OBJECT SET VISIBLE:C603(*; "LSSOther@"; True:C214)
		If ([LSS_Inventory:165]LSS_NumberOfSpansArms_L:20=2)
			
			OBJECT SET VISIBLE:C603(*; "Spanlengtha@"; True:C214)
		End if 
		If (LSSOtherDescription_s="OTHER")
			If (LSS_AccessibilityNeed7_s="N") & (LSS_AccessibilityUsed7_s="N")
				OBJECT SET VISIBLE:C603(*; "LSSOther@"; False:C215)
			End if 
		End if 
		
		
		
End case 


