//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/23/15, 17:03:51
//----------------------------------------------------
//Method: LSS_ControlDmeterModification
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/23/15 17:03:52)
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:08:38)
	Mods_2016_05_bug
	//  `sort order for DMeter should be by location
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 13:13:28)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
C_LONGINT:C283($LBCol_L)

If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	LISTBOX GET CELL POSITION:C971(*; "DMeter_LB"; $LBCol_L; LSS_SelectedRow_L)
	If (LSS_SelectedRow_L>0)
		
		GOTO SELECTED RECORD:C245([LSS_DMeter:161]; LSS_SelectedRow_L)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "DMeter_LB"; $ol; $ot; $or; $ob)
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		LSS_ControlModification(->[LSS_DMeter:161]; "Input")
		InDoubleClick_B:=False:C215
		QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterDate_d:9; >; [LSS_DMeter:161]LSS_Location_s:3; >)
		
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "DMeter_LB"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "DMeter_LB"; 0; 0; $or-$wr; $ob-$wb)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
		REDRAW:C174([LSS_DMeter:161]LSS_DMeterDate_d:9)
		REDRAW:C174([LSS_DMeter:161]LSS_Location_s:3)
		REDRAW:C174([LSS_DMeter:161]LSS_A_s:4)
		REDRAW:C174([LSS_DMeter:161]LSS_B_s:5)
		REDRAW:C174([LSS_DMeter:161]LSS_C_s:6)
		REDRAW:C174([LSS_DMeter:161]LSS_D_s:7)
		REDRAW:C174([LSS_DMeter:161]LSS_Reference_s:8)
		
	End if 
	
Else 
	InDoubleClick_B:=False:C215
End if 
//End LSS_ControlDmeterModification