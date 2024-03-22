If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/21/07 12:00:35)
	Mods_2007_CM_5401
End if 

If (<>ProjectProcess_l>0)
	<>PRJ_SelectedData_txt:=""
	POST OUTSIDE CALL:C329(<>ProjectProcess_l)
	ACCEPT:C269
	//HIDE PROCESS(Current process)
	//PAUSE PROCESS(Current process)
Else 
	CANCEL:C270
End if 