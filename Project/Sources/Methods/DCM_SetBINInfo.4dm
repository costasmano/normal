//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/07/09, 10:03:08
	// ----------------------------------------------------
	// Method: DCM_SetBINInfo
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
		C_TEXT:C284(vBridgeNo)  // Command Replaced was o_C_STRING length was 50
		C_TEXT:C284(vLocation)  // Command Replaced was o_C_STRING length was 100
		C_TEXT:C284(vTown)  // Command Replaced was o_C_STRING length was 26
		vBridgeNo:=""
		vDistrict:=""
		vLocation:=""
		vTown:=""
		
	: ($Task_txt="SET")
		vBridgeNo:=[Bridge MHD NBIS:1]BDEPT:1
		vDistrict:=[Bridge MHD NBIS:1]Item2:60
		vTown:=[Bridge MHD NBIS:1]Town Name:175
		vLocation:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
		vLocation:=Replace string:C233(vLocation; "OTHER"; "")
		vLocation:=Replace string:C233(vLocation; "WATER"; "")
		vLocation:=Replace string:C233(vLocation; "HWY  "; "")
		vLocation:=Replace string:C233(vLocation; "RR   "; "")
		vLocation:=Replace string:C233(vLocation; "TR   "; "")
		vLocation:=Replace string:C233(vLocation; "COMB "; "")
		C_LONGINT:C283($DblSpacePos_L)
		$DblSpacePos_L:=Position:C15("  "; vLocation)
		While ($DblSpacePos_L>0)
			vLocation:=Replace string:C233(vLocation; "  "; " ")
			$DblSpacePos_L:=Position:C15("  "; vLocation)
		End while 
		vLocation:=f_TrimStr(vLocation; True:C214; True:C214)
		vLocation:=f_CapitalizeTxt(vLocation)
		DCM_ControlCUs("LOADAPPRINSP")
		DCM_ControlCUs("INITCUS")
		
End case 