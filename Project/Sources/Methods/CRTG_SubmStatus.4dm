//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/07, 12:12:25
	// ----------------------------------------------------
	// Method: CRTG_SubmStatus
	// Description
	// Return the status of a report
	// 
	// Parameters
	// $0 : $Status_txt : text
	// $1 : $Subm_d : date
	// $2 : InHouse_d : date
	// $3 : ToCons_d : date
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_TEXT:C284($0; $Status_txt)
C_DATE:C307($1; $Subm_d; $2; $InHouse_d; $3; $ToCons_d)
$Subm_d:=$1
$InHouse_d:=$2
$ToCons_d:=$3
$Status_txt:=""
If ($Subm_d#!00-00-00!)
	Case of 
		: ($ToCons_d#!00-00-00!)
			$Status_txt:="Sent back"
		: ($InHouse_d#!00-00-00!)
			$Status_txt:="In Review"
		Else 
			$Status_txt:="Received"
	End case 
	
End if 

$0:=$Status_txt