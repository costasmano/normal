// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 03/09/06, 10:49:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 


Case of 
	: (Records in set:C195("UserSet")>1)
		ALERT:C41("You can not select more than one Project")
	: (Records in set:C195("UserSet")=0)
		ALERT:C41("You must select a Project")
	Else 
		USE SET:C118("UserSet")
		<>PRJ_SelectedData_txt:=String:C10([PRJ_ProjectFile:117]PF_FileID_l:1)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		CANCEL:C270
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
End case 

//End Object Method: Button1