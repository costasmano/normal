If (False:C215)\
  //[PRJ_ProjectDetails];"ProjectDetails_LB".bAdd
	Mods_2007_CJMv2  //add window title
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 15:08:39)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v54  //r002 `11/20/07, 12:40:36`Fix display issues when new record is created
	// Modified by: costasmanousakis-(Designer)-(6/29/08 09:59:29)
	Mods_2008_CM_5404  //Added a redraw window at the end
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 19:08:13)
	Mods_2021_10
	//  `unload record at the end ; use LB_ResetHeaders
End if 

ut_SetWindowSize("create"; Current method name:C684)

CREATE SET:C116(Current form table:C627->; "PRJPREADDSET")
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.new")
ADD RECORD:C56([PRJ_ProjectDetails:115])

If (OK=1)
	CREATE EMPTY SET:C140([PRJ_ProjectDetails:115]; "PRJNEWADDEDREC")
	ADD TO SET:C119([PRJ_ProjectDetails:115]; "PRJNEWADDEDREC")
	UNION:C120("PRJPREADDSET"\
		; "PRJNEWADDEDREC"\
		; "PRJPREADDSET")
	USE SET:C118("PRJPREADDSET")
	//ut_SetSortColumns (7;0)
	ut_PRJSortByBridge
	LB_ResetHeaders("ProjectDetails_LB")
	//ut_SetSortColumns (7;1)
	
	HIGHLIGHT RECORDS:C656("PRJNEWADDEDREC")
	CLEAR SET:C117("PRJNEWADDEDREC")
End if 
CLEAR SET:C117("PRJPREADDSET")
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])

PRJ_DetailsNewrecord_b:=False:C215
//ut_ResizeWindow (Frontmost window;$currWinW_L;$CurrWin_H)
//REDRAW WINDOW
ut_SetWindowSize("Reset"; Current method name:C684)