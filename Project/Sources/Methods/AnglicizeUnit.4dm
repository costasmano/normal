//%attributes = {"invisible":true}
//GP AnglicizeUnit
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure takes a metric unit name and returns the
//English equivalent.

C_TEXT:C284($1; $UnitName)  // Command Replaced was o_C_STRING length was 30

$UnitName:=$1

Case of 
	: (Substring:C12($UnitName; 1; 2)="LM")
		$UnitName:="LF"+Substring:C12($UnitName; 3)
	: ($UnitName="EA/SM")
		$UnitName:="EA/SF"
	Else 
		//Should be EA, just return it.     
End case 

$0:=$UnitName