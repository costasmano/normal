
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/23/14, 15:22:36
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory].Input.LSS_Edit_L
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //  `Make sure lss records are in correct read/write or read only state
	//Reset window stuff
	//Modified by: administrator (11/12/15 16:57:01)
	// Modified by: Costas Manousakis-(Designer)-(2024-03-08 17:03:54)
	Mods_2024_LSS_1
	//  `unload and reload LSS_inventory record on exit from the inspection to update any changes to cycle and next sched date
	//  `added sorting of inspections by date to update the list and account if inspection has been deleted
End if 
If (Modified record:C314([LSS_Inventory:165]))
	FM_SaveInventoryInput
Else 
	CANCEL TRANSACTION:C241
End if 
C_LONGINT:C283($Width_L; $Height_L)

C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $ol; $ot; $or; $ob)

//start of Mods_2024_LSS_1
//get current insp id - use it to find position after sorting
C_TEXT:C284($inspID_txt)
$inspID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
//end of Mods_2024_LSS_1

C_TEXT:C284($InputForm_txt)

LSS_SelectInpsectionInputForm(->$InputForm_txt; ->LSS_InspectionRow_L)
LSS_DisplayInspection($InputForm_txt)
LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))

SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "Inspection_LB"; 0; 0; $or-$wr; $ob-$wb)
UNLOAD RECORD:C212([LSS_Inspection:164])
READ ONLY:C145([LSS_Inspection:164])

LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; [LSS_Inspection:164]LSS_Complete_b:39)
REDRAW:C174(Inspection_LB)

OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)

//start of Mods_2024_LSS_1
UNLOAD RECORD:C212([LSS_Inventory:165])
LOAD RECORD:C52([LSS_Inventory:165])

ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionDate_d:4; <)
ARRAY TEXT:C222($Ids_atxt; 0)
SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $Ids_atxt)
LSS_InspectionRow_L:=Find in array:C230($Ids_atxt; $inspID_txt)

If (LSS_InspectionRow_L>0)
	LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
	OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
Else 
	// inspection was deleted
	LISTBOX SELECT ROW:C912(*; "Inspection_LB"; 0; lk remove from selection:K53:3)
End if 
//end of Mods_2024_LSS_1