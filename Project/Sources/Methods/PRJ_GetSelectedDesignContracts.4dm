//%attributes = {"invisible":true}
// ----------------------------------------------------
//PRJ_GetSelectedDesignContracts
// User name (OS): cjmiller
// Date and time: 05/30/07
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //Add ability to select by design contract
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:39:23`` Make sure only real numbers displayed
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

//C_TEXT($search_txt)
//$search_txt:=◊PRJ_SelectedData_txt+"@"
C_LONGINT:C283($NumDigits_L; $LowLim_L; $UpperLim_L; $loop_l)
$NumDigits_L:=Length:C16(<>PRJ_SelectedData_txt)
$LowLim_L:=Num:C11(<>PRJ_SelectedData_txt)
$UpperLim_L:=$LowLim_L+1
CREATE EMPTY SET:C140([PRJ_DesignContracts:123]; "SELEPROJFILESET")
SET QUERY DESTINATION:C396(Into set:K19:2; "SELEPROJFILESUBSET")
For ($loop_l; $NumDigits_L; 5)
	QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3>=($LowLim_L*(10^(6-$loop_l))); *)
	QUERY:C277([PRJ_DesignContracts:123];  & ; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3<($UpperLim_L*(10^(6-$loop_l))))
	UNION:C120("SELEPROJFILESET"; "SELEPROJFILESUBSET"; "SELEPROJFILESET")
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
USE SET:C118("SELEPROJFILESET")
QUERY SELECTION:C341([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1>0)
CLEAR SET:C117("SELEPROJFILESET")
CLEAR SET:C117("SELEPROJFILESUBSET")
ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
<>PRJ_SelectedData_txt:=""
//End PRJ_GetSelectedDesignContracts