//%attributes = {"invisible":true}
//GP GetFCTrans

//Functional Classification Description.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/18/11 13:12:00)
	Mods_2011_10
	//  `Added Optional param
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284($code_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$code_txt:=$1
Else 
	$code_txt:=[Bridge MHD NBIS:1]Item26:120
End if 

QUERY:C277([FunctionalClass:5]; [FunctionalClass:5]Code:1=$code_txt)
Case of 
	: (Records in selection:C76([FunctionalClass:5])<=0)
		$0:=""
	: (Records in selection:C76([FunctionalClass:5])=1)
		$0:=[FunctionalClass:5]Description:2
	Else 
		$0:="Error-Not Unique"
End case 