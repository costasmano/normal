//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/09, 19:07:40
	// ----------------------------------------------------
	// Method: INSP_AddCU
	// Description
	// Object Method to Add CU button
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_02
	//  `NEW HI Calcs 
	// Modified by: costasmanousakis-(Designer)-(2/11/11 09:10:00)
	Mods_2011_02
	//  `Do not Add a CU if [BMS Inspections]Inspection ID less than 1
End if 

If ([BMS Inspections:44]Inspection ID:1>0)
	
	FORM SET INPUT:C55([Cond Units:45]; "Cond Units In")
	Repeat 
		ADD RECORD:C56([Cond Units:45]; *)
		DISPL_CUs
		REDRAW WINDOW:C456
		CONFIRM:C162("Continue Adding Pontis Elements?"; "Continue"; "Done")
	Until (OK#1)
Else 
	ALERT:C41("Need to Create a Pontis Inspection First!   Please click the <Add Pontis Inspecti"+"on> button")
End if 
