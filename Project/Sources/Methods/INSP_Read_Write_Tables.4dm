//%attributes = {"invisible":true}
//Method: INSP_Read_Write_Tables
//Description
//
// Parameters
// $1 : $ReadOrWrite_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/13, 16:13:45
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(4/1/15 16:59:36)
	Mods_2015_04
	//  `added  [PON_ELEM_INSP]
	// Modified by: Costas Manousakis-(Designer)-(3/9/17 15:04:09)
	Mods_2017_03
	//  `added [ElmtRatingLoads]
End if 
//
C_TEXT:C284($1; $ReadOrWrite_txt)
$ReadOrWrite_txt:=$1

ut_Read_Write_Tables($ReadOrWrite_txt; ->[Inspections:27]; ->[Combined Inspections:90]; ->[BMS Inspections:44]; ->[ElementsSafety:29]; ->[Standard Photos:36]; ->[Field Trip:43]; ->[BMS Field Trip:56]; ->[Cond Units:45])
ut_Read_Write_Tables($ReadOrWrite_txt; ->[Bridge MHD NBIS:1]; ->[TunnelInspection:152]; ->[TunnelInfo:151]; ->[PON_ELEM_INSP:179]; ->[ElmtRatingLoads:158])

//End INSP_Read_Write_Tables