//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/02/10, 15:38:15
	// ----------------------------------------------------
	// Method: Method: BMSUtil_BelongToBridge
	// Description
	// Determine if bridge belongs to a user
	// 
	// Parameters
	// $0 : $Access_b
	// $1 : $CurrUser_txt (Optional) if not specified or blank use ◊CurrentUser_Name
	// $2 : $BridgeInspResp (Optional) if not specified or blank use [Bridge MHD NBIS]InspResp
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(11/1/11 14:43:47)
	Mods_2011_11
	//  `Fixed MBTA case - it used to be MBT not MBTA
End if 
C_BOOLEAN:C305($0; $Access_b)
C_TEXT:C284($CurrUser_txt; $BridgeInspResp_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$CurrUser_txt:=$1
Else 
	$CurrUser_txt:=<>CurrentUser_Name
End if 
If ($CurrUser_txt="")
	$CurrUser_txt:=<>CurrentUser_Name
End if 
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$BridgeInspResp_txt:=$2
Else 
	$BridgeInspResp_txt:=[Bridge MHD NBIS:1]InspResp:173
End if 

$Access_b:=($BridgeInspResp_txt="DIST1") & User in group:C338($CurrUser_txt; "District 1")
$Access_b:=$Access_b | (($BridgeInspResp_txt="DIST2") & User in group:C338($CurrUser_txt; "District 2"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="DIST3") & User in group:C338($CurrUser_txt; "District 3"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="DIST4") & User in group:C338($CurrUser_txt; "District 4"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="DIST5") & User in group:C338($CurrUser_txt; "District 5"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="DIST6") & User in group:C338($CurrUser_txt; "District 6"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="MDC") & User in group:C338($CurrUser_txt; "MDC"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="MTA") & User in group:C338($CurrUser_txt; "MTA"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="MBTA") & User in group:C338($CurrUser_txt; "MBTA"))
$Access_b:=$Access_b | (($BridgeInspResp_txt="MPA") & User in group:C338($CurrUser_txt; "MassPort"))

$0:=$Access_b