//%attributes = {"invisible":true}
//Method: PON_ShowCoReElements
//Description
// Run window to show the CoReElements for an inspection.
// Parameters
// $1 : $BMSInspectionID_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/15, 11:12:34
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//
C_LONGINT:C283($1)
C_LONGINT:C283($BMSInspectionID_L)
C_TEXT:C284($Form_txt)
$BMSInspectionID_L:=$1
C_LONGINT:C283(PON_ShowCoRe_WID_L)
READ ONLY:C145(*)
INIT_BMS
QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$BMSInspectionID_L)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[BMS Inspections:44]BIN:2)
$Form_txt:="DisplayCoRe"
If (ut_UseListBox(Current method name:C684))
	$Form_txt:=$Form_txt+"_LB"
End if 
PON_ShowCoRe_WID_L:=Open form window:C675([Inspections:27]; $Form_txt)

DIALOG:C40([Inspections:27]; $Form_txt)
CLOSE WINDOW:C154
//End PON_ShowCoReElements