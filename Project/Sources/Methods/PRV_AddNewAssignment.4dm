//%attributes = {"invisible":true}
//Method: PRV_AddNewAssignment
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/11/13, 08:22:37
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
CREATE SET:C116([Contract_Assignment_Maintenance:101]; "PRV_PREADDRECORD")
FORM SET INPUT:C55([Contract_Assignment_Maintenance:101]; "PreservationInput")
PRV_Variables("INIT")
CREATE RECORD:C68([Contract_Assignment_Maintenance:101])
Inc_Sequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)
C_LONGINT:C283($WinID_L)
$WinID_L:=Open form window:C675([Contract_Assignment_Maintenance:101]; "PRVAddAssignment")
DIALOG:C40([Contract_Assignment_Maintenance:101]; "PRVAddAssignment")
CLOSE WINDOW:C154($WinID_L)
If (OK=1)
	SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
	ut_LoadRecord(->[Contract_Assignment_Maintenance:101])
	MODIFY RECORD:C57([Contract_Assignment_Maintenance:101])
	If (OK=1)
		C_LONGINT:C283($CurrRecID_L; $RecOrder_L)
		ADD TO SET:C119([Contract_Assignment_Maintenance:101]; "PRV_PREADDRECORD")
		$CurrRecID_L:=Record number:C243([Contract_Assignment_Maintenance:101])
		USE SET:C118("PRV_PREADDRECORD")
		ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("BDEPT"); >)
		LB_SetWindowTitle  //this one clears the SelectedRecordsSet
		LB_ClearHeaders
		ARRAY LONGINT:C221($AllRecIDs_aL; Records in selection:C76([Contract_Assignment_Maintenance:101]))
		SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]; $AllRecIDs_aL)
		$RecOrder_L:=Find in array:C230($AllRecIDs_aL; $CurrRecID_L)
		ARRAY LONGINT:C221($AllRecIDs_aL; 0)
		GOTO SELECTED RECORD:C245([Contract_Assignment_Maintenance:101]; $RecOrder_L)
		LISTBOX SELECT ROW:C912(*; "SelectListBox"; Selected record number:C246([Contract_Assignment_Maintenance:101]); lk replace selection:K53:1)
		ADD TO SET:C119([Contract_Assignment_Maintenance:101]; "SelectedRecordsSet")
		OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; Selected record number:C246([Contract_Assignment_Maintenance:101]))
		REDRAW:C174(SelectListBox)
	End if 
	
End if 

CLEAR SET:C117("PRV_PREADDRECORD")
//End PRV_AddNewAssignment