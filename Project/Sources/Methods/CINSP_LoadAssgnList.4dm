//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 21:18:22
	// ----------------------------------------------------
	// Method: CINSP_LoadAssgnList
	// Description
	// 
	// 
	// Parameters
	// $1 : $Complex : boolean
	// ----------------------------------------------------
	
	Mods_2007_CM07
End if 
C_LONGINT:C283($0; $iMonth)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($1; $Complex_b)
$Complex_b:=$1
C_TEXT:C284($sYear; $sLRIStar)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($sMonth; $sInspMonth)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($sInspType)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_BOOLEAN:C305(LoadRatgInfoReq_b)
C_LONGINT:C283($i; $Recs)
vAssignmentList:=""
LoadRatgInfoReq_b:=False:C215
$Recs:=Records in selection:C76([Cons Inspection:64])
ARRAY TEXT:C222(asDistrict; $Recs)  //Command Replaced was o_ARRAY string length was 5
FIRST RECORD:C50([Cons Inspection:64])
For ($i; 1; $Recs)
	RELATE ONE:C42([Cons Inspection:64]BIN:1)
	asDistrict{$i}:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
	If ($Complex_b)
		vAssignmentList:=vAssignmentList+"    "+[Bridge MHD NBIS:1]Item2:60+<>sTab+[Bridge MHD NBIS:1]Town Name:175+<>sTab
	Else 
		vAssignmentList:=vAssignmentList+[Bridge MHD NBIS:1]Town Name:175+<>sTab
	End if 
	$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
	$BDept:=Insert string:C231($BDept; "-"; 5)
	$iMonth:=Int:C8(Month of:C24([Cons Inspection:64]InspMonth:34))
	$sYear:=String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
	$sMonth:=aMonths{$iMonth}
	$sInspMonth:=Substring:C12($sMonth; 1; 3)+"-"+Substring:C12($sYear; 3; 4)
	$sInspType:=[Cons Inspection:64]InspType:33
	If (Length:C16($sInspType)>35)
		$sInspType:=Replace string:C233($sInspType; "Fracture Critical"; "FC")
		$sInspType:=Replace string:C233($sInspType; "Special Member"; "SM")
		$sInspType:=Replace string:C233($sInspType; "Mechanical"; "Mech.")
		$sInspType:=Replace string:C233($sInspType; "Electrical"; "Elect.")
	End if 
	If ([Cons Inspection:64]LoadRatingInfo:12)
		$sLRIStar:="*"
		LoadRatgInfoReq_b:=True:C214
	Else 
		$sLRIStar:=""
	End if 
	vAssignmentList:=vAssignmentList+$BDept+$sLRIStar+<>sTab+[Cons Inspection:64]BIN:1+<>sTab+$sInspType+<>sTab+$sInspMonth+<>sCR
	NEXT RECORD:C51([Cons Inspection:64])
End for 
$0:=$iMonth