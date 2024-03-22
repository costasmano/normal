//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 08/28/14, 11:33:01
	// ----------------------------------------------------
	// Method: LSS_ModifySignPanels
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 11:33:42)
	Mods_2016_05_bug
	//  `order by Panel_S
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
End if 

If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	
	LISTBOX GET CELL POSITION:C971(*; "SignPanel_LB"; $LBCol_L; LSS_SelectedRow_L)
	If (LSS_SelectedRow_L>0)
		COPY NAMED SELECTION:C331([LSS_SignPanel:172]; "LSS_SignPanel")
		GOTO SELECTED RECORD:C245([LSS_SignPanel:172]; LSS_SelectedRow_L)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		
		LSS_ControlModification(->[LSS_SignPanel:172]; "Input")
		InDoubleClick_B:=False:C215
		QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_Panel_s:3; >)
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
		REDRAW:C174([LSS_SignPanel:172]LSS_PanelType_s:7)
		REDRAW:C174([LSS_SignPanel:172]LSS_Panel_s:3)
		REDRAW:C174([LSS_SignPanel:172]LSS_Width_s:4)
		REDRAW:C174([LSS_SignPanel:172]LSS_PanelMessage_txt:6)
		REDRAW:C174([LSS_SignPanel:172]LSS_LanesPanelOver_txt:8)
		REDRAW:C174([LSS_SignPanel:172]LSS_SignPanelId_s:1)
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 
