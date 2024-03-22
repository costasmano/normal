//%attributes = {}
If (False:C215)
	//function: bHighwayBridge
	//by: Albert Leung
	//date created: 9/19/97  
End if 

C_TEXT:C284($1; $Item42)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305($test; $0)
C_TEXT:C284($over)  // Command Replaced was o_C_STRING length was 1

If (Count parameters:C259=1)
	$Item42:=$1
Else 
	$Item42:=[Bridge MHD NBIS:1]Item42:85
End if 

$over:=Substring:C12($Item42; 1; 1)
$test:=(Position:C15($over; "1.4.5.6.7.8")>0)

$0:=$test