
If (False:C215)
	//Form Method: [LSS_Inspection];"ITSStructurePg1"
	// Modified by: manousakisc (1/15/2016)
	Mods_2016_01_bug
	//  ` changed Cracks from the field to a check box with a boolean variable
	//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
	//  `adjusted size/location of struct material field, struct coating
	//  `increased size of AssetNo
	//  `check boxes must be done in form method - check boxes are initialized on form load
	// Modified by: Costas Manousakis-(Designer)-(6/25/18 14:08:35)
	Mods_2018_06_bug
	//  `set style sheet of Department Header
	// Modified by: Costas Manousakis-(Designer)-(10/3/18 13:30:25)
	Mods_2018_10
	//  `added Owner to top row
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		LSS_FillPrintCheckBoxes
		
End case 

//LSS_FillPage1_FM ([LSS_Inspection]LSS_InspectionTypeId_s)



