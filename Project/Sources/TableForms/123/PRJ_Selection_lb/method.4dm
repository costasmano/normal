// ----------------------------------------------------
// Form Method: PRJ_Selection.o
// User name (OS): cjmiller
// Date and time: 05/30/07
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_2007_CJM_v5303  //r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
	// Modified by: costasmanousakis-(Designer)-(11/19/07 15:55:01)
	Mods_2007_CM_5401
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		
		C_LONGINT:C283($Col_L; $Row_L)
		LISTBOX GET CELL POSITION:C971(*; "PRJDC_Selection_LB"; $Col_L; $Row_L)
		GOTO SELECTED RECORD:C245([PRJ_DesignContracts:123]; $Row_L)
		<>PRJ_SelectedData_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractID_l:1)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
		CANCEL:C270
End case 
//End Form Method: PRJ_Selection.o