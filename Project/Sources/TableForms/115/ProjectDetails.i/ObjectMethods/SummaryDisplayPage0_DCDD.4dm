// ----------------------------------------------------
// Object Method: PRJ_DCDropDown_atxt
// User name (OS): charlesmiller
// Date and time: 04/29/09, 11:51:20
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 11:51:22 `PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (Size of array:C274(PRJ_DCDropDown_atxt)=1)
Else 
	GOTO RECORD:C242([PRJ_DesignContracts:123]; PRJDCRecordNUmber_al{PRJ_DCDropDown_atxt})
	[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=[PRJ_DesignContracts:123]DC_DesignContractID_l:1
	If ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=0
	End if 
	
	
End if 
C_LONGINT:C283($ConsultantIDToUse_l)

$ConsultantIDToUse_l:=PRJ_FillDCForDisplay
PRJ_FillConsAndSetButton($ConsultantIDToUse_l)
//End Object Method: PRJ_DCDropDown_atxt