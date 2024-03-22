//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/20/06, 14:16:35
	// ----------------------------------------------------
	// Method: GetPersonInfo_IHEng
	// Description
	// get the In House Engineer Info,
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
End if 
C_TEXT:C284(vInHouseEng_txt; vInHouseEng_INI_txt; vInHouseEng_FIL_txt)

//JobCode = 13
If (GetPersonInfo(14; ->vInHouseEng_txt; ->vInHouseEng_INI_txt; ->vInHouseEng_FIL_txt)=0)
	vInHouseEng_txt:="Daniel Crovo, P.E."
	vInHouseEng_FIL_txt:="D. Crovo"
	vInHouseEng_INI_txt:="DC"
End if 
