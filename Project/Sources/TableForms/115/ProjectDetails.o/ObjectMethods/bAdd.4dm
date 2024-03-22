If (False:C215)
	Mods_2007_CJMv2  //add window title
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 15:08:39)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v54  //r002 `11/20/07, 12:40:36`Fix display issues when new record is created
	// Modified by: costasmanousakis-(Designer)-(6/29/08 09:59:29)
	Mods_2008_CM_5404  //Added a redraw window at the end
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
CREATE SET:C116(Current form table:C627->; "PRJPREADDSET")

FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.new")
ADD RECORD:C56([PRJ_ProjectDetails:115])
If (OK=1)
	CREATE EMPTY SET:C140([PRJ_ProjectDetails:115]; "PRJNEWADDEDREC")
	ADD TO SET:C119([PRJ_ProjectDetails:115]; "PRJNEWADDEDREC")
	UNION:C120("PRJPREADDSET"; "PRJNEWADDEDREC"; "PRJPREADDSET")
	USE SET:C118("PRJPREADDSET")
	ut_SetSortColumns(7; 0)
	ut_PRJSortByBridge
	ut_SetSortColumns(7; 1)
	
	HIGHLIGHT RECORDS:C656("PRJNEWADDEDREC")
	//CLEAR SET("PRJNEWADDEDREC")
End if 
CLEAR SET:C117("PRJPREADDSET")
C_LONGINT:C283($Width_l; $Height_l)
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "ProjectDetails.o"; $Width_l; $Height_l)
ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])
PRJ_DetailsNewrecord_b:=False:C215
ut_ResizeWindow(Frontmost window:C447; $Width_l; 600)
REDRAW WINDOW:C456