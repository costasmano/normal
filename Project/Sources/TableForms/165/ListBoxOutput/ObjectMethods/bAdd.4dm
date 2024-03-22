
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/02/14, 12:39:41
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory].ListBoxOutput.bAdd
// Description
// 
//
// Parameters
If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(2/15/15 22:08:29)
	Mods_2015_02
	//  `added code to cancel  transaction, and recall last set
	// ----------------------------------------------------
	
End if 
C_LONGINT:C283($Width_L; $Height_L)

CREATE SET:C116([LSS_Inventory:165]; "$LSSBeforeAdd")
//GET FORM PROPERTIES([LSS_Inventory];"New_InventoryItem";$Width_L;$Height_L)
//ut_OpenNewWindow ($Width_L;800;0;Plain window ;"Add New Inventory Item")
FORM SET INPUT:C55([LSS_Inventory:165]; "New_InventoryItem")
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inventory_LB"; $ol; $ot; $or; $ob)

ADD RECORD:C56([LSS_Inventory:165])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inventory_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "Inventory_LB"; 0; 0; $or-$wr; $ob-$wb)

If (OK=1)
	//Add to list
	C_TEXT:C284($lastID_added_txt)
	$lastID_added_txt:=[LSS_Inventory:165]LSS_InventoryId_s:1
	ADD TO SET:C119([LSS_Inventory:165]; "$LSSBeforeAdd")
	CREATE SET:C116([LSS_Inventory:165]; "InventorySet")
	USE SET:C118("$LSSBeforeAdd")
	LSS_SortInventory
	ARRAY TEXT:C222($allIDS_atxt; 0)
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $allIDS_atxt)
	C_LONGINT:C283($pos_L)
	$pos_L:=Find in array:C230($allIDS_atxt; $lastID_added_txt)
	OBJECT SET SCROLL POSITION:C906(*; "Inventory_LB"; $pos_L; *)
	//USE NAMED SELECTION("$LSSBeforeAdd")
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
Else 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
End if 
CLEAR SET:C117("$LSSBeforeAdd")
CLOSE WINDOW:C154
WIN_SetWindowTitle(->[LSS_Inventory:165])

