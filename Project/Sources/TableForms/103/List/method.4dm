If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/28/05, 09:40:59
	// ----------------------------------------------------
	// Method: Form Method: List
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/28/2005 09:41:04)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 12:08:12)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/3/07 13:53:48)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(2/17/10 16:15:22)
	Mods_2010_02
	//  `Fix so that the list keeps track of the work hour that was edited.
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(S2_Assgn_Adden)  // Command Replaced was o_C_STRING length was 10
		If ([Work_Estimate:103]AddendumNo:29<=0)
			S2_Assgn_Adden:=String:C10([Work_Estimate:103]AssignNo:16)
		Else 
			S2_Assgn_Adden:=String:C10([Work_Estimate:103]AssignNo:16)+" / "+String:C10([Work_Estimate:103]AddendumNo:29)
		End if 
		WKHR_ApprStatus_p:=[Work_Estimate:103]WkHrEstApproved:18+1
		WKHR_RevStatus_p:=[Work_Estimate:103]WkHrEstReviewed:33+1
	: (Form event code:C388=On Open Detail:K2:23)
		C_LONGINT:C283(WKHR_WKIDLoaded_L; $Found_L)
		WKHR_WKIDLoaded_L:=[Work_Estimate:103]WKID:1
		
	: (Form event code:C388=On Close Detail:K2:24)
		C_LONGINT:C283(WKHR_WKIDLoaded_L; $Found_L)
		USE NAMED SELECTION:C332("UserRegionA")
		ORDER BY:C49([Work_Estimate:103]; [Work_Estimate:103]ContractNo:3; >)
		SET QUERY DESTINATION:C396(Into set:K19:2; "WKRECTOHILITE")
		QUERY SELECTION:C341([Work_Estimate:103]; [Work_Estimate:103]WKID:1=WKHR_WKIDLoaded_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (Records in set:C195("WKRECTOHILITE")>0)
			HIGHLIGHT RECORDS:C656([Work_Estimate:103]; "WKRECTOHILITE")
		End if 
		CLEAR SET:C117("WKRECTOHILITE")
End case 