// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 02/15/07, 14:18:17
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
If ([Conslt_Name:127]SQL_VendorID_l:3=0)
	
	
	CONFIRM:C162("Delete "+[Conslt_Name:127]ConsultantName_s:2+" record")
	
	If (OK=1)
		DELETE RECORD:C58([Conslt_Name:127])
		
	End if 
End if 

//End Object Method: Button1