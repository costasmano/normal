
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 15:23:18
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.LSS_Approved_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	// Modified by: Costas Manousakis-(Designer)-(12/14/15 12:35:33)
	Mods_2015_12_bug
	//  `Set window title to "inspection review" when opening review dialog.
	
End if 
If (Modified record:C314([LSS_Inventory:165]))
	FM_SaveInventoryInput
Else 
	CANCEL TRANSACTION:C241
End if 
START TRANSACTION:C239  //start a new transaction  for the review
C_LONGINT:C283($Width_L; $Height_L)

C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $ol; $ot; $or; $ob)

FORM GET PROPERTIES:C674("LSS_InspectionApproval"; $Width_L; $Height_L)


InitChangeStack(1)  //[LSS_Inspection]
C_LONGINT:C283($LBCol_L; $Choice_L)
LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; LSS_InspectionRow_L)

If (LSS_InspectionRow_L>0)
	C_TEXT:C284($InputForm_txt)
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; LSS_InspectionRow_L)
	C_BOOLEAN:C305($Display_B)
	$Display_B:=True:C214
	If ([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)
		CONFIRM:C162("This inspection has already been approved on "+String:C10([LSS_Inspection:164]LSS_ApprovedDate_d:44; Internal date short:K1:7)+Char:C90(Carriage return:K15:38)+"Do you want to preform the Review again?"; "Yes"; "No")
		$Display_B:=(OK=1)
	End if 
	If ($Display_B)
		$Choice_L:=ut_LoadRecordInteractiveV2(->[LSS_Inspection:164])
		If ($Choice_L=1)
			LSS_Page_l:=1
			SET WINDOW TITLE:C213("Inspection Review")
			DIALOG:C40("LSS_InspectionApproval")
			START TRANSACTION:C239  //Once Review completed start a new trans because we are still in the Inv input form
			SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
			OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $wl; $wt; $wr; $wb)
			UNLOAD RECORD:C212([LSS_Inspection:164])
			READ ONLY:C145([LSS_Inspection:164])
			
			OBJECT MOVE:C664(*; "Inspection_LB"; 0; 0; $or-$wr; $ob-$wb)
			WIN_SetWindowTitle(->[LSS_Inventory:165])
		Else 
			ALERT:C41("Could not load Inspection record!  You have to try again later.")
		End if 
	End if 
End if 

LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))
REDRAW:C174(Inspection_LB)
LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; [LSS_Inspection:164]LSS_Complete_b:39)

//End Object Method: [LSS_Inventory].Input.LSS_Approved_L

