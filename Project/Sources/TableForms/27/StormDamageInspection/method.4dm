If (False:C215)
	//Form Method: [Inspections]StormDamageInspection 
	Mods_2012_01
	//Modified by: Kenny Yang-(Designer) `01/26/12, 17:07:22   `\ 
	//new form for flood damage inspection
	// Modified by: Costas Manousakis-(Designer)-(4/27/12 16:51:15)
	Mods_2012_04
	//  `Adjusted form method , added code for logging changes
	// Modified by: Costas Manousakis-(Designer)-(5/7/12 16:15:52)
	Mods_2012_05
	//  `Adjusted form / objects for final release
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 14:26:09)
	Mods_2015_01
	//  `added fiield [Inspections]InspFldWorkComplDate  `  `
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
INSP_UWInputForm_FM