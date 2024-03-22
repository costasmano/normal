// ----------------------------------------------------
// Object Method: Button1
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
End if 

Case of 
	: (Records in set:C195("UserSet")>1)
		ALERT:C41("You can not select more than one Design Contract")
	: (Records in set:C195("UserSet")=0)
		ALERT:C41("You must select a Design Contract")
	Else 
		USE SET:C118("UserSet")
		C_LONGINT:C283($Col_L; $Row_L)
		LISTBOX GET CELL POSITION:C971(*; "PRJDC_Selection_LB"; $Col_L; $Row_L)
		GOTO SELECTED RECORD:C245([PRJ_DesignContracts:123]; $Row_L)
		
		<>PRJ_SelectedData_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractID_l:1)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
		CANCEL:C270
End case 

//End Object Method: Button1