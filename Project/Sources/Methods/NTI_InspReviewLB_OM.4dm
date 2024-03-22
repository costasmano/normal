//%attributes = {"invisible":true}
//Method: NTI_InspReviewLB_OM
//Description
// Object method for the ListBox in the Review Pending TIN inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/09/16, 16:56:50
	// ----------------------------------------------------
	//Created : 
	Mods_2016_09
	// Modified by: Costas Manousakis-(Designer)-(1/31/17 17:26:01)
	Mods_2017_01
	//  `use NTI_GetInspResp
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(4/17/18 17:44:06)
	Mods_2018_04
	//  `modify restore of window and LB when opening insp.
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_Header2_l:=1
		LB_Header1_l:=0
		LISTBOX SET TABLE SOURCE:C1013(*; "TunnelInspections_LB"; Table:C252(->[TIN_Inspections:184]))
	: (Form event code:C388=On Display Detail:K2:22)
		NTI_TININSPListBox_OM
		
	: (Form event code:C388=On Header Click:K2:40)
		
		TRACE:C157
		C_TEXT:C284($nameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $nameofObj_txt; $dumTbl_L; $dumFld_L)
		
		Case of 
				
			: ($nameofObj_txt="LB_Header2_l")
				If (Self:C308->>1)
					ORDER BY FORMULA:C300([TIN_Inspections:184]; NTI_SortByFormula(Self:C308->); >)
					COPY NAMED SELECTION:C331([TIN_Inspections:184]; "NTI_TunnelInspSet")
					LB_Header2_l:=1
				Else 
					ORDER BY FORMULA:C300([TIN_Inspections:184]; NTI_SortByFormula(Self:C308->); <)
					COPY NAMED SELECTION:C331([TIN_Inspections:184]; "NTI_TunnelInspSet")
					LB_Header2_l:=2
				End if 
				
			Else 
				COPY NAMED SELECTION:C331([TIN_Inspections:184]; "NTI_TunnelInspSet")
				USE NAMED SELECTION:C332("NTI_TunnelInspSet")
				CLEAR NAMED SELECTION:C333("NTI_TunnelInspSet")
		End case 
		$0:=-1
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($LBCol_L; $LBRow_L)
		
		LISTBOX GET CELL POSITION:C971(*; "TunnelInspections_LB"; $LBCol_L; $LBRow_L)
		If ($LBRow_L>0)
			If (Contextual click:C713)
				C_LONGINT:C283($Choise_L)
				C_TEXT:C284($PopUpMenu_txt; $InspResp_txt)
				C_BOOLEAN:C305($DBIEReq_b; $AreaReq_b)
				ARRAY TEXT:C222($DBIEGroups_atxt; 0)
				ARRAY TEXT:C222($AreaGroups_atxt; 0)
				
				READ ONLY:C145([TIN_Inspections:184])
				READ ONLY:C145([TunnelInfo:151])
				READ ONLY:C145([Bridge MHD NBIS:1])
				READ ONLY:C145([NTI_TunnelInfo:181])
				GOTO SELECTED RECORD:C245([TIN_Inspections:184]; $LBRow_L)
				LOAD RECORD:C52([TIN_Inspections:184])
				NTI_GetInspRequirements([TIN_Inspections:184]InspType:21; ->$DBIEReq_b; ->$AreaReq_b)
				$InspResp_txt:=""
				$InspResp_txt:=NTI_GetInspResp([TIN_Inspections:184]NTI_i1_S:1)
				NTI_GetReviewGroups($InspResp_txt; ->$DBIEGroups_atxt; ->$AreaGroups_atxt)
				C_BOOLEAN:C305($DBIEPriv_b; $AreaPRIV_b)
				
				$DBIEPriv_b:=(GRP_UserInGroupList(->$DBIEGroups_atxt)>0)
				$DBIEPriv_b:=$DBIEPriv_b | (<>CurrentUser_PID=[TIN_Inspections:184]DistrTnlInspEng:22)
				$AreaPRIV_b:=(GRP_UserInGroupList(->$AreaGroups_atxt)>0)
				$AreaPRIV_b:=$AreaPRIV_b | (<>CurrentUser_PID=[TIN_Inspections:184]DistrInspEng:12)
				
				C_BOOLEAN:C305(<>INSP_DBIE_b; <>INSP_AreaEng_b; $INSP_DBIE_b; $INSP_AreaEng_b)
				$INSP_DBIE_b:=<>INSP_DBIE_b
				$INSP_AreaEng_b:=<>INSP_AreaEng_b
				
				<>INSP_DBIE_b:=($DBIEPriv_b | User in group:C338(Current user:C182; "Design Access Group"))
				<>INSP_AreaEng_b:=($AreaPRIV_b | User in group:C338(Current user:C182; "Design Access Group"))
				$PopUpMenu_txt:="( ;Edit;Print;"  //Review;Duplicate"
				If (($DBIEReq_b & $DBIEPriv_b) | User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+"D.T.I.E. Review;"
				End if 
				If (($AreaReq_b & $AreaPRIV_b) | User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+"T.I.E. Review;"
				End if 
				If (User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+";Export"
				End if 
				ARRAY TEXT:C222($choices_atxt; 0)
				ut_TextToArray($PopUpMenu_txt; ->$choices_atxt; ";")
				$Choise_L:=Pop up menu:C542($PopUpMenu_txt)
				If ($Choise_L>1)
					GOTO SELECTED RECORD:C245([TIN_Inspections:184]; $LBRow_L)
					LOAD RECORD:C52([TIN_Inspections:184])
				End if 
				Case of 
					: ($choices_atxt{$Choise_L}="EDIT")
						
						C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $ww; $wh)
						GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
						$ww:=$wr-$wl
						$wh:=$wb-$wt
						OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $ol; $ot; $or; $ob)
						
						COPY NAMED SELECTION:C331([TIN_Inspections:184]; "TempTINInspList")
						NTI_OpenInspection
						
						If (Record number:C243([TIN_Inspections:184])>0)
							//find the row
							LISTBOX SELECT ROW:C912(*; "TunnelInspections_LB"; $LBRow_L; lk replace selection:K53:1)
							OBJECT SET SCROLL POSITION:C906(*; "TunnelInspections_LB"; $LBRow_L)
						Else 
							//deleted record
							ARRAY LONGINT:C221($RecordNumbers_aL; Records in selection:C76([TIN_Inspections:184]))
							SELECTION TO ARRAY:C260([TIN_Inspections:184]; $RecordNumbers_aL)
							C_LONGINT:C283($loop_L)
							For ($loop_L; Size of array:C274($RecordNumbers_aL); 1; -1)
								
								If ($RecordNumbers_aL{$loop_L}<=0)
									DELETE FROM ARRAY:C228($RecordNumbers_aL; $loop_L; 1)
								End if 
							End for 
							
							CREATE SELECTION FROM ARRAY:C640([TIN_Inspections:184]; $RecordNumbers_aL)
							ARRAY LONGINT:C221($RecordNumbers_aL; 0)
							
							LB_Tasks("DESELECTALL"; "TunnelInspections")
							LB_Tasks("SETWINDOWTITLE"; "TunnelInspections")
						End if 
						
						GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
						SET WINDOW RECT:C444($wl; $wt; $wl+$ww; $wt+$wh)
						OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $wl; $wt; $wr; $wb)
						OBJECT MOVE:C664(*; "TunnelInspections_LB"; 0; 0; $or-$wr; $ob-$wb)
						
					: ($choices_atxt{$Choise_L}="Print")
						C_BLOB:C604($ROState_x)
						C_BOOLEAN:C305($one_b; $many_b)
						GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
						SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
						$ROState_x:=ut_db_SaveROState
						READ ONLY:C145(*)
						NTI_ImageSortNeeded_b:=False:C215
						COPY NAMED SELECTION:C331([TIN_Inspections:184]; "TempTINInspList")
						NTI_PrintInspection
						ut_db_RestoreROState($ROState_x)
						USE NAMED SELECTION:C332("TempTINInspList")
						CLEAR NAMED SELECTION:C333("TempTINInspList")
						SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
						
					: ($choices_atxt{$Choise_L}="D.T.I.E. Review")
						<>INSP_AreaEng_b:=False:C215  // make sure turn off the area eng priv
						COPY NAMED SELECTION:C331([TIN_Inspections:184]; "TempTINInspList")
						NTI_DoReviewInspection
						USE NAMED SELECTION:C332("TempTINInspList")
						CLEAR NAMED SELECTION:C333("TempTINInspList")
						
					: ($choices_atxt{$Choise_L}="T.I.E. Review")
						<>INSP_DBIE_b:=False:C215  // make sure turn off the DBIE priv
						COPY NAMED SELECTION:C331([TIN_Inspections:184]; "TempTINInspList")
						NTI_DoReviewInspection
						USE NAMED SELECTION:C332("TempTINInspList")
						CLEAR NAMED SELECTION:C333("TempTINInspList")
						
					: ($choices_atxt{$Choise_L}="Export")
						NTI_ExportInspection
						
				End case 
				//TRACE
				REDRAW WINDOW:C456
				<>INSP_DBIE_b:=$INSP_DBIE_b
				<>INSP_AreaEng_b:=$INSP_AreaEng_b
				
			End if 
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($LBCol_L; $LBRow_L)
			
			LISTBOX GET CELL POSITION:C971(*; "TunnelInspections_LB"; $LBCol_L; $LBRow_L)
			If ($LBRow_L>0)
				//edit or open
				C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $ww; $wh)
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				$ww:=$wr-$wl
				$wh:=$wb-$wt
				OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $ol; $ot; $or; $ob)
				
				GOTO SELECTED RECORD:C245([TIN_Inspections:184]; $LBRow_L)
				LOAD RECORD:C52([TIN_Inspections:184])
				COPY NAMED SELECTION:C331([TIN_Inspections:184]; "TempTINInspList")
				NTI_OpenInspection
				
				USE NAMED SELECTION:C332("TempTINInspList")
				CLEAR NAMED SELECTION:C333("TempTINInspList")
				
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				SET WINDOW RECT:C444($wl; $wt; $wl+$ww; $wt+$wh)
				OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $wl; $wt; $wr; $wb)
				OBJECT MOVE:C664(*; "TunnelInspections_LB"; 0; 0; $or-$wr; $ob-$wb)
				
				REDRAW:C174(TunnelInspections_LB)
				
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 

//End NTI_InspReviewLB_OM