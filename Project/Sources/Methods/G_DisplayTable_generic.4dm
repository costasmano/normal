//%attributes = {"invisible":true}
// Method: G_DisplayTable_generic
// Description
// Display a table selection records
// 
// Parameters
// $1 : Table ptr
// $2 : Window title - optional - default = "Table : "+table name
// $3 : input form - optional - default = "Input"
// $4 : output form - optional - default = "Output"
// $5 : menu number - optional - default = 3
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/06, 11:20:37
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 15:59:07)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/14/2007 12:17:23)
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00 18:52:31)
	Mods_2022_01
	//  `if output form ends in _LB use DIALOG command
	Mods_2022_05  //Add List box and selection if designer
	//Modified by: Chuck Miller (5/10/22 12:30:30)
End if 
C_POINTER:C301($1; $Table_ptr)
C_TEXT:C284($2; $3; $4)
C_LONGINT:C283($5)  //Command Replaced was o_C_INTEGER
C_POINTER:C301(${6})
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($InpForm_txt; $Outp_form_txt)
C_LONGINT:C283($MenuNum_i; $NumberSorts_i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($SortFldPtr_ptr; $SortFld2Ptr_ptr; $SortFld3Ptr_ptr)
ARRAY POINTER:C280(ptr_Changes; 0; 0)
$Table_ptr:=$1
If (Count parameters:C259>1)
	MainTitle:=$2
Else 
	MainTitle:="Table : "+Table name:C256($1)
End if 
If (MainTitle="")
	MainTitle:="Table : "+Table name:C256($1)
End if 
If (Count parameters:C259>2)
	$InpForm_txt:=$3
Else 
	$InpForm_txt:="Input"
End if 
If ($InpForm_txt="")
	$InpForm_txt:="Input"
End if 
If (Count parameters:C259>3)
	$Outp_form_txt:=$4
Else 
	$Outp_form_txt:="Output"
End if 
If ($Outp_form_txt="")
	$Outp_form_txt:="Output"
End if 
If (Count parameters:C259>4)
	$MenuNum_i:=$5
Else 
	$MenuNum_i:=3
End if 
If ($MenuNum_i=0)
	$MenuNum_i:=3
End if 
$NumberSorts_i:=0
C_BOOLEAN:C305($DoSort_b)

C_LONGINT:C283($formW_O_L; $formW_I_L; $formH_O_L; $formH_I_L; $i)
If (Count parameters:C259>5)
	$NumberSorts_i:=Count parameters:C259-5
	ARRAY POINTER:C280($SortFlds_aptr; $NumberSorts_i)
	$DoSort_b:=True:C214
	For ($i; 1; $NumberSorts_i)
		$SortFlds_aptr{$i}:=${($i+5)}
	End for 
Else 
	$DoSort_b:=False:C215
End if 

FORM GET PROPERTIES:C674($Table_ptr->; $Outp_form_txt; $formW_O_L; $formH_O_L)
FORM GET PROPERTIES:C674($Table_ptr->; $InpForm_txt; $formW_I_L; $formH_I_L)
$formW_O_L:=MaxNum($formW_O_L; $formW_I_L)
$formH_O_L:=MaxNum($formH_O_L; $formH_I_L)

NewWindow($formW_O_L; $formH_O_L; 1; 8)
SET MENU BAR:C67($MenuNum_i)
UpdatWindArray(""; Current process:C322)
FORM SET INPUT:C55($Table_ptr->; $InpForm_txt)
FORM SET OUTPUT:C54($Table_ptr->; $Outp_form_txt)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
ALL RECORDS:C47($Table_ptr->)
If ($DoSort_b)
	For ($i; 1; $NumberSorts_i)
		ORDER BY:C49($Table_ptr->; $SortFlds_aptr{$i}->; >; *)
	End for 
	ORDER BY:C49($Table_ptr->)
	If (False:C215)
		Case of 
			: ($NumberSorts_i=1)
				ORDER BY:C49($Table_ptr->; $SortFldPtr_ptr->)
			: ($NumberSorts_i=2)
				ORDER BY:C49($Table_ptr->; $SortFldPtr_ptr->; >; $SortFld2Ptr_ptr->; >)
			: ($NumberSorts_i=3)
				ORDER BY:C49($Table_ptr->; $SortFldPtr_ptr->; >; $SortFld2Ptr_ptr->; >; $SortFld3Ptr_ptr->; >)
		End case 
		
	End if 
	
End if 

$RecSel:=String:C10(Records in selection:C76($Table_ptr->))
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")

If ($Outp_form_txt="@_LB")
	//listbox output form
	
	DIALOG:C40($Table_ptr->; $Outp_form_txt)
	
Else 
	//normal output form - use modify selection
	MODIFY SELECTION:C204($Table_ptr->; *; *)  //Display output form even for one record
End if 

UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154