If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 10:22:55
	// ----------------------------------------------------
	// Method: Form Method: [PRJ_ProjectDetails];BridgeProgram
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//  `Replaced var PRJ_RatingDone_b with PRJ_RatingDone_s
	//Added button Omit subset
End if 
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		SortColumn1_l:=1  //Sort must be done from PRJ_DisplayBridgePgm method...
		ut_SetSortColumns(PRJ_BPGM_NumSort_L; 1)
		
	: (Form event code:C388=On Close Detail:K2:24)
		PRJ_BPGM_WinTitle
		
	: (Form event code:C388=On Display Detail:K2:22)
		PRJ_BPGM_ListDetailData
		
	: (Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		REDRAW:C174(<>asWindows)
End case 
