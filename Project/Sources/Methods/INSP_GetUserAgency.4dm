//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/01/06, 11:38:11
	// ----------------------------------------------------
	// Method: INSP_GetUserAgency
	// Description
	// Get the Agency of the current user.
	//  
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(12/20/07 08:50:59)
	Mods_2007_CM_5401
	//  `Use var ◊CurrentUser_UID
End if 

C_TEXT:C284($0; $UserAgency_txt)
C_LONGINT:C283($myUserID_L)
$UserAgency_txt:=""
$myUserID_L:=<>CurrentUser_UID
If ($myUserID_L#0)
	C_BOOLEAN:C305($TableRWState_b)
	$TableRWState_b:=Read only state:C362([Personnel:42])
	If (Not:C34($TableRWState_b))
		READ ONLY:C145([Personnel:42])
	End if 
	QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$myUserID_L)
	If (Records in selection:C76([Personnel:42])>0)
		FIRST RECORD:C50([Personnel:42])
		$UserAgency_txt:=[Personnel:42]Employer:9
	End if 
	If (Not:C34($TableRWState_b))
		READ WRITE:C146([Personnel:42])
	End if 
End if 

$0:=$UserAgency_txt