//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/18/09, 16:03:16
	// ----------------------------------------------------
	// Method: SIA_HelpTipCtrl
	// Description
	// setup the help tips in the SIA input form
	// 
	// Parameters
	// $1 : $Task_txt ("RESET"  | "INIT")
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(2/7/11 10:25:05)
	Mods_2011_02
	//  `Added definition of SIA_SelectListInfo_txt
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 15:58:08)
	Mods_2017_10
	//  `use SIA_LoadSelectionListInfo
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_TEXT:C284(SIA_Accepttip_0_txt; SIA_1stRec_0_txt; vGEN_Accept_txt; vGEN_FirstRec_txt; SIA_SelectListInfo_txt)
		
		SIA_1stRec_0_txt:=vGEN_FirstRec_txt
		SIA_Accepttip_0_txt:=vGEN_Accept_txt
		vGEN_Accept_txt:="the Bridge Record"
		vGEN_FirstRec_txt:="Bridge Record"
		C_DATE:C307($Fhwadate_d; $BMSLoad_d)
		SIA_LoadSelectionListInfo(->$Fhwadate_d; ->$BMSLoad_d)
		SIA_SelectListInfo_txt:="Select List from FHWA report dated "+String:C10($Fhwadate_d)+<>sCR
		SIA_SelectListInfo_txt:=SIA_SelectListInfo_txt+"Loaded in BMS on "+String:C10($BMSLoad_d)
	: ($Task_txt="RESET")
		vGEN_Accept_txt:=SIA_Accepttip_0_txt
		vGEN_FirstRec_txt:=SIA_1stRec_0_txt
		
End case 
