//%attributes = {"invisible":true}
//Method: NTI_TININSPListBox_OM
//Description
//object method for the Inspection Listbox for a TIN
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/05/16, 10:35:03
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 12:51:51)
	Mods_2016_08_bug
	//  `added code to reset window and listbox size
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 13:11:52)
	Mods_2016_09
	//  `on Right Click build the popup menu dynamically
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	Mods_2018_01  //Add inspection type to the list box
	//Modified by: Chuck Miller (1/11/18 13:34:42)
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 14:43:44)
	Mods_2018_04
	//  `refine who is allowed to make a duplicate ; use NTI_GetInspResp
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 17:57:23)
	Mods_2018_04
	//  `use DOM tree NTI_INSPREQUIREMENTSTREE_txt
	// Modified by: Costas Manousakis-(Designer)-(4/17/18 17:26:24)
	Mods_2018_04
	//  `restore window dims and lb size when exiting inspection
	// Modified by: Costas Manousakis-(Designer)-(2024-02-12 13:59:24)
	Mods_2024_02
	//  `added initialization of TINInspCommentTypes_atxt before printing inspection
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
		NTI_INIT
		NTI_SETARRAYS
		
	: (Form event code:C388=On Display Detail:K2:22)
		LB_Detail1_txt:=""
		LB_Detail1_txt:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
		
		C_TEXT:C284($elemref_txt; $elemName_txt)
		LB_Detail2_txt:=""
		If ([TIN_Inspections:184]InspType:21#"")
			C_TEXT:C284($prevErrHandler_txt)
			$prevErrHandler_txt:=Method called on error:C704
			ON ERR CALL:C155("XMLErrorHandler")
			$elemref_txt:=ut_DOM_FindElmtRef(NTI_INSPREQUIREMENTSTREE_txt; "NTI_INSPREQ/INSPTYPE"; ->[TIN_Inspections:184]InspType:21)
			DOM GET XML ATTRIBUTE BY NAME:C728($elemref_txt; "Name"; LB_Detail2_txt)
			ON ERR CALL:C155($prevErrHandler_txt)
		End if 
		
		C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
		C_PICTURE:C286(LB_Detail9_pct; LB_Detail10_pct; LB_Detail11_pct)
		vTmLeader:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]TeamLeader:11)
		Case of 
			: ([TIN_Inspections:184]InspReview:5=0)
				LB_Detail10_pct:=LB_Detail10_pct*0
			: ([TIN_Inspections:184]InspReview:5=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail10_pct)
			: ([TIN_Inspections:184]InspReview:5=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail10_pct)
				
		End case 
		
		Case of 
			: ([TIN_Inspections:184]InspApproval:6=0)
				LB_Detail11_pct:=LB_Detail11_pct*0
			: ([TIN_Inspections:184]InspApproval:6=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail11_pct)
			: ([TIN_Inspections:184]InspApproval:6=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail11_pct)
				
		End case 
		If ([TIN_Inspections:184]Complete:4)
			GET PICTURE FROM LIBRARY:C565("Mark_on"; LB_Detail9_pct)
		Else 
			GET PICTURE FROM LIBRARY:C565("Mark_Off"; LB_Detail9_pct)
		End if 
		//LB_Detail1_txt:=[TIN_Inspections]InspType
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($LBCol_L; $LBRow_L)
		
		LISTBOX GET CELL POSITION:C971(*; "TunnelInspections_LB"; $LBCol_L; $LBRow_L)
		C_LONGINT:C283($Choise_L)
		C_TEXT:C284($PopUpMenu_txt; $InspResp_txt)
		
		If ($LBRow_L>0)
			If (Contextual click:C713)
				C_BOOLEAN:C305($DBIEReq_b; $AreaReq_b)
				ARRAY TEXT:C222($DBIEGroups_atxt; 0)
				ARRAY TEXT:C222($AreaGroups_atxt; 0)
				
				READ ONLY:C145([TIN_Inspections:184])
				READ ONLY:C145([TunnelInfo:151])
				READ ONLY:C145([NTI_TunnelInfo:181])
				READ ONLY:C145([Bridge MHD NBIS:1])
				GOTO SELECTED RECORD:C245([TIN_Inspections:184]; $LBRow_L)
				LOAD RECORD:C52([TIN_Inspections:184])
				
				NTI_GetInspRequirements([TIN_Inspections:184]InspType:21; ->$DBIEReq_b; ->$AreaReq_b)
				
				$InspResp_txt:=""
				//first check [NTI_TunnelInfo] - record should be loaded
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
				
				<>INSP_DBIE_b:=$DBIEPriv_b
				<>INSP_AreaEng_b:=$AreaPRIV_b
				
				$PopUpMenu_txt:="( ;Edit;Print;"  //Review;Duplicate"
				If (($DBIEReq_b & $DBIEPriv_b) | User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+"D.T.I.E. Review;"
				End if 
				If (($AreaReq_b & $AreaPRIV_b) | User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+"T.I.E. Review;"
				End if 
				If ((([TIN_Inspections:184]InspApproval:6=BMS Approved) & NTI_AllowAdd_Tin_insp) | User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+"Duplicate;"
				End if 
				If (User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=$PopUpMenu_txt+";Export;Import"
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
						
						NTI_OpenInspection
						NTI_ListTIN_Inspections
						
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
						READ ONLY:C145([TIN_Inspections:184])
						READ ONLY:C145([TIN_Insp_Images:186])
						READ ONLY:C145([TIN_Insp_TmMembers:187])
						READ ONLY:C145([NTI_ELEM_TIN_INSP:185])
						NTI_ImageSortNeeded_b:=False:C215
						
						// start of mods_2024_02
						ARRAY TEXT:C222(TINInspCommentTypes_atxt; 0)
						Begin SQL
							select
							[TableOfLists].[ListValue_s],
							[TableOfLists].[ListSequence_l]
							from
							[TableOfLists]
							
							where
							[TableOfLists].[ListName_s]='TIN_CommentTypes'
							ORDER BY 2 ASC
							into
							:TINInspCommentTypes_atxt;
						End SQL
						If ([TIN_Inspections:184]InspType:21="ZDA")  //damage
						Else 
							//do not use Damage comment type
							C_LONGINT:C283($Pos_L)
							$Pos_L:=Find in array:C230(TINInspCommentTypes_atxt; "@DAM@")
							If ($Pos_L>0)
								DELETE FROM ARRAY:C228(TINInspCommentTypes_atxt; $Pos_L; 1)
							End if 
						End if 
						// end of mods_2024_02
						
						NTI_PrintInspection
						NTI_ListTIN_Inspections
						ut_db_RestoreROState($ROState_x)
						SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
						
					: ($choices_atxt{$Choise_L}="D.T.I.E. Review")
						NTI_DoReviewInspection
						NTI_ListTIN_Inspections
					: ($choices_atxt{$Choise_L}="T.I.E. Review")
						NTI_DoReviewInspection
						NTI_ListTIN_Inspections
						
					: ($choices_atxt{$Choise_L}="Duplicate")
						NTI_DuplicateInspection
						NTI_ListTIN_Inspections
						
					: ($choices_atxt{$Choise_L}="Export")
						NTI_ExportInspection
					: ($choices_atxt{$Choise_L}="Import")
						NTI_ImportInspection
						NTI_ListTIN_Inspections
						
				End case 
				//TRACE
				REDRAW WINDOW:C456
				<>INSP_DBIE_b:=$INSP_DBIE_b
				<>INSP_AreaEng_b:=$INSP_AreaEng_b
				
			End if 
		Else 
			//allow Import for designer on contextual click
			If (Contextual click:C713)
				If (User in group:C338(Current user:C182; "Design Access Group"))
					$PopUpMenu_txt:=" ;Import"
					$Choise_L:=Pop up menu:C542($PopUpMenu_txt)
					If ($Choise_L=2)
						NTI_ImportInspection
						NTI_ListTIN_Inspections
						
					End if 
				End if 
				
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
				NTI_OpenInspection
				
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				SET WINDOW RECT:C444($wl; $wt; $wl+$ww; $wt+$wh)
				OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $wl; $wt; $wr; $wb)
				OBJECT MOVE:C664(*; "TunnelInspections_LB"; 0; 0; $or-$wr; $ob-$wb)
				
				NTI_ListTIN_Inspections
				REDRAW:C174(TunnelInspections_LB)
				InDoubleClick_B:=False:C215
			Else 
				InDoubleClick_B:=False:C215
			End if 
		End if 
		
End case 

//End NTI_TININSPListBox_OM