//%attributes = {"invisible":true}
//Method: PrintListBoxUsingObject
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/08/20, 16:46:03
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12
	
	C_OBJECT:C1216(PrintListBoxUsingObject; $1)
End if 
//

C_OBJECT:C1216($1)
C_OBJECT:C1216($ListBox_obj)
$ListBox_obj:=$1
C_LONGINT:C283($lb_L; $Lb_T; $LB_r; $lB_b)
C_POINTER:C301($Table_ptr)
C_TEXT:C284($FormName_txt; $ListBoxName_txt)
ARRAY TEXT:C222($PropertyNames_atxt; 0)
OB GET PROPERTY NAMES:C1232($ListBox_obj; $PropertyNames_atxt)
ARRAY TEXT:C222($NecessaryNames_atxt; 0)
APPEND TO ARRAY:C911($NecessaryNames_atxt; "Table")
APPEND TO ARRAY:C911($NecessaryNames_atxt; "$LB_L")
APPEND TO ARRAY:C911($NecessaryNames_atxt; "$LB_T")
APPEND TO ARRAY:C911($NecessaryNames_atxt; "ListBox")
APPEND TO ARRAY:C911($NecessaryNames_atxt; "Form")
ARRAY BOOLEAN:C223($PropertiesFound_Ab; 0)
ARRAY BOOLEAN:C223($PropertiesFound_Ab; 5)

C_LONGINT:C283($loop_L)
For ($Loop_L; 1; Size of array:C274($NecessaryNames_atxt))
	$PropertiesFound_Ab{$loop_L}:=(Find in array:C230($PropertyNames_atxt; $NecessaryNames_atxt{$loop_L})>0)
End for 
If (Find in array:C230($PropertiesFound_Ab; False:C215)>0)
	
	
Else 
	$Table_ptr:=Table:C252(OB Get:C1224($ListBox_obj; "Table"; Is longint:K8:6))
	$lb_L:=OB Get:C1224($ListBox_obj; "$LB_L"; Is longint:K8:6)
	$Lb_T:=OB Get:C1224($ListBox_obj; "$LB_T"; Is longint:K8:6)
	$ListBoxName_txt:=OB Get:C1224($ListBox_obj; "ListBox"; Is text:K8:3)
	$FormName_txt:=OB Get:C1224($ListBox_obj; "Form"; Is text:K8:3)
	C_LONGINT:C283($l; $t; $PrintableH_L; $B; $R)
	PRINT SETTINGS:C106
	FORM LOAD:C1103($Table_ptr->; $FormName_txt)
	OPEN PRINTING JOB:C995
	$l:=1
	$t:=1
	GET PRINTABLE AREA:C703($b; $r)
	C_LONGINT:C283($PrintedH_L; $Height_L)
	$PrintableH_L:=$B
	$PrintedH_L:=0
	C_BOOLEAN:C305($TotallyPrinted)
	TRACE:C157
	GET PRINTABLE AREA:C703($b; $r)
	OBJECT SET COORDINATES:C1248(*; $ListBoxName_txt; $lb_L; $Lb_T; $r; $b)
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
	
End if 
//End PrintListBoxUsingObject