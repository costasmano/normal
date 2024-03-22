// ----------------------------------------------------
// Form Method: PRJ_FileSelection_LB
// User name (OS): cjmiller
// Date and time: 03/31/06, 14:51:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5302  //r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
	// Modified by: costasmanousakis-(Designer)-(11/19/07 15:53:27)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(1/24/08 09:29:41)
	Mods_2007_CM_5401
	//  `Added field  [PRJ_ProjectFile]PF_Description_txt; resized existing fields; text alignments;
	//  `made form resizable so that more of the descri field can be seen; added sort by filenumber to the
	//  `show all, show subset, query buttons; changed the show all button to show only filenumbers > 0.
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		C_LONGINT:C283($Col_L; $Row_L)
		LISTBOX GET CELL POSITION:C971(*; "PRJ_Selection_LB"; $Col_L; $Row_L)
		GOTO SELECTED RECORD:C245([PRJ_ProjectFile:117]; $Row_L)
		
		<>PRJ_SelectedData_txt:=String:C10([PRJ_ProjectFile:117]PF_FileID_l:1)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		//HIDE PROCESS(Current process)
		//PAUSE PROCESS(Current process)
		CANCEL:C270
End case 
//End Form Method: PRJ_Selection.o