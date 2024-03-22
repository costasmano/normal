//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SetSortColumns
// User name (OS): cjmiller
// Date and time: 10/19/06, 12:34:15
// ----------------------------------------------------
// Description
// This method will turn on and off the sort picture on output forms as well as change it
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_LONGINT:C283($1; $2; $Count_l; $Loop_l; $Skip_l)
C_POINTER:C301($Variable_ptr)
$Count_l:=$1
$Skip_l:=$2

For ($Loop_l; 1; $Count_l)
	$Variable_ptr:=Get pointer:C304("SortColumn"+String:C10($Loop_l)+"_l")
	If ($Loop_l=$Skip_l)
		OBJECT SET VISIBLE:C603($Variable_ptr->; True:C214)
	Else 
		$Variable_ptr->:=0
		OBJECT SET VISIBLE:C603($Variable_ptr->; False:C215)
	End if 
End for 

//End ut_SetSortColumns