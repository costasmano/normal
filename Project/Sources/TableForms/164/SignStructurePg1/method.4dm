If (False:C215)
	//Form Method: [LSS_Inspection];"SignStructurePg1"
	// Modified by: Costas Manousakis-(Designer)-(1/15/16 12:28:01)
	Mods_2016_01_bug
	//  ` changed Cracks from the field to a check box with a boolean variable
	//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
	//  `adjusted size/location of struct material field, struct coating line
	//  `adjusted size/location of labels in SIGN PANELS header
	//  `adjusted size/location of labels/variables in the structure location line
	//  `adjusted size/location of labels/variables in the structure type line
	//  `increased size of AssetNo
	//  `check boxes must be done in form method - check boxes are initialized on form event; added call to LSS_FillPrintCheckBoxes
	//  ` 
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 13:10:48)
	Mods_2016_02_bug
	//  `fixed field : instead of Luminaire should be Sign Panels
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 17:43:28)
	Mods_2016_05_bug
	//  `use Order by in the SQL select ; increast sign count to 11; resized bottom list of elements to accomodate 11 panels;Code to fit the panel message text
	// Modified by: Costas Manousakis-(Designer)-(5/17/16 11:44:04)
	Mods_2016_05_bug
	//  `use method ut_CountFormVars
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 16:44:08)
	Mods_2016_08_bug
	//  `count "LSS_PanelType@" instead of "LSS_Panel@"  - it was counting both
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	// Modified by: Costas Manousakis-(Designer)-(6/25/18 14:08:35)
	Mods_2018_06_bug
	//  `set style sheet of Department Header
	// Modified by: Costas Manousakis-(Designer)-(10/3/18 13:30:25)
	Mods_2018_10
	//  `added Owner to top row
	//  `All header box data fields Arial9
	// Modified by: Costas Manousakis-(Designer)-(5/18/20 10:14:31)
	Mods_2020_05
	//  `increased number of rows for Section 2 to 19 for Vibration Dampener
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	LSS_FillSignPanelForInspections
	
End if 