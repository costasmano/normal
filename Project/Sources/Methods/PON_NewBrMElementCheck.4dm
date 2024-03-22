//%attributes = {"invisible":true}
// Method: PON_NewBrMElementCheck
// Description
// run the checks required for either NBEs or CUs
// 
// Parameters
//$0 : $PontisErrors_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 03/26/15, 12:19:46
	// ----------------------------------------------------
	// First Release
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(9/29/15 12:43:02)
	Mods_2015_09_bug
	//  `Do not require elements for non-NBI bridge records - wiil still  run checks if there are any elements entered.
End if 

C_TEXT:C284($0)

C_LONGINT:C283($vNumCondU_i; $NumNBES_L)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($PontisErrors_txt)
$PontisErrors_txt:=""
If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
	$NumNBES_L:=Records in selection:C76([PON_ELEM_INSP:179])
	
	If ($NumNBES_L>0)
		$PontisErrors_txt:=PON_VerifyNBEQuantities
	Else 
		If ([Bridge MHD NBIS:1]FHWARecord:174)
			$PontisErrors_txt:="National Bridge Elements have not been entered for this Inspection!"
		End if 
	End if 
	
Else 
	$vNumCondU_i:=Records in selection:C76([Cond Units:45])
	If ($vNumCondU_i>0)
		$PontisErrors_txt:=G_CheckCondUnits
	Else 
		If ([Bridge MHD NBIS:1]FHWARecord:174)
			$PontisErrors_txt:="Pontis Elements have not been entered for this Inspection!"
		End if 
	End if 
	
End if 

$0:=$PontisErrors_txt