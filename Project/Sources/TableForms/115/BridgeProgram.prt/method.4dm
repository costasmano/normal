If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/12/07, 15:44:14
	// ----------------------------------------------------
	// Method: Form Method: BridgeProgram.prt
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJM_v5302  //r001 `10/02/07, 11:30:03
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//  `Replaced var PRJ_RatingDone_b with PRJ_RatingDone_s
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_DATE:C307(PRJ_BPGM_DatePr)
		PRJ_BPGM_DatePr:=Current date:C33(*)
		C_LONGINT:C283(vPageNo)  //Command Replaced was o_C_INTEGER
		vPageNo:=0
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Printing Detail:K2:18)
		PRJ_BPGM_ListDetailData
	: (Form event code:C388=On Printing Footer:K2:20)
		vPageNo:=vPageNo+1
End case 
