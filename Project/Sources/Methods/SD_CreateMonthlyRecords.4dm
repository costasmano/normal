//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_CreateMonthlyRecords
// User name (OS): cjmiller
// Date and time: 10/05/04, 12:19:04
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CJM01  //10/12/04, 11:40:32
	Mods_2009_12  // r004 CJ Miller`12/29/09, 16:04:25       `Add [Bridge MHD NBIS]LegacyOwner to SD Data
End if 
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
C_DATE:C307($Current_d)
$Current_d:=Current date:C33(*)
C_LONGINT:C283($Year_l; $Month_l; $Loop_l)
$Year_l:=Year of:C25($Current_d)
$Month_l:=Month of:C24($Current_d)
If ($Month_l=1)  //we are doing last yers export
	$Year_l:=$Year_l-1
	$Month_l:=12
Else 
	$Month_l:=$Month_l-1
End if 
C_TEXT:C284($Year_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Month_s)  // Command Replaced was o_C_STRING length was 2
$Year_s:=String:C10($Year_l)
$Month_s:=String:C10($Month_l; "00")
READ ONLY:C145([Bridge MHD NBIS:1])
For ($Loop_l; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_l)
	SD_CreateHistoryRecord($Year_s; $Month_s; [Bridge MHD NBIS:1]BIN:3; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]Town Name:175; [Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]Item7:65; [Bridge MHD NBIS:1]Item6A:63; [Bridge MHD NBIS:1]Item58:130; [Bridge MHD NBIS:1]Item59:131; [Bridge MHD NBIS:1]Item60:132; [Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]AASHTO:5; [Bridge MHD NBIS:1]Item21:127; [Bridge MHD NBIS:1]Item41:141; [Bridge MHD NBIS:1]LegacyOwner:226)
End for 


SD_SetAddRemoveStatus($Year_s; $Month_s)


//End SD_CreateMonthlyRecords