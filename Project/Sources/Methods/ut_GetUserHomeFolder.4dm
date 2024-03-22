//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/08, 14:49:39
	// ----------------------------------------------------
	// Method: ut_GetUserHomeFolder
	// Description
	// Return the 'Home' for the current user. Finds a standard system/user 
	// folder and subtracts what's needed to get to the home root.
	// 
	// Parameters
	// $0 : $Path_txt (text)
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("HOMEFOLDER")
End if 
C_TEXT:C284($0; $Path_txt)
If (<>PL_LPlatfrm=Windows:K25:3)
	$Path_txt:=System folder:C487(Startup Win_user:K41:6)
	$Path_txt:=Replace string:C233($Path_txt; "Start Menu\\Programs\\Startup\\"; "")
Else 
	$Path_txt:=System folder:C487(User preferences_user:K41:4)
	$Path_txt:=Replace string:C233($Path_txt; "Library:Preferences:"; "")
End if 

$0:=$Path_txt