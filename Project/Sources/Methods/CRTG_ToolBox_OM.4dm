//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/10, 09:25:24
	// ----------------------------------------------------
	// Method: CRTG_ToolBox_OM
	// Description
	//  ` Object method for the Toolbox button on cons rating input form
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=<>CurrentUser_Name
Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		If (($CurrUser_txt="Designer") | (GRP_UserInGroup("ConsRtgToolBoxAccess")=1))
			OBJECT SET VISIBLE:C603(*; "CRTGMaintTools"; True:C214)
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		GRP_EditGroup("RatingReviewers")
		CRTG_LoadReviewerLists
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 