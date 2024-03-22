//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/20/06, 14:16:03
	// ----------------------------------------------------
	// Method: GetPersonInfo_CREng
	// Description
	// get the Cons review Engineer info
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
End if 
C_TEXT:C284(vConsRevEng_txt; vConsRevEng_INI_txt; vConsRevEng_FIL_txt)

//JobCode = 13
If (GetPersonInfo(13; ->vConsRevEng_txt; ->vConsRevEng_INI_txt; ->vConsRevEng_FIL_txt)=0)
	vConsRevEng_txt:="Leonard R. Aversa"
	vConsRevEng_FIL_txt:="L. Aversa"
	vConsRevEng_INI_txt:="LRA"
End if 
