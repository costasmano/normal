//%attributes = {}
If (False:C215)
	//function: bDeficient
	//Item 42,43,58,59,60,62,67,71
	//created: 9/17/97
	//by: Albert Leung
	//purpose: determine if a bridge is functionally obsolete
	//parameter list: $Item42,$Item43,$Item58,$Item59,$Item60,$Item62,$Item67,$Item71
	//this call should always be used in conjunction with bFuncObsCheck
	//example if (bFuncObsCheck & bDeficient)
	//you should also check AASHTO < 80 if you want this to conform to the state defin
End if 

C_TEXT:C284($1; $3; $4; $5; $6; $7; $8)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item42; $Item58; $Item59; $Item60; $Item62; $Item67; $Item71; $Item43b)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item43; $2)  // Command Replaced was o_C_STRING length was 3
C_BOOLEAN:C305($0; $deficient)

If (Count parameters:C259=8)
	$Item42:=$1
	$Item43:=$2
	$Item43b:=Substring:C12($Item43; 2; 2)
	$Item58:=$3
	$Item59:=$4
	$Item60:=$5
	$Item62:=$6
	$Item67:=$7
	$Item71:=$8
Else 
	$Item42:=[Bridge MHD NBIS:1]Item42:85
	$Item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
	$Item58:=[Bridge MHD NBIS:1]Item58:130
	$Item59:=[Bridge MHD NBIS:1]Item59:131
	$Item60:=[Bridge MHD NBIS:1]Item60:132
	$Item62:=[Bridge MHD NBIS:1]Item62:134
	$Item67:=[Bridge MHD NBIS:1]Item67:142
	$Item71:=[Bridge MHD NBIS:1]Item71:145
End if 
$deficient:=False:C215
If (Position:C15($Item58; "0.1.2.3.4")>0)
	$deficient:=True:C214
End if 
If (Position:C15($Item59; "0.1.2.3.4")>0)
	$deficient:=True:C214
End if 
If (Position:C15($Item60; "0.1.2.3.4")>0)
	$deficient:=True:C214
End if 
If ((Position:C15($Item62; "0.1.2.3.4")>0) & ($Item43b="19"))
	$deficient:=True:C214
End if 
If (Position:C15($Item67; "0.1.2")>0)
	$deficient:=True:C214
End if 
If ((Position:C15($Item71; "0.1.2")>0) & (Position:C15(Substring:C12($Item42; 2; 1); "0.5.6.7.8.9")>0))
	$deficient:=True:C214
End if 
$0:=$deficient