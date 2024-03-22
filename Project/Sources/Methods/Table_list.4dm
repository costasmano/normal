//%attributes = {"invisible":true}
// Method: Table_list
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 01/13/14, 14:56:04
	// ----------------------------------------------------
	// First Release
	Mods_2014_01
End if 

//
C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $WinTitle_txt; $QueryName_txt)
$ProcessName_txt:="Bridge LB"
$NamedSelectionName_txt:="◊BridgeSelect"
$WinTitle_txt:="Bridges"
$QueryName_txt:="BridgeSearch"
C_POINTER:C301($Tbl_ptr)
$Tbl_ptr:=->[Bridge MHD NBIS:1]

C_LONGINT:C283($pid)
$Seq_txt:=String:C10(LNextView($ProcessName_txt)+1)
$ProcessName_txt:=$ProcessName_txt+" "+$Seq_txt
$NamedSelectionName_txt:=$NamedSelectionName_txt+"_"+$Seq_txt
$WinTitle_txt:=$WinTitle_txt+" ["+$Seq_txt+"]"
ALL RECORDS:C47($Tbl_ptr->)
COPY NAMED SELECTION:C331($Tbl_ptr->; $NamedSelectionName_txt)

$pid:=New process:C317("LB_ControlListBoxDisplay"; 0; $ProcessName_txt; $QueryName_txt; Table:C252($Tbl_ptr); $WinTitle_txt; $NamedSelectionName_txt)

//End Table_list