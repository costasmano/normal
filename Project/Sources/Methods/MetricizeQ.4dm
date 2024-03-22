//%attributes = {}
//GP MetricizeQ
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure takes an English quantity and returns the
//metric equivalent.

C_REAL:C285($0; $1; $Quant)
C_TEXT:C284($2; $UnitName)  // Command Replaced was o_C_STRING length was 30

$Quant:=$1
$UnitName:=$2

Case of 
	: (Substring:C12($UnitName; 1; 2)="LM")
		//Convert feet to meters.    
		$Quant:=$Quant*0.3048
	: ($UnitName="EA/SM")
		//Convert square feet to square meters.    
		$Quant:=$Quant*0.3048*0.3048
	Else 
		//Should be EA, just return it.     
End case 

$0:=$Quant