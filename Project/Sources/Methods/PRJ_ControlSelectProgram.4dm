//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelectProgram
// User name (OS): cjmiller
// Date and time: 11/27/07, 11:27:53
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:27:54
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($search_txt)
$search_txt:=[PRJ_ProjectDetails:115]PRJ_Program_s:23+"@"
QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="Program")

QUERY SELECTION:C341([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$search_txt)

Case of 
	: (Records in selection:C76([TableOfLists:125])=1)
		OBJECT SET ENABLED:C1123(PRJ_Program_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		[PRJ_ProjectDetails:115]PRJ_Program_s:23:=[TableOfLists:125]ListValue_s:2
	: (Records in selection:C76([TableOfLists:125])>1)
		OBJECT SET ENABLED:C1123(PRJ_Program_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		C_LONGINT:C283(<>ProjectSelectionProcess_l)
		<>SelectionOption_txt:="Program"
		<>ProjectProcess_l:=Current process:C322
		<>PRJ_SelectedData_txt:=[PRJ_ProjectDetails:115]PRJ_Program_s:23
		PRJ_StartOrResumeProjSelection
		
	Else 
		OBJECT SET ENABLED:C1123(PRJ_Program_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End case 
//End PRJ_ControlSelectProgram