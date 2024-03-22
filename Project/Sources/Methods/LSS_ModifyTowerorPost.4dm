//%attributes = {"invisible":true}
// Method: LSS_ModifyTowerorPost
// Description
// 
//
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 08/28/14, 15:52:24
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:51:32)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_TowerDistance];[LSS_TowerDistance]LSS_TowerOrPost_txt;>;[LSS_TowerDistance]LSS_SignPanel_s;>)
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 17:12:15)
	Mods_2016_11
	//  `added  declaration of  "LSS_TowerDistance" selection
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	
	LISTBOX GET CELL POSITION:C971(*; "TowerOrPost_LB"; $LBCol_L; $LBRow_L)
	If ($LBRow_L>0)
		COPY NAMED SELECTION:C331([LSS_SignPanel:172]; "LSS_TowerDistance")
		
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		
		GOTO SELECTED RECORD:C245([LSS_TowerDistance:174]; $LBRow_L)
		LSS_ControlModification(->[LSS_TowerDistance:174]; "Input")
		InDoubleClick_B:=False:C215
		QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_TowerOrPost_txt:3; >; [LSS_TowerDistance:174]LSS_SignPanel_s:4; >)
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
		REDRAW:C174([LSS_TowerDistance:174]LSS_TowerOrPost_txt:3)
		REDRAW:C174([LSS_TowerDistance:174]LSS_SignPanel_s:4)
		REDRAW:C174([LSS_TowerDistance:174]LSS_Distance_txt:5)
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 
