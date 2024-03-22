//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_GetSelectedProjectFiles
// User name (OS): cjmiller
// Date and time: 01/20/06, 10:42:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
	Mods_2007_CJM_v5303  //r004 `10/23/07, 15:18:43`Make sure only real project file numbers displayed
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:10:01`Make sure all possibilities are queried for
	// Modified by: costasmanousakis-(Designer)-(11/20/09 11:45:26)
	Mods_2009_11
	//If the number of digits in the proj file is 6, then the upper is same as lower
	//Compare file numbers LESS than the upper, not LESS OR EQUAL
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283($NumDigits_L; $LowLim_L; $UpperLim_L; $loop_l)
$NumDigits_L:=Length:C16(<>PRJ_SelectedData_txt)
$LowLim_L:=Num:C11(<>PRJ_SelectedData_txt)
If ($NumDigits_L=6)
	$UpperLim_L:=$LowLim_L
Else 
	$UpperLim_L:=$LowLim_L+1
End if 

CREATE EMPTY SET:C140([PRJ_ProjectFile:117]; "SELEPROJFILESET")
SET QUERY DESTINATION:C396(Into set:K19:2; "SELEPROJFILESUBSET")
For ($loop_l; $NumDigits_L; 6)
	QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3>=($LowLim_L*(10^(6-$loop_l))); *)
	QUERY:C277([PRJ_ProjectFile:117];  & ; [PRJ_ProjectFile:117]PF_FileNumber_l:3<($UpperLim_L*(10^(6-$loop_l))))
	UNION:C120("SELEPROJFILESET"; "SELEPROJFILESUBSET"; "SELEPROJFILESET")
End for 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
USE SET:C118("SELEPROJFILESET")
QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3>0)
CLEAR SET:C117("SELEPROJFILESET")
CLEAR SET:C117("SELEPROJFILESUBSET")
ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3)
<>PRJ_SelectedData_txt:=""
//End PRJ_GetSelectedProjectFiles