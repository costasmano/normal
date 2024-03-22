//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/20/06, 14:06:13
	// ----------------------------------------------------
	// Method: GetPersonInfo_DPM 
	// Description
	// get Values for the Director of Project Management
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
C_TEXT:C284(vDirProjMgt_txt; vDirProjMgt_INI_txt; vDirProjMgt_FIL_txt)

//JobCode = 15le
If (GetPersonInfo(15; ->vDirProjMgt_txt; ->vDirProjMgt_INI_txt; ->vDirProjMgt_FIL_txt)=0)
	vDirProjMgt_txt:="David Anderson, P.E."
	vDirProjMgt_FIL_txt:="D. Anderson"
	vDirProjMgt_INI_txt:="DA"
End if 
