If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/10/09, 09:14:29
	// ----------------------------------------------------
	// Method: Form Method: PrintSelection
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	//Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(12/16/09 10:21:14)
	Mods_2009_12
	//Change buttons and text depending on print/preview
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		SCPOA_PrintSummbtn_L:=SCPOA_PrintSumm_L
		SCPOA_PrintPOAbtn_L:=SCPOA_PrintPOA_L
		SCPOA_PrintLocusbtn_L:=SCPOA_PrintLocus_L
		SCPOA_PrintDetourbtn_L:=SCPOA_PrintDetour_L
		SCPOA_PrintFLDNotesbtn_L:=SCPOA_PrintFLDNotes_L
		SCPOA_PrintFVCBtn_L:=SCPOA_PrintFVC_L
		
		If (SCPOA_PrintSumm_L=0)
			OBJECT SET ENABLED:C1123(SCPOA_PrintSummbtn_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(SCPOA_PrintSummbtn_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (SCPOA_PrintPOA_L=0)
			OBJECT SET ENABLED:C1123(SCPOA_PrintPOAbtn_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(SCPOA_PrintPOAbtn_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (SCPOA_PrintLocus_L=0)
			OBJECT SET ENABLED:C1123(SCPOA_PrintLocusbtn_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(SCPOA_PrintLocusbtn_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (SCPOA_PrintDetour_L=0)
			OBJECT SET ENABLED:C1123(SCPOA_PrintDetourbtn_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(SCPOA_PrintDetourbtn_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (SCPOA_PrintFLDNotes_L=0)
			OBJECT SET ENABLED:C1123(SCPOA_PrintFLDNotesbtn_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(SCPOA_PrintFLDNotesbtn_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		C_TEXT:C284(SCPOA_Prn_Prv_txt)
		If (SCPOA_PrintPreview_b)
			OBJECT SET TITLE:C194(vbOK; "Preview")
			SCPOA_Prn_Prv_txt:="Preview"
		Else 
			OBJECT SET TITLE:C194(vbOK; "Print")
			SCPOA_Prn_Prv_txt:="Print"
		End if 
		
End case 
