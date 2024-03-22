//%attributes = {"invisible":true}
//Method: PRV_SortByPINFO_d
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/12/12, 10:48:01
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	
End if 
//
C_DATE:C307($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($DoRelatePINFO_b)
$DoRelatePINFO_b:=True:C214
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$DoRelatePINFO_b:=$2
End if 

If ($DoRelatePINFO_b)
	PRV_Variables("RELATEPINFO")
End if 
Case of 
	: ($1="ADDATE")
		$0:=(PRV_SchedAdDate_d)
		If (PRV_ActualAdDate_d#!00-00-00!)
			$0:=(PRV_ActualAdDate_d)
		End if 
		
End case 


//End PRV_SortByBDEPT_s