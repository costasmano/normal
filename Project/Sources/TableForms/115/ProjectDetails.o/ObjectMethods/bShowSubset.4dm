If (False:C215)
	Mods_2007_CJMv2  //add window title
	// Modified by: costasmanousakis-(Designer)-(6/20/2007 09:25:29)
	Mods_2007_CM12_5301
End if 
USE SET:C118("UserSet")
SET CURSOR:C469(4)
ut_SetSortColumns(7; 0)
ut_PRJSortByBridge
ut_SetSortColumns(7; 1)
ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])