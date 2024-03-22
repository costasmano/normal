//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/11, 16:49:29
	// ----------------------------------------------------
	// Method: DCM_DailyControl_FM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2011_02
End if 

C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		C_DATE:C307(DCM_DailyDate_d)
		C_TEXT:C284(DCM_DailyComment_txt)
		DCM_DailyDate_d:=[DCM_ProjDailys:143]DailyDate_d:3
		DCM_DailyComment_txt:=[DCM_ProjDailys:143]Comments_txt:4
		DCM_DailyControl_OM("LB"; $FormEvent_L)
		If (DCM_DailyDate_d=!00-00-00!)
			OBJECT SET ENABLED:C1123(*; "DCM_Daily@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(DCM_DailyClose; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 