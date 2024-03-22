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
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 16:32:34)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/21/07 11:59:31)
	Mods_2007_CM_5401
End if 

Case of 
	: (Records in set:C195("UserSet")>1)
		ALERT:C41("You can not select more than one BDEPT/BIN")
	: (Records in set:C195("UserSet")=0)
		ALERT:C41("You must select a BDEPT/BIN")
	Else 
		USE SET:C118("UserSet")
		If (<>ProjectProcess_l>0)
			<>PRJ_SelectedData_txt:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			//HIDE PROCESS(Current process)
			//PAUSE PROCESS(Current process)
			ACCEPT:C269
		Else 
			ACCEPT:C269
		End if 
		
End case 
//End Object Method: Button1