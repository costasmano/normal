//Method: [Inspections];"InspectionReview_LB".InspectionReview
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/25/19, 15:21:25
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07  //replace inspection review with a list box 
	//Modified by: Chuck Miller (7/25/19 15:23:20)
	// Modified by: Costas Manousakis-(Designer)-(3/17/21 14:02:51)
	Mods_2021_03
	//  `added Redraw of the listbox after the double click event
End if 
//
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($column_l; $row_l)
			LISTBOX GET CELL POSITION:C971(*; "InspectionReview"; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76([Inspections:27]))
				InDoubleClick_B:=False:C215
			Else 
				
				READ ONLY:C145([Bridge MHD NBIS:1])
				C_LONGINT:C283(vlInspRevWWid; vlInspRevWHt)
				C_LONGINT:C283($vlLeft; $vlTop; $vlRight; $vlBot; $LB_Left; $LBTop; $LBRight; $LBBot; \
					$Buttonleft; $ButtonTop; $ButtonRight; $buttonBot; $ButtonNewTop)
				OBJECT GET COORDINATES:C663(*; "InspectionReview"; $LB_Left; $LBTop; $LBRight; $LBBot)
				OBJECT GET COORDINATES:C663(*; "@Button"; $Buttonleft; $ButtonTop; $ButtonRight; $buttonBot)
				
				GET WINDOW RECT:C443($vlLeft; $vlTop; $vlRight; $vlBot)
				vlInspRevWWid:=$vlRight-$vlLeft
				vlInspRevWHt:=$vlBot-$vlTop
				$vlRight:=$vlLeft+740
				$vlBot:=$vlTop+600
				If ($vlRight>(Screen width:C187-5))
					$vlLeft:=Screen width:C187-740-5
					If ($vlLeft<1)
						$vlLeft:=1
					End if 
					$vlRight:=Screen width:C187-5
				End if 
				If ($vlBot>(Screen height:C188-5))
					$vlTop:=Screen height:C188-540-5
					If ($vlTop<15)
						$vlTop:=15
					End if 
					$vlBot:=Screen height:C188-5
				End if 
				
				C_LONGINT:C283(INSPRV_CurrID_L; INSPRV_NumInSel_L)
				INSPRV_CurrID_L:=Selected record number:C246([Inspections:27])
				INSPRV_NumInSel_L:=Records in selection:C76([Inspections:27])
				SET WINDOW RECT:C444($vlLeft; $vlTop; $vlRight; $vlBot)
				COPY NAMED SELECTION:C331([Inspections:27]; "TempInspectsOpen")
				
				GOTO SELECTED RECORD:C245([Inspections:27]; $row_l)
				
				MODIFY RECORD:C57([Inspections:27])
				
				If (Records in selection:C76([Inspections:27])=0)
					USE NAMED SELECTION:C332("TempInspectsOpen")
				End if 
				CLEAR NAMED SELECTION:C333("TempInspectsOpen")
				
				If (Records in selection:C76([Inspections:27])#INSPRV_NumInSel_L)
					COPY NAMED SELECTION:C331([Inspections:27]; "UserRegionA")
					RegionTitle
					
					If (INSPRV_CurrID_L<=Records in selection:C76([Inspections:27]))
					Else 
						INSPRV_CurrID_L:=Records in selection:C76([Inspections:27])
					End if 
					GOTO SELECTED RECORD:C245([Inspections:27]; INSPRV_CurrID_L)
					CLEAR SET:C117("UserSet")
					CREATE EMPTY SET:C140([Inspections:27]; "UserSet")
					ADD TO SET:C119([Inspections:27]; "UserSet")
					HIGHLIGHT RECORDS:C656
					
				End if 
				GET WINDOW RECT:C443($vlLeft; $vlTop; $vlRight; $vlBot)
				SET WINDOW RECT:C444($vlLeft; $vlTop; $vlLeft+vlInspRevWWid; $vlTop+vlInspRevWHt)
				OBJECT SET COORDINATES:C1248(*; "InspectionReview"; $LB_Left; $LBTop; $LBRight; $LBBot)
				OBJECT GET COORDINATES:C663(*; "@Button"; $Buttonleft; $ButtonNewTop; $ButtonRight; $buttonBot)
				OBJECT MOVE:C664(*; "@Button"; 0; ($ButtonTop-$ButtonNewTop))
				C_POINTER:C301($LBPointer)
				$LBPointer:=OBJECT Get pointer:C1124(Object current:K67:2)
				REDRAW:C174($LBPointer->)
				REDRAW WINDOW:C456
				InDoubleClick_B:=False:C215
			End if 
			
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		Case of 
			: ($NameofObj_txt="LB_Header1_l")  //Type
				SetSortButton(->LB_Header1_l)
				Case of 
					: (LB_Header1_l=1)
						ORDER BY:C49([Inspections:27]; [Inspection Type:31]Description:2; >; [Inspections:27]InitialInsp:9; <)
					: (LB_Header1_l=2)
						ORDER BY:C49([Inspections:27]; [Inspection Type:31]Description:2; <; [Inspections:27]InitialInsp:9; <)
				End case 
				$0:=-1
			: ($NameofObj_txt="LB_Header5_l")  //TEAM LEADER
				SetSortButton(->LB_Header5_l)
				INSP_SortByTmLeader(LB_Header5_l)
				$0:=-1
				
			: ($NameofObj_txt="LB_Header7_l")  //reviewed
				SetSortButton(->LB_Header7_l)
				
				Case of 
					: (LB_Header7_l=1)
						ORDER BY:C49([Inspections:27]; [Inspections:27]InspReviewed:12)
					: (LB_Header7_l=2)
						ORDER BY:C49([Inspections:27]; [Inspections:27]InspReviewed:12; <)
				End case 
				$0:=-1
			: ($NameofObj_txt="LB_Header8_l")  //approved
				
				SetSortButton(->LB_Header8_l)
				Case of 
					: (LB_Header8_l=1)
						ORDER BY:C49([Inspections:27]; [Inspections:27]InspApproved:167)
					: (LB_Header8_l=2)
						ORDER BY:C49([Inspections:27]; [Inspections:27]InspApproved:167; <)
						$0:=-1
						
				End case 
		End case 
End case 
//End [Inspections];"InspectionReview_LB".InspectionReview