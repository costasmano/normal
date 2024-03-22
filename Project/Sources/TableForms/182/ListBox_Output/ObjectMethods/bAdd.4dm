//Method: [NTI_ELEM_DEFS].ListBox_Output.bAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/14/17, 14:54:02
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//

CREATE SET:C116([NTI_ELEM_DEFS:182]; "BeforeAdd")
//GET FORM PROPERTIES([LSS_Inventory];"New_InventoryItem";$Width_L;$Height_L)
//ut_OpenNewWindow ($Width_L;800;0;Plain window ;"Add New Inventory Item")
FORM SET INPUT:C55([NTI_ELEM_DEFS:182]; "Input")
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $LBCol_L; $LBRow_L)

GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "NTI_Elements_LB"; $ol; $ot; $or; $ob)
LISTBOX GET CELL POSITION:C971(*; "NTI_Elements_LB"; $LBCol_L; $LBRow_L)
If ($LBRow_L<1)
	$LBRow_L:=1
End if 
ADD RECORD:C56([NTI_ELEM_DEFS:182])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "NTI_Elements_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "NTI_Elements_LB"; 0; 0; $or-$wr; $ob-$wb)

If (OK=1)
	//Add to list
	
	LISTBOX SELECT ROW:C912(*; "NTI_Elements_LB"; LBRow_L)
	
	OBJECT SET SCROLL POSITION:C906(*; "NTI_Elements_LB"; LBRow_L; *)
	
Else 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	LISTBOX SELECT ROW:C912(*; "NTI_Elements_LB"; $LBRow_L)
	
	OBJECT SET SCROLL POSITION:C906(*; "NTI_Elements_LB"; $LBRow_L; *)
	
End if 
CLEAR SET:C117("BeforeAdd")

WIN_SetWindowTitle(->[NTI_ELEM_DEFS:182])
//End [NTI_ELEM_DEFS].ListBox_Output.bAdd