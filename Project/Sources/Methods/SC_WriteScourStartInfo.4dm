//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:58:29
	// ----------------------------------------------------
	// Method: SC_WriteScourStartInfo
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/09/06, 20:22:45
	// ----------------------------------------------------
	// Method: SC_WriteScourStartInfo
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
If (SC_SAVEASHTML_i>0)
	
	C_LONGINT:C283(SC_P_LifeRemain)
	C_REAL:C285(SC_P_AnnualFailProb_r; SC_P_LifeTimeProbFail_r; SC_P_AdjustedFailProb_r; SC_P_TotalFailCost_r; SC_P_LifeTimeRisk_r; SC_P_ContinuityF)
	C_TEXT:C284(SC_P_Category_S)  // Command Replaced was o_C_STRING length was 1
	Case of 
		: (SC_SAVEASHTML_i=1)
			SEND PACKET:C103(vScourCalcDocRef; "<tr>"+<>sCR)
		: (SC_SAVEASHTML_i=2)
			SEND PACKET:C103(vScourCalcDocRef; "<Row>"+<>sCR)
	End case 
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]BDEPT:1; "String")
	SC_WriteSingleDataCol("["+[Bridge MHD NBIS:1]BIN:3+"]"; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item8 Owner:208; "String")
	SC_WriteSingleDataCol(f_Boolean2String([Bridge MHD NBIS:1]StructDef:103; "YN"); "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Town Name:175; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item7:65; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item6A:63; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item2:60; "String")
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item96:157))
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item113:151; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item60:132; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item61:133; "String")
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item71:145; "String")
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item19:91))
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item29:88))
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item26:120; "String")
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item27:83))
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item106:84))
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item43:75; "String")
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item48:92))
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item51:96))
	SC_WriteSingleDataCol(String:C10([Bridge MHD NBIS:1]Item52:97))
	SC_WriteSingleDataCol([Bridge MHD NBIS:1]Item41:141; "String")
	SC_WriteSingleDataCol(f_Boolean2String([Bridge MHD NBIS:1]Acrow Panel:28; "YN"); "String")
End if 