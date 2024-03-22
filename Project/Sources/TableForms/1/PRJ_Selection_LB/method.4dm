// ----------------------------------------------------
// Form Method: PRJ_Selection.o
// User name (OS): cjmiller
// Date and time: 03/09/06, 16:24:35
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 16:32:34)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5302  //r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
	// Modified by: costasmanousakis-(Designer)-(11/21/07 11:56:50)
	Mods_2007_CM_5401
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		If (<>ProjectProcess_l>0)
			C_LONGINT:C283($Col_L; $Row_L)
			LISTBOX GET CELL POSITION:C971(*; "PRJ_BridgeSelection_LB"; $Col_L; $Row_L)
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Row_L)
			
			<>PRJ_SelectedData_txt:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			ACCEPT:C269
		Else 
			USE SET:C118("UserSet")
			ACCEPT:C269
		End if 
		
End case 
//End Form Method: PRJ_Selection.o