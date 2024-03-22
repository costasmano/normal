//%attributes = {"invisible":true}
If (False:C215)
	//function: bObsolete
	//Item 68,69,42b,72,67,71
	//created: 9/17/97
	//by: Albert Leung
	//purpose: determine if a bridge is functionally obsolete
	//parameter list: Item42,Item67,Item68,Item69,Item71,Item72
	//this call should always be used in conjunction with bFuncObsCheck
	//example if (bFuncObsCheck & bObsolete)
	//you should also check AASHTO < 80 if you want this to conform to the state defin
	
	// Modified by: costasmanousakis-(Designer)-(2/28/11 10:07:33)
	Mods_2011_02
	//Use Substring instead of $Item42≤2≥
End if 

C_TEXT:C284($1; $2; $3; $4; $5; $6)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item42; $Item67; $Item68; $Item69; $Item71; $Item72)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305($0; $obsolete)

If (Count parameters:C259=6)
	$Item42:=$1
	$Item67:=$2
	$Item68:=$3
	$Item69:=$4
	$Item71:=$5
	$Item72:=$6
Else 
	$Item42:=[Bridge MHD NBIS:1]Item42:85
	$Item67:=[Bridge MHD NBIS:1]Item67:142
	$Item68:=[Bridge MHD NBIS:1]Item68:143
	$Item69:=[Bridge MHD NBIS:1]Item69:144
	$Item71:=[Bridge MHD NBIS:1]Item71:145
	$Item72:=[Bridge MHD NBIS:1]Item72:146
End if 
$obsolete:=False:C215
If (Position:C15($Item68; "0.1.2.3")>0)
	$obsolete:=True:C214
End if 
//Added zero to the check for item42b to match the FHWA's definition
// of deficient bridges

//If ((Position($Item69;"0.1.2.3")>0) & (Position($Item42≤2≥;"1.2.4.6.7.8")>0))

If ((Position:C15($Item69; "0.1.2.3")>0) & (Position:C15(Substring:C12($Item42; 2; 1); "0.1.2.4.6.7.8")>0))
	$obsolete:=True:C214
End if 
If (Position:C15($Item72; "0.1.2.3")>0)
	$obsolete:=True:C214
End if 
If ($Item67="3")
	$obsolete:=True:C214
End if 
If (($Item71="3") & (Position:C15(Substring:C12($Item42; 2; 1); "0.5.6.7.8.9")>0))
	$obsolete:=True:C214
End if 
$0:=$obsolete