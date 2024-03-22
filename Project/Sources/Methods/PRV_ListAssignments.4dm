//%attributes = {"invisible":true}
//Method: PRV_ListAssignments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/11/12, 15:57:59
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(8/28/12 14:59:15)
	Mods_2012_08
	//  `Use PRV_DisplayAssignments instead of LB_xxxx method
	// Modified by: Costas Manousakis-(Designer)-(9/24/13 16:20:02)
	Mods_2013_09
	//  `order by PINFO num
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
READ ONLY:C145([Contract_Assignment_Maintenance:101])
ALL RECORDS:C47([Contract_Assignment_Maintenance:101])
ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ProjectIS:4; >)  //Mods_2013_09
C_TEXT:C284($NamedSelectionName_txt; $Seq_txt)
$NamedSelectionName_txt:="◊ContracAssigns"+"_"+String:C10(Current process:C322)
COPY NAMED SELECTION:C331([Contract_Assignment_Maintenance:101]; $NamedSelectionName_txt)
C_LONGINT:C283($ProcessID_l)

$ProcessID_l:=LProcessID("Contract Assignments")
If ($ProcessID_l=-1)
	$ProcessID_l:=New process:C317("PRV_DisplayAssignments"; 0; "Contract Assignments"; "ContracAssigns"; Table:C252(->[Contract_Assignment_Maintenance:101]); "Contract Assignments"; $NamedSelectionName_txt)
Else 
	POST OUTSIDE CALL:C329($ProcessID_l)
	SHOW PROCESS:C325($ProcessID_l)
	BRING TO FRONT:C326($ProcessID_l)
End if 

//End PRV_ListAssignments