//%attributes = {"invisible":true}
//Method: PrintListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/17/20, 13:59:23
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
	
	C_POINTER:C301(PrintListBox; $1)
	C_TEXT:C284(PrintListBox; $2; $3)
End if 
//
C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1
C_TEXT:C284($2; $FormName_txt; $3; $ListBoxName_txt)
$FormName_txt:=$2
$ListBoxName_txt:=$3
C_LONGINT:C283($l; $t; $b; $r; $PrintableH_L; $PrintedH_L; $First_L; $Height_L; $ListBoxBottom; $l; $t; $Row_L)

PRINT SETTINGS:C106

OPEN PRINTING JOB:C995
FORM LOAD:C1103($Table_ptr->; $FormName_txt)
$l:=1
$t:=1
GET PRINTABLE AREA:C703($b; $r)
C_LONGINT:C283($cl; $ct; $Cr; $cb)
$PrintableH_L:=$B
$PrintedH_L:=0
$First_L:=0
C_BOOLEAN:C305($TotallyPrinted)
GET PRINTABLE AREA:C703($b; $r)
OBJECT GET COORDINATES:C663(*; $ListBoxName_txt; $cl; $ct; $Cr; $cb)
OBJECT SET COORDINATES:C1248(*; $ListBoxName_txt; $cl; $ct; $Cr; $b)
Repeat 
	$TotallyPrinted:=Print object:C1095(*; $ListBoxName_txt; $l; $t; $r; $b)
	
	LISTBOX GET PRINT INFORMATION:C1110(*; $ListBoxName_txt; lk printed height:K53:15; $Height_L)
	$PrintedH_L:=$PrintedH_L+$Height_L
	If ($PrintedH_L>=($PrintableH_L-20))
		PAGE BREAK:C6
	Else 
	End if 
Until ($TotallyPrinted)
CLOSE PRINTING JOB:C996
//End PrintListBox