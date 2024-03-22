//%attributes = {"invisible":true}
If (False:C215)
	//G_GenRemarksArea Method
	//Project method called from form object method of 4D Write area in 
	//Inspection forms
	//Parameters
	//$1: Area
End if 
If (False:C215)
	Mods_2004_CJM03
	// Modified by: costasmanousakis-(Designer)-(8/15/08 08:05:53)
	Mods_2008_CM_5404  // ("INSPCMMTS")
	//  `Added optional parameter 
	//  `$2 : $FormEvent
	// Modified by: costasmanousakis-(Designer)-(9/5/08 08:18:39)
	Mods_2008_CM_5404
	//  `Use method INSP_Comments_OM
	// Modified by: costasmanousakis-(Designer)-(3/19/09 15:45:36)
	Mods_2009_CM_5404
	//Fixed compile bug of incorrect parameter counts
End if 

C_LONGINT:C283($1; $MyArea)
$MyArea:=$1
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$FormEvent:=$2
Else 
	$FormEvent:=Form event code:C388
End if 

INSP_Comments_OM($MyArea; ->[Inspections:27]InspComments:171; $FormEvent)