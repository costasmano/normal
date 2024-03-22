If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/05, 16:23:00
	// ----------------------------------------------------
	// Method: Object Method: [Inspections].Tunnel Template.bPrint 
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
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:27:04)
	Mods_2013_05
	//  `Added Redraw window
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 16:59:35)
	Mods_2015_01
	//  `added TDA : tunnel damage
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 14:37:31)
	Mods_2015_02
	//  `added TOT : tunnel Other
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
//INSP_Check4DWriteChgs 
INSP_SaveInspCommts

Case of 
		
	: ([Inspections:27]Insp Type:6="TAL")
		PRINT_TunnelAllItems_F
	: ([Inspections:27]Insp Type:6="TOV")
		PRINT_TunnelAllItems_F
		
	: (([Inspections:27]Insp Type:6="TSP") | ([Inspections:27]Insp Type:6="TDA") | ([Inspections:27]Insp Type:6="TOT"))
		PRINT_Critical
End case 
REDRAW WINDOW:C456