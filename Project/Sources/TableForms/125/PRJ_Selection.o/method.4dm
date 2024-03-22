// ----------------------------------------------------
// Form Method: PRJ_Selection.o
// User name (OS): cjmiller
// Date and time: 03/16/06, 16:15:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5303  //r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
End if 
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		<>PRJ_SelectedData_txt:=[TableOfLists:125]ListValue_s:2
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
		CANCEL:C270
End case 
//End Form Method: PRJ_Selection.o