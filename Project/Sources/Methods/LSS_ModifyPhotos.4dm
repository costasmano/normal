//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/04/14, 11:29:19
// ----------------------------------------------------
// Method: LSS_ModifyPhotos
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	Mods_2020_01_bug  //Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	
End if 
If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	C_LONGINT:C283($LBCol_L; LSS_SelectedRow_L)
	
	LISTBOX GET CELL POSITION:C971(*; "PHotos_LB"; $LBCol_L; LSS_SelectedRow_L)
	If (LSS_SelectedRow_L>0)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
		OBJECT GET COORDINATES:C663(*; "PHotos_LB"; $ol; $ot; $or; $ob)
		COPY NAMED SELECTION:C331([LSS_Photos:166]; "PhotoSet")
		
		GOTO SELECTED RECORD:C245([LSS_Photos:166]; LSS_SelectedRow_L)
		
		LSS_ControlModification(->[LSS_Photos:166]; "Input")
		UNLOAD RECORD:C212([LSS_Photos:166])
		InDoubleClick_B:=False:C215
		READ ONLY:C145([LSS_Photos:166])
		
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		//  `  `
		OBJECT GET COORDINATES:C663(*; "PHotos_LB"; $wl; $wt; $wr; $wb)
		//  `  `
		OBJECT MOVE:C664(*; "PHotos_LB"; 0; 0; $or-$wr; $ob-$wb)
		//  `  `
		OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)
		//  `  `
		OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
		LSS_GetImages
		//REDRAW([LSS_Photos]LSS_PhotoType_s)
		//REDRAW([LSS_Photos]LSS_Photo_txt)
		//REDRAW([LSS_Photos]LSS_PhotoSequence_L)
		
		OBJECT SET ENABLED:C1123(*; "SequenceNumberUpdate_1"; LSS_PhotoUpdateSeq_b)
		
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 

