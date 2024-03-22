//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_OPNCommunications
// User name (OS): charlesmiller
// Date and time: 10/22/09, 14:03:00
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 14:03:01   
End if 
C_BOOLEAN:C305($0; $Proceed_b)
C_TEXT:C284($1; $Case_txt)
$Case_txt:=$1
$Proceed_b:=True:C214
Case of 
	: ($Case_txt="Initialize")
		ARRAY TEXT:C222(OPN_TableName_as; 0)  //Command Replaced was o_ARRAY string length was 31
		C_LONGINT:C283(OPN_ConnID_l; OPN_ServerID_l; OPN_CompID_l)
		OPN_ConnID_l:=-999
		OPN_ServerID_l:=-999
		OPN_CompID_l:=-999
	: ($Case_txt="Connect2WebDatabase")
	: ($Case_txt="Disconnect")
		
	Else 
		$Proceed_b:=False:C215
		
		
		
End case 

$0:=$Proceed_b
//End ut_OPNCommunications