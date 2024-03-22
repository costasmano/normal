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
		<>PRJ_SelectedData_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractID_l:1)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
		CANCEL:C270
End case 

//End Object Method: Button1