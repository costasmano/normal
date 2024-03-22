//%attributes = {"invisible":true}
If (False:C215)
	//boolean function: bNBISBridge
	//by: Albert Leung
	//created: 9/29/97
	//purpose: Check to see if this bridge should be on the NBI  
End if 

C_BOOLEAN:C305($test; $0)
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 9
C_TEXT:C284($Item5)  // Command Replaced was o_C_STRING length was 1
C_REAL:C285($Item49; $2)
C_TEXT:C284($Item42; $3)  // Command Replaced was o_C_STRING length was 2

$test:=True:C214

If (Count parameters:C259=3)
	$Item5:=Substring:C12($1; 1; 1)
	$Item49:=$2
	$Item42:=$3
Else 
	$Item5:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)
	$Item49:=[Bridge MHD NBIS:1]Item49:93
	$Item42:=[Bridge MHD NBIS:1]Item42:85
End if 
If ($Item5#"1")
	$test:=False:C215
End if 
If ($Item49<6.1)
	$test:=False:C215
End if 
If (bHighwayBridge($Item42)=False:C215)
	$test:=False:C215
End if 

$0:=$test