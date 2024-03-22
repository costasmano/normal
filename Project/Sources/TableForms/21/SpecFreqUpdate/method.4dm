If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/19/07, 08:16:56
	// ----------------------------------------------------
	// Method: Form Method: SpecFreqUpdate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(SpMemCheckOption_txt)
		C_LONGINT:C283(vItem92CA_L; vItem92CA_new_L)
		C_BOOLEAN:C305(vItem92CA_b; vItem92CA_new_b)
		vItem92CA_L:=Num:C11(vItem92CA_b)
		OBJECT SET ENABLED:C1123(vItem92CA_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		vItem92CA_new_L:=Num:C11(vItem92CA_new_b)
		INSP_SpcFreqColorSet(->vItem58)
		INSP_SpcFreqColorSet(->vItem59)
		INSP_SpcFreqColorSet(->vItem60)
		INSP_SpcFreqColorSet(->vItem61)
		INSP_SpcFreqColorSet(->vItem62)
		
		If (SpMemCheckOption_txt="UW")
			FORM GOTO PAGE:C247(2)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 