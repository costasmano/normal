//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/31/07, 10:58:33
	// ----------------------------------------------------
	// Method: CM_RelateWorkHour
	// Description
	// 
	// 
	// Parameters
	// $1 : $NewRec_B
	// $2 : $AddendumNo_L (Optional)
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
C_BOOLEAN:C305($1; $NewRec_B)
C_LONGINT:C283($2; $AddendumNo_L)
$NewRec_B:=$1
If (Count parameters:C259>1)
	$AddendumNo_L:=$2
Else 
	$AddendumNo_L:=0
End if 

QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3)
QUERY SELECTION:C341([Work_Estimate:103]; [Work_Estimate:103]AddendumNo:29=$AddendumNo_L)
If ((Records in selection:C76([Work_Estimate:103])=0) | $NewRec_B)
	OBJECT SET ENABLED:C1123(CreateWorkHrs; True:C214)
	OBJECT SET ENABLED:C1123(ViewWorkHrs; True:C214)
	
Else 
	OBJECT SET ENABLED:C1123(CreateWorkHrs; False:C215)
	OBJECT SET ENABLED:C1123(ViewWorkHrs; False:C215)
End if 
UNLOAD RECORD:C212([Work_Estimate:103])