//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/28/10, 09:37:38
	// ----------------------------------------------------
	// Method: INSP_UserAllowed
	// Description
	//  ` Determine whether the user is allowed to Open an inspection
	// 
	// Parameters
	// $0 : $Permitted_b
	// $1 : $UserName_txt (optional)
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_BOOLEAN:C305($0; $Permitted_b)
C_TEXT:C284($UserName_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$UserName_txt:=$1
Else 
	$UserName_txt:=<>CurrentUser_Name
End if 

$Permitted_b:=User in group:C338($UserName_txt; "MHDInspectionRWAccess")
//allow access if User is in group or if Inspection is approved.
$Permitted_b:=($Permitted_b | ([Inspections:27]InspApproved:167=BMS Approved))
$Permitted_b:=$Permitted_b | (User in group:C338($UserName_txt; "MHDInspectionROAccess") & [Inspections:27]InspComplete:168 & ([Inspections:27]Insp Type:6#"DV@"))
$Permitted_b:=$Permitted_b | User in group:C338($UserName_txt; "InspectionAllAccess")
$Permitted_b:=$Permitted_b | (([Inspections:27]Insp Type:6="FRZ") & [Inspections:27]InspComplete:168 & ([Inspections:27]InspReviewed:12=BMS Approved))

$0:=$Permitted_b