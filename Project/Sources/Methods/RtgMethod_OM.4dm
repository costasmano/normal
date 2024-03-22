//%attributes = {"invisible":true}
// Method: RtgMethod_OM
// Description
// Method used for the object method of the Popup menus
// fot the Rating method in [RatingReports] input form.
// Parameters

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/08/09, 15:27:00
	// ----------------------------------------------------
	
	Mods_2009_04
	// Modified by: costasmanousakis-(Designer)-(8/12/10 09:15:24)
	Mods_2010_08
	//  `Added formats for the MetricTon rating and FactorRatings in the call to G_FormatItm6466
	// Modified by: costasmanousakis-(Designer)-(9/27/10 14:24:24)
	Mods_2010_09
	//Changed metric Ton format passed to G_FormatItm6466 to "" (no format)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283($1; $FormEvent_L)

C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $DescArr_ptr; $CodeArr_ptr; $RtgMthFld_ptr; $BMSMthFld_ptr; $RtgValFld_ptr; $RtgUniVar_ptr; $BMSValFld_ptr)
$FormEvent_L:=$1
$DescArr_ptr:=$2
$CodeArr_ptr:=$3
$RtgMthFld_ptr:=$4
$BMSMthFld_ptr:=$5
$RtgValFld_ptr:=$6
$BMSValFld_ptr:=$7
$RtgUniVar_ptr:=$8

POPUPMENUC($DescArr_ptr; $CodeArr_ptr; $RtgMthFld_ptr)
If ($FormEvent_L=On Clicked:K2:4)
	$BMSMthFld_ptr->:=$RtgMthFld_ptr->
	PushChange(1; $BMSMthFld_ptr)
	PushChange(2; $RtgMthFld_ptr)
	If (Position:C15($RtgMthFld_ptr->; <>SIA_LoadRtg_63_RF_txt)>0)
		If (($RtgValFld_ptr->)>3)
			ALERT:C41("Current value of "+Field name:C257($RtgValFld_ptr)+" is greater than 3.0! Value is changed to 3.0!")
			$RtgValFld_ptr->:=3
			PushChange(2; $RtgValFld_ptr)
			$BMSValFld_ptr->:=$RtgValFld_ptr->
			PushChange(1; $BMSValFld_ptr)
		End if 
		
	End if 
End if 
G_FormatItm6466($RtgMthFld_ptr; $RtgValFld_ptr; $RtgUniVar_ptr)