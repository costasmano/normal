If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/1/09 20:44:15)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 

POPUPMENUC(->PT_Scope_atxt; ->PT_Scope_atxt; ->PRJ_PT_Scope_s)
If (Form event code:C388=On Clicked:K2:4)
	GOTO OBJECT:C206(PRJ_PT_Hours_r)
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
End if 