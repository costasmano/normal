//%attributes = {}
If (False:C215)
	//boolean function: bFuncObsCheck
	//by: Albert Leung
	//created: 9/18/97
	//purpose: Check to see if this bridge is elligible  
	// Modified by: Costas Manousakis-(Designer)-(4/12/13 11:11:39)
	Mods_2013_04
	//  `Added optional parameter $7 to specify a test year for the bridge age will default to the current year
	//  `changed declarations to be C_longint to match compiler_methods
	// Modified by: Costas Manousakis-(Designer)-(8/6/14 15:21:40)
	Mods_2014_08_bug
	//  `fixed first count parameters to > 5 from = 6
End if 

C_BOOLEAN:C305($test; $0)
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 9
C_TEXT:C284($Item5)  // Command Replaced was o_C_STRING length was 1
C_REAL:C285($Item49; $2)
C_BOOLEAN:C305($Item112; $3)
C_TEXT:C284($Item42; $4)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($Item27; $Item106; $5; $6)

$test:=True:C214

If (Count parameters:C259>5)
	$Item5:=Substring:C12($1; 1; 1)
	$Item49:=$2
	$Item112:=$3
	$Item42:=$4
	$Item27:=$5
	$Item106:=$6
Else 
	$Item5:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)
	$Item49:=[Bridge MHD NBIS:1]Item49:93
	$Item112:=[Bridge MHD NBIS:1]Item112:118
	$Item42:=[Bridge MHD NBIS:1]Item42:85
	$Item27:=[Bridge MHD NBIS:1]Item27:83
	$Item106:=[Bridge MHD NBIS:1]Item106:84
End if 
C_LONGINT:C283($testyear_i)
$testyear_i:=Year of:C25(Current date:C33(*))

If (Count parameters:C259>6)
	C_LONGINT:C283($7)
	
	If ($7>0)
		$testyear_i:=$7
	End if 
	
End if 

If ($Item5#"1")
	$test:=False:C215
End if 
If ($Item49<6.1)
	$test:=False:C215
End if 
If ($Item112=False:C215)
	$test:=False:C215
End if 
If (bHighwayBridge($Item42)=False:C215)
	$test:=False:C215
End if 

If (iAgeofBridge($Item27; $Item106; $testyear_i)<10)
	$test:=False:C215
End if 

$0:=$test