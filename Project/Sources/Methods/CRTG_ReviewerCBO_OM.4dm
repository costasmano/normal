//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 08:17:26
	// ----------------------------------------------------
	// Method: CRTG_ReviewerCBO_OM
	// Description
	//  ` Rating Reviewer Obj method
	// 
	// Parameters
	// $1 : $Cbo_ptr
	// $2 : $ReviewerFld_Ptr
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/6/11 09:42:44)
	Mods_2011_12
	//  ` Added assignment of $2-> := $2-> to force refresh of variable. 
	//  ` it did not refresh in some cases
End if 
C_POINTER:C301($1; $2)
POPUPMENUC($1; $1; $2)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; $2)
	$2->:=$2->
End if 