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
		CANCEL:C270
End case 

//End Object Method: Button1