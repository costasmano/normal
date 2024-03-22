//%attributes = {"invisible":true}
//GP GetOwnerTrans

//Owner Description.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/18/11 13:12:00)
	Mods_2011_10
	//  `Added Optional param
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 27
C_TEXT:C284($code_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$code_txt:=$1
Else 
	$code_txt:=[Bridge MHD NBIS:1]Item22:128
End if 

QUERY:C277([MaintOwnerCode:4]; [MaintOwnerCode:4]Code:1=$code_txt)
Case of 
	: (Records in selection:C76([MaintOwnerCode:4])<=0)
		$0:=""
	: (Records in selection:C76([MaintOwnerCode:4])=1)
		$0:=[MaintOwnerCode:4]Description:2
	Else 
		$0:="Error-Not Unique"
End case 