If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/02/07, 09:16:19
	// ----------------------------------------------------
	// Method: Form Method: [Activity Log];"SearchForField"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(ARCHSRC_TBL_L; ARCHSRC_FLD_L)
		C_TEXT:C284(ARCHSRC_TBL_txt; ARCHSRC_FLD_txt; Results_txt)
		ARCHSRC_TBL_L:=0
		ARCHSRC_FLD_L:=0
		ARCHSRC_TBL_txt:=""
		ARCHSRC_FLD_txt:=""
		Results_txt:=""
		OBJECT SET ENABLED:C1123(FldBtn; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(FindBtn; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(ARCSRCDone; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 