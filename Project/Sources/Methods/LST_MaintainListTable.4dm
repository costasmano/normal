//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// LST_MaintainListTable
	// User name (OS): cjmiller
	// Date and time: 01/10/06, 14:48:17
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2022_05  //Add List box option
End if 
ARRAY TEXT:C222(ListNames_atxt; 0)
vsForward:=<>Forward
C_TEXT:C284(SelectedListName_s)  // Command Replaced was o_C_STRING length was 31

READ ONLY:C145(*)
READ WRITE:C146([TableOfLists:125])
SelectedListName_s:="TOLRecords"
ALL RECORDS:C47([TableOfLists:125])
CREATE SET:C116([TableOfLists:125]; SelectedListName_s)

DISTINCT VALUES:C339([TableOfLists:125]ListName_s:1; ListNames_atxt)
INSERT IN ARRAY:C227(ListNames_atxt; 1; 1)
ListNames_atxt{1}:="New"
FORM SET INPUT:C55([TableOfLists:125]; "TableOfLists.i")
FORM SET OUTPUT:C54([TableOfLists:125]; "TableOFLists.o")
NewWindow(874; 600; 0; 0; "List Maintenance")
SET MENU BAR:C67(3)
ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListName_s:1; >; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
UNLOAD RECORD:C212([TableOfLists:125])
If (ut_UseListBox(Current method name:C684))
	DIALOG:C40([TableOfLists:125]; "Output_LB")
Else 
	MODIFY SELECTION:C204([TableOfLists:125])
End if 


//End LST_MaintainListTable