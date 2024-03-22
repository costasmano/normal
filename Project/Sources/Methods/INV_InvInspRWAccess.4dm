//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/19/07, 11:19:31
	// ----------------------------------------------------
	// Method: INV_InvInspRWAccess
	// Description
	// 
	// 
	// Parameters
	// $0 : $AccessRW_b : boolean
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(4/16/08 08:26:09)
	Mods_2008_CM_5403  //modified to use the BRG_RWAccess also
	// Modified by: costasmanousakis-(Designer)-(1/4/10 11:52:26)
	Mods_2009_12
	//  `Remove restriction on External Inspectors
End if 
C_BOOLEAN:C305($0; $AccessRW_b)
C_TEXT:C284($currUser_txt)
$currUser_txt:=Current user:C182
//$AccessRW_b:=(User in group($currUser_txt;"MHDInspectionRWAccess") & (Not(User in group($currUser_txt;"ExternalInspectors"))))
$AccessRW_b:=User in group:C338($currUser_txt; "MHDInspectionRWAccess")
$AccessRW_b:=$AccessRW_b & BRG_RWAccess

$0:=$AccessRW_b