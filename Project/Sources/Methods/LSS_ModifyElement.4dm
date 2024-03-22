//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 08/21/14, 15:09:41
// ----------------------------------------------------
// Method: LSS_ModifyElement
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	
End if 
If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $LBCol_L)
	GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
	OBJECT GET COORDINATES:C663(*; "ElementRating_LB"; $ol; $ot; $or; $ob)
	OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
	
	LSS_SelectedRow_L:=0
	C_LONGINT:C283($row_l; $ID_L)
	
	//LSS_SelectedRow_L:=Find in array(ElementRating_LB;True)
	LISTBOX GET CELL POSITION:C971(*; "ElementRating_LB"; $LBCol_L; LSS_SelectedRow_L)
	If (LSS_SelectedRow_L>0)
		
		LSS_LoadElementInspectionRecord
		LSS_ControlModification(->[LSS_ElementInspection:163]; "Input")
		InDoubleClick_B:=False:C215
		LISTBOX SELECT ROW:C912(*; "ElementRating_LB"; LSS_SelectedRow_L)
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "ElementRating_LB"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "ElementRating_LB"; 0; 0; $or-$wr; $ob-$wb)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
	End if 
	InDoubleClick_B:=False:C215
End if 



