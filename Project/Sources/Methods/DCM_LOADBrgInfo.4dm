//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/07/09, 10:10:18
	// ----------------------------------------------------
	// Method: DCM_LOADBrgInfo
	// Description
	// 
	// 
	// Parameters
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_TEXT:C284(DCM_BrgI58_s; DCM_BrgI59_s; DCM_BrgI60_s; DCM_BrgI61_s; DCM_BrgI62_s; DCM_BrgI113_s)  // Command Replaced was o_C_STRING length was 1
		DCM_BrgI58_s:=""
		DCM_BrgI59_s:=""
		DCM_BrgI60_s:=""
		DCM_BrgI61_s:=""
		DCM_BrgI62_s:=""
		DCM_BrgI113_s:=""
		C_TEXT:C284(DCM_BrgSDFO_s)  // Command Replaced was o_C_STRING length was 10
		DCM_BrgSDFO_s:=""
		C_REAL:C285(DCM_BrgAASHTO_r)
		DCM_BrgAASHTO_r:=-1
		
	: ($Task_txt="LOAD")
		DCM_BrgI58_s:=[Bridge MHD NBIS:1]Item58:130
		DCM_BrgI59_s:=[Bridge MHD NBIS:1]Item59:131
		DCM_BrgI60_s:=[Bridge MHD NBIS:1]Item60:132
		DCM_BrgI61_s:=[Bridge MHD NBIS:1]Item61:133
		DCM_BrgI62_s:=[Bridge MHD NBIS:1]Item62:134
		DCM_BrgI113_s:=[Bridge MHD NBIS:1]Item113:151
		DCM_BrgAASHTO_r:=[Bridge MHD NBIS:1]AASHTO:5
		Case of 
			: ([Bridge MHD NBIS:1]StructDef:103)
				DCM_BrgSDFO_s:="SD"
			: ([Bridge MHD NBIS:1]FunctObs:106)
				DCM_BrgSDFO_s:="FO"
			Else 
				DCM_BrgSDFO_s:="Not Def."
		End case 
		
End case 