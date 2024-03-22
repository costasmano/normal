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
If (Records in set:C195("UserSet")=1)
	USE SET:C118("UserSet")
	<>PRJ_SelectedData_txt:=[TableOfLists:125]ListValue_s:2
	POST OUTSIDE CALL:C329(<>ProjectProcess_l)
	//HIDE PROCESS(Current process)
	//PAUSE PROCESS(Current process)
	CANCEL:C270
Else 
	Case of 
		: (<>SelectionOption_txt="FederalAid")
			ALERT:C41("You can not select more than one type of Federal Aid")
		: (<>SelectionOption_txt="Program")
			ALERT:C41("You can not select more than one type of program")
			
		: (<>SelectionOption_txt="ProjectFile")
			ALERT:C41("You can not select more than one type of Project File")
			
	End case 
End if 


//End Object Method: Button1