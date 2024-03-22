//%attributes = {"invisible":true}
//Method: SIA_NewBridgeStatCalc
//Description
// return whether the default method of Calculatinh the SD status is the New way or the old one
// Parameters
// $0 :  $Poor_or_OldSD_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/11/18, 17:02:50
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	
	C_BOOLEAN:C305(SIA_NewBridgeStatCalc; $0)
	
End if 
//
C_BOOLEAN:C305($0; $Poor_or_OldSD_b)

//set default method of calculating SD status
C_DATE:C307($Cutoff_Date_d)
$Cutoff_Date_d:=Date:C102(ut_GetSysParameter("NewBridgeCondStatus"; ""; "Value"))

If ($Cutoff_Date_d=!00-00-00!)
	//cut-off not defined use OldSD Method
	$Poor_or_OldSD_b:=False:C215
Else 
	
	If (Current date:C33(*)>=$Cutoff_Date_d)
		$Poor_or_OldSD_b:=True:C214
	Else 
		$Poor_or_OldSD_b:=False:C215
	End if 
End if 

$0:=$Poor_or_OldSD_b
//End SIA_NewBridgeStatCalc