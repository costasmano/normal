//%attributes = {"invisible":true}
// Method: LSS_ModifyVerticalClearance
// Description
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 08/28/14, 15:27:56
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:50:22)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_VerticalClearance];[LSS_VerticalClearance]LSS_Panel_txt;>)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	
End if 
If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	
	LISTBOX GET CELL POSITION:C971(*; "VerticalClearance_LB"; $LBCol_L; $LBRow_L)
	If ($LBRow_L>0)
		GOTO SELECTED RECORD:C245([LSS_VerticalClearance:177]; $LBRow_L)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		
		LSS_ControlModification(->[LSS_VerticalClearance:177]; "Input")
		InDoubleClick_B:=False:C215
		QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_Panel_txt:3; >)
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
		REDRAW:C174([LSS_VerticalClearance:177]LSS_Panel_txt:3)
		REDRAW:C174([LSS_VerticalClearance:177]LSS_Feet_L:4)
		REDRAW:C174([LSS_VerticalClearance:177]LSS_Inches_L:5)
		REDRAW:C174([LSS_VerticalClearance:177]LSS_Meters_r:6)
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 
