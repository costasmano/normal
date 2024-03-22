//%attributes = {"invisible":true}
//Method: INSP_SetTransitRtgLabels
//Description
//  `set the printed label for transit load ratings in printed inspection forms -
//  ` works mainly for the TransitFCR forms
// Parameters
// $1 : $ElmRevCar_txt - 
// $2 : $ElmWorkCar_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/14/14, 15:09:37
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($RailInfoRevCar_txt; $RailInfoWorkCar_txt; $MyINSPBIN_txt; $ElmRevCar_txt; $ElmWorkCar_txt)

$ElmRevCar_txt:=$1
$ElmWorkCar_txt:=$2

C_BOOLEAN:C305($fit_b)

If (Is record loaded:C669([RAILBridgeInfo:37]))
	$RailInfoRevCar_txt:=[RAILBridgeInfo:37]Rating_RevCar_desc_s:30
	$RailInfoWorkCar_txt:=[RAILBridgeInfo:37]Rating_WorkCar_desc_s:40
	
End if 

If ($ElmRevCar_txt#"")
	INSP_PR_RevenueLbl_txt:=$ElmRevCar_txt
Else 
	INSP_PR_RevenueLbl_txt:=$RailInfoRevCar_txt
End if 

If ($ElmWorkCar_txt#"")
	INSP_PR_WorkCarLbl_txt:=$ElmWorkCar_txt
Else 
	INSP_PR_WorkCarLbl_txt:=$RailInfoWorkCar_txt
End if 

$fit_b:=ut_FitPrintFormObject(->INSP_PR_RevenueLbl_txt; 7; 5)
$fit_b:=ut_FitPrintFormObject(->INSP_PR_WorkCarLbl_txt; 7; 5)

//End INSP_SetTransitRtgLabels