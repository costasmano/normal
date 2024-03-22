If (False:C215)
	//Form Method: [PRJ_ProjectDetails]PRJ_Details.rpt 
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 15:14:31)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(4/25/12 09:47:08)
	Mods_2012_04
	//  `Adjusted object alignments, sizes to better fit more information.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(PRJ_PRINT_RELOADVARS_B)
		If (PRJ_PRINT_RELOADVARS_B)
			PRJ_SetFormVariableToEmpty
			PRJ_LoadPage_0
			PRJ_LoadPage_1
		End if 
		
End case 
