If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/05, 16:23:00
	// ----------------------------------------------------
	// Method: Object Method:[Inspections];"AboveWater Template" bPrint
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM11
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(2/16/09 20:42:17)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: costasmanousakis-(Designer)-(1/18/11 16:32:13)
	Mods_2011_01
	//` RR
	Mods_2012_12  //r001 `   `Add print routines for new inspection types
	//PED
	//Modified by: Charles Miller (12/4/12 10:33:47)
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:25:58)
	Mods_2013_05
	//  `added readraw window to fix a Windoz problem
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 15:31:46)
	Mods_2015_02
	//  `Added  tunnel Other
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:40:57)
	Mods_2021_12_bug
	//  `call to INSP_SaveInspCommts
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
//INSP_Check4DWriteChgs 

C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B)
INSP_CreatePDFsofApproved_B:=False:C215

INSP_SaveInspCommts

Case of 
	: ([Inspections:27]Insp Type:6="CMI")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="FCR")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="OTH")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="DAM")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="CLD")
		PRINT_Closed
	: ([Inspections:27]Insp Type:6="RT@")
		PRINT_ROUTINE_F
	: ([Inspections:27]Insp Type:6="CUL")
		PRINT_CULVERT_F
	: ([Inspections:27]Insp Type:6="RRC")
		PRINT_CULVERT_F
	: ([Inspections:27]Insp Type:6="PON")
		PRINT_PONTIS_F
	: ([Inspections:27]Insp Type:6="FRZ")
		PRINT_FREEZE_F
	: ([Inspections:27]Insp Type:6="RRA")
		PRINT_ROUTINE_F
	: ([Inspections:27]Insp Type:6="RRR")
		PRINT_ROUTINE_F
	: ([Inspections:27]Insp Type:6="PED")  //Pedestrian bridge
		PRINT_ROUTINE_F
	: ([Inspections:27]Insp Type:6="RRS")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="RRF")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="RRO")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="RRD")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="TAL")
		PRINT_TunnelAllItems_F
	: ([Inspections:27]Insp Type:6="TOV")
		PRINT_TunnelAllItems_F
	: ([Inspections:27]Insp Type:6="TSP")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="TOT")
		PRINT_Critical
	: ([Inspections:27]Insp Type:6="TDA")
		PRINT_Critical
		
End case 
//FILTER KEYSTROKE(Char(Enter))
REDRAW WINDOW:C456
