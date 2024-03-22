// Method: Form Method: [LSS_Inspection];"TrafficSignalStructurePg1"
// Description
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/15/16 13:39:34)
	Mods_2016_01_bug
	//  ` changed Cracks from the field to a check box with a boolean variable
	//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
	//  `adjusted size/location of struct material field, struct coating
	//  `increased size of AssetNo
	//  `increased vert size of all single line arial10 in header to 12 ht
	//  `check boxes must be done in form method - check boxes are initialized on form load call LSS_FillPrintCheckBoxes
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	// Modified by: Costas Manousakis-(Designer)-(9/23/16 12:12:02)
	Mods_2016_09
	//  `increased size of LSS_ROUTE_s field
	// Modified by: Costas Manousakis-(Designer)-(6/25/18 14:08:35)
	Mods_2018_06_bug
	//  `set style sheet of Department Header
	// Modified by: Costas Manousakis-(Designer)-(10/3/18 13:30:25)
	Mods_2018_10
	//  `added Owner to top row
	//  `All header box data fields Arial9
	
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		LSS_FillPrintCheckBoxes
End case 