If (False:C215)
	Mods_2007_CJMv2  //add window title
	// Modified by: costasmanousakis-(Designer)-(6/16/08 12:38:28)
	Mods_2008_CM_5403  //resort after delete
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($n)
$n:=Records in set:C195("UserSet")
If ($n=0)
	ALERT:C41("There are no selected records.")
Else 
	If ($n=1)
		CONFIRM:C162("Do you really want to delete this record?")
	Else 
		CONFIRM:C162("Do you really want to delete these "+String:C10($n)+" record?")
	End if 
	If (OK=1)
		CREATE SET:C116(Current form table:C627->; "saved")
		COPY SET:C600("UserSet"; "GlobSet")
		DIFFERENCE:C122("saved"; "GlobSet"; "saved")
		USE SET:C118("UserSet")
		DELETE SELECTION:C66(Current form table:C627->)
		USE SET:C118("saved")
		CLEAR SET:C117("saved")
		CLEAR SET:C117("GlobSet")
	End if 
End if 
ut_SetSortColumns(7; 0)
ut_PRJSortByBridge
ut_SetSortColumns(7; 1)
ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])