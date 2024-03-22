//%attributes = {"invisible":true}
// Method: G_PickFromList
// Description
// Select from a List
//
// Parameters
// $0 : $retVal : Longint - list item number
// $1 : $Txt_Str_arrayPtr : pointer to text array (optional)
//  ` if not passed, array arrTab  has to be defined
// $2 : $winTitle_txt (optional)
// $3 : $LongintArr_ptr : will be filled with the indexes of all selected items
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/24/05, 12:04:16
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/10/2006 10:12:38)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/23/2006 16:27:54)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(7/8/08 09:59:34)
	Mods_2008_CM_5404  // ("OTHERQUICKREPORT")
	//  `Added logic to add a window title; changed method of opening the window
	// Modified by: costasmanousakis-(Designer)-(4/12/10 11:04:14)
	Mods_2010_04
	//  `made window type to regular window
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	// Modified by: Costas Manousakis-(Designer)-(2022-12-16 11:48:40)
	Mods_2022_12_bug
	//  `added optional pointer parameter $3
End if 

C_LONGINT:C283($0; $retVal)
C_LONGINT:C283(SelectList_Hlist; SelectListSelected_L)
If (Is a list:C621(SelectList_Hlist))
	CLEAR LIST:C377(SelectList_Hlist; *)
End if 
SelectList_Hlist:=New list:C375
If (Count parameters:C259>0)
	C_POINTER:C301($1; $Txt_Str_arrayPtr)
	$Txt_Str_arrayPtr:=$1
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($Txt_Str_arrayPtr->))
		APPEND TO LIST:C376(SelectList_Hlist; Substring:C12($Txt_Str_arrayPtr->{$i}; 1); $i)
	End for 
Else 
	For ($i; 1; Size of array:C274(arrTab))
		APPEND TO LIST:C376(SelectList_Hlist; arrTab{$i}; $i)
	End for 
End if 
C_TEXT:C284($winTitle_txt)
$winTitle_txt:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$winTitle_txt:=$2
End if 
C_LONGINT:C283($W; $H)
FORM GET PROPERTIES:C674([Dialogs:21]; "SelectFromList"; $w; $H)
CENTER_WINDOW($W; $H; Regular window:K27:1; $winTitle_txt)

If (Count parameters:C259<3)
	DIALOG:C40([Dialogs:21]; "SelectFromList")
Else 
	C_POINTER:C301($3)
	DIALOG:C40([Dialogs:21]; "SelectFromList"; New object:C1471("indexarrayptr"; $3))
End if 

CLOSE WINDOW:C154
If ((OK=1) & (SelectListSelected_L>0))
	$retVal:=SelectListSelected_L
Else 
	$retVal:=-1
End if 
If (Is a list:C621(SelectList_Hlist))
	CLEAR LIST:C377(SelectList_Hlist; *)
End if 

$0:=$retVal