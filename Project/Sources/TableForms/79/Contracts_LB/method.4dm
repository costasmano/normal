
If (False:C215)
	// ----------------------------------------------------
	// Method: Form Method: Contract Maintenance Out
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:34:16)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		InspRtgContrAccess_b:=User in group:C338(Current user:C182; "ReadOnly")
		C_LONGINT:C283(PWINDOWWIDTH_L; $L; $T; $R; $B)
		GET WINDOW RECT:C443($L; $T; $R; $B)
		PWINDOWWIDTH_L:=$R-$L
		If (InspRtgContrAccess_b)
			OBJECT SET VISIBLE:C603(bzAdd; False:C215)
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(S3FedAid)  // **Replaced old C_STRING length 1
		S3FedAid:=f_Boolean2String([Contracts:79]FederalFund:8; "YN")
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 
//End [Contract_Maintenance].Contract Maintenance_LB