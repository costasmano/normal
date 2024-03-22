
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
