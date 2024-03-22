//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(2/1/2006 12:08:38)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 14:20:42)
	Mods_2012_12
	//  `Retrieve the phone from the Personnel table
	// Modified by: Costas Manousakis-(Designer)-(12/18/12 11:18:30)
	Mods_2012_12
	//  `Removed erroneous call to  GetDBIEinfo
End if 

C_TEXT:C284(vInspContact)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vInspContactPhone; vInspContactInitial)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sInspContactName; $sInspContactTitle)  // Command Replaced was o_C_STRING length was 100

$sInspContactName:="John Mangan"
$sInspContactTitle:="Bridge Inspection Section"

vInspContactPhone:="(617) 973-7901"
vInspContactInitial:="JFM"
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=12)
If (Records in selection:C76([Personnel:42])=1)
	GOTO SELECTED RECORD:C245([Personnel:42]; 1)
	LOAD RECORD:C52([Personnel:42])
	$sInspContactName:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
	$sInspContactTitle:=Substring:C12(aJob{12}; (Position:C15(" "; aJob{12})+1))
	vInspContactInitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	vInspContactPhone:=[Personnel:42]Phone_s:13
End if 
UNLOAD RECORD:C212([Personnel:42])
REDUCE SELECTION:C351([Personnel:42]; 0)
READ WRITE:C146([Personnel:42])
vInspContact:=$sInspContactName+", "+$sInspContactTitle+","