//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/12/06, 20:18:26
	// ----------------------------------------------------
	// Method: utf_GetDBIE_PID
	// Description
	// Get the Personnel table P_ID for the DBIE
	// 
	// Parameters
	// $0 : DBIE PID : Integer
	// $1 : Inspection resp  (optional) : string(4)
	// ----------------------------------------------------
	
	Mods_2007_CM02
End if 
C_LONGINT:C283($0; $DBIE_PID_I)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($1; $InspResp; $vsDivNo)  // Command Replaced was o_C_STRING length was 5
If (Count parameters:C259=1)
	$InspResp:=$1
Else 
	$InspResp:=[Bridge MHD NBIS:1]InspResp:173
End if 
READ ONLY:C145([Personnel:42])
Case of 
	: ($InspResp="DIST@")
		$vsDivNo:="044"+Substring:C12($InspResp; 5; 1)
	: ($InspResp="MDC@")
		$vsDivNo:="DCR"
	: ($InspResp="MBTA@")
		$vsDivNo:="MBTA"
	: ($InspResp="MTA@")
		$vsDivNo:="MTA"
	Else 
		$vsDivNo:="044"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))
End case 
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Division No:7=$vsDivNo)
If (Records in selection:C76([Personnel:42])=1)
	$DBIE_PID_I:=[Personnel:42]Person ID:1
Else 
	$DBIE_PID_I:=-1
End if 
$0:=$DBIE_PID_I
READ WRITE:C146([Personnel:42])