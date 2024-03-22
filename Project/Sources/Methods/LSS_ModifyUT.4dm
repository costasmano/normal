//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/04/14, 14:04:12
// ----------------------------------------------------
// Method: LSS_ModifyUT
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
	C_LONGINT:C283($LBCol_L; LSS_UTRow_L)
	
	LISTBOX GET CELL POSITION:C971(*; "UT_LB"; $LBCol_L; LSS_UTRow_L)
	If (LSS_UTRow_L>0)
		
		InDoubleClick_B:=True:C214
		GOTO SELECTED RECORD:C245([LSS_UT:175]; LSS_UTRow_L)
		//C_LONGINT($wl;$wt;$wr;$wb;$ol;$ot;$or;$ob;$olt;$ott;$ort;$obt;$olr;$otr;$orr;$obr)
		//GET WINDOW RECT($wl;$wt;$wr;$wb)
		//GET OBJECT RECT(*;"UT_LB";$ol;$ot;$or;$ob)
		//GET OBJECT RECT(*;"UTResults_LB";$olr;$otr;$orr;$obr)
		
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		
		LSS_ControlModification(->[LSS_UT:175]; "Input")
		InDoubleClick_B:=False:C215
		QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		//$Ow_L:=$wr-$wl
		//$OH_L:=$wb-$wT
		//GET WINDOW RECT($nwl;$nwt;$wnr;$nwb)
		//$Nw_L:=$wnr-$nwl
		//$NH_L:=$nwb-$nwt
		//RESIZE FORM WINDOW($Ow_L-$Nw_L;$OH_L-$NH_L)
		
		//SET WINDOW RECT($wl;$wt;$wr;$wb)
		//GET OBJECT RECT(*;"UT_LB";$wl;$wt;$wr;$wb)
		//
		//MOVE OBJECT(*;"UT_LB";0;0;$or-$wr;$ob-$wb)
		//
		//GET OBJECT RECT(*;"UTResults_LB";$wl;$wt;$wr;$wb)
		//MOVE OBJECT(*;"UTResults_LB";0;0;$orr-$wr;$obr-$wb)
		
		//OBJECT GET COORDINATES(*;"LSS_InpectionTabs_as";$wl;$wt;$wr;$wb)
		
		//OBJECT MOVE(*;"LSS_InpectionTabs_as";0;0;$ort-$wr;$obt-$wb)
		REDRAW:C174([LSS_UT:175]LSS_TechnicianName_s:3)
		REDRAW:C174([LSS_UT:175]LSS_MachineTypeSerialNo_s:8)
		REDRAW:C174([LSS_UT:175]LSS_AnchorRodDiameter_s:5)
		REDRAW:C174([LSS_UT:175]LSS_AnchorRodLength_s:6)
		REDRAW:C174([LSS_UT:175]LSS_CouplantMfgrAndGrade_s:14)
		LISTBOX SELECT ROW:C912(*; "UT_LB"; 0; 2)
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 