
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/20/15, 12:34:55
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo];"ListBoxOutput".SelectListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2015_10  // 
	//Modified by: administrator (10/20/15 12:52:46)
	// Modified by: Costas Manousakis-(Designer)-(5/4/16 16:28:42)
	Mods_2016_NTE
	//  `added contextual click 
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(10/17/17 17:11:46)
	Mods_2017_10
	//  `use NTI_GroupSuffix and NTI_GetInspResp to check if can add inspections for this TIN
	// Modified by: Costas Manousakis-(Designer)-(1/23/18 12:46:43)
	Mods_2018_01
	//  `added Item number to column headers
	// Modified by: CJMiller-(Designer)-(6/5/18
	Mods_2018_06
	//Add new Column (TIN) and allow for sort on [NTI_TunnelInfo];"ListBoxOutput" and Copy Named Selection after sorting
	//Modified by: Chuck Miller (6/11/18 12:44:57)
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly. Also make all columns sortable
	//Modified by: CJ (10/6/20 13:35:45)
End if 

Compiler_LB
C_LONGINT:C283($ColumnNumber_l; $TotalLB_width_L)
C_TEXT:C284($ColumnName_txt)
ARRAY TEXT:C222($ColumnNames_atxt; 0)
ARRAY TEXT:C222($HeaderNames_atxt; 0)
ARRAY TEXT:C222($ColumnVariables_atxt; 0)
ARRAY TEXT:C222($HeaderVariables_atxt; 0)
ARRAY BOOLEAN:C223($Visible_ab; 0)
ARRAY LONGINT:C221($Styles_aL; 0)
C_LONGINT:C283($pos_L)

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		LB_Detail2_txt:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
		//$pos_L:=Position(" ";NTI_i9_L_atxt{[NTI_TunnelInfo]NTI_i9_L})
		//LB_Detail6_txt:=Substring(NTI_i9_L_atxt{[NTI_TunnelInfo]NTI_i9_L};1;$pos_L)+[NTI_TunnelInfo]NTI_i7_s+" "+NTI_i8_s_atxt{Num([NTI_TunnelInfo]NTI_i8_s)}
		
		If (Num:C11([NTI_TunnelInfo:181]NTI_i8_s:13)>0)
			LB_Detail7_txt:=[NTI_TunnelInfo:181]NTI_i7_s:12+" "+Substring:C12(NTI_i8_s_atxt{Find in array:C230(NTI_i8_s_atxt; ([NTI_TunnelInfo:181]NTI_i8_s:13+"@"))}; 5)
		Else 
			LB_Detail7_txt:=[NTI_TunnelInfo:181]NTI_i7_s:12
		End if 
	: (Form event code:C388=On Header Click:K2:40)
		C_TEXT:C284($nameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		RESOLVE POINTER:C394(Self:C308; $nameofObj_txt; $dumTbl_L; $dumFld_L)
		$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
		
		Case of 
			: ($nameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6; >)
					
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6; <)
					$SortVariable_ptr->:=2
				End if 
				
			: ($nameofObj_txt="LB_Header2_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(Self:C308->); >)
					COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(Self:C308->); <)
					COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
					$SortVariable_ptr->:=2
				End if 
			: ($nameofObj_txt="LB_Header3_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i2_s:7; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i2_s:7; <)
					$SortVariable_ptr->:=2
				End if 
			: ($nameofObj_txt="LB_Header4_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_TownName_s:71; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_TownName_s:71; <)
					$SortVariable_ptr->:=2
				End if 
			: ($nameofObj_txt="LB_Header5_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i6_s:11; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i6_s:11; <)
					$SortVariable_ptr->:=2
				End if 
			: ($nameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i10_s:15; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i10_s:15; <)
					$SortVariable_ptr->:=2
				End if 
			: ($nameofObj_txt="LB_Header7_l")
				ARRAY LONGINT:C221($recordNumbers_al; 0)
				ARRAY TEXT:C222($NTI8_atxt; 0)
				ARRAY TEXT:C222($NTI7_atxt; 0)
				ARRAY TEXT:C222($Result_atxt; 0)
				C_LONGINT:C283($loop_l)
				SELECTION TO ARRAY:C260([NTI_TunnelInfo:181]; $recordNumbers_al; [NTI_TunnelInfo:181]NTI_i8_s:13; $NTI8_atxt; [NTI_TunnelInfo:181]NTI_i7_s:12; $NTI7_atxt)
				ARRAY TEXT:C222($Result_atxt; Size of array:C274($recordNumbers_al))
				For ($loop_l; 1; Size of array:C274($recordNumbers_al))
					If (Num:C11($NTI8_atxt{$loop_l})>0)
						$Result_atxt{$loop_l}:=$NTI7_atxt{$loop_l}+" "+Substring:C12(NTI_i8_s_atxt{Find in array:C230(NTI_i8_s_atxt; ($NTI8_atxt{$loop_l}+"@"))}; 5)
					Else 
						$Result_atxt{$loop_l}:=$NTI7_atxt{$loop_l}
					End if 
				End for 
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					SORT ARRAY:C229($Result_atxt; $recordNumbers_al; >)
					$SortVariable_ptr->:=1
				Else 
					SORT ARRAY:C229($Result_atxt; $recordNumbers_al; <)
					$SortVariable_ptr->:=2
				End if 
				CREATE SELECTION FROM ARRAY:C640([NTI_TunnelInfo:181]; $recordNumbers_al; "NTI_TunnelInfoSet1")
				USE NAMED SELECTION:C332("NTI_TunnelInfoSet1")
				CLEAR NAMED SELECTION:C333("NTI_TunnelInfoSet1")
			Else 
				COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
				USE NAMED SELECTION:C332("NTI_TunnelInfoSet")
				
		End case 
		$0:=-1
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($LBCol_L)
			LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; NTI_TunnelRow_L)
			If (NTI_TunnelRow_L>0)
				ARRAY LONGINT:C221(NTI_SelectedRN_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
				
				
				GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
				
				C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
				NTI_CurrentPage_L:=0
				NTI_ControlModification(->[NTI_TunnelInfo:181]; "Input")
				
				SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $wl; $wt; $wr; $wb)
				
				OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $or-$wr; $ob-$wb)
				
				If (In transaction:C397)  //we must have cancelled out of inventory input form
					CANCEL TRANSACTION:C241
				End if 
				
				LISTBOX SELECT ROW:C912(*; "SelectListBox"; NTI_TunnelRow_L)
				OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; NTI_TunnelRow_L)
				ut_SetReadWrite("read"; ->[NTI_TunnelInfo:181])
				REDRAW:C174(NTI_Tunnel_LB)
				
				WIN_SetWindowTitle(->[NTI_TunnelInfo:181])
				
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			C_LONGINT:C283($LBCol_L)
			LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; NTI_TunnelRow_L)
			If (NTI_TunnelRow_L>0)
				C_LONGINT:C283($c_L)
				$c_L:=0
				GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
				C_TEXT:C284($Popup_txt)
				C_LONGINT:C283($AllowAddALL_L; $AllowAddDistrict_L)
				$AllowAddALL_L:=GRP_UserInGroup("TIN_AddInspections_ALL")
				$AllowAddDistrict_L:=GRP_UserInGroup("TIN_AddInspections_"+NTI_GroupSuffix(NTI_GetInspResp([NTI_TunnelInfo:181]NTI_i1_s:6)))
				C_BOOLEAN:C305($AllowTinMod_b; $allowTINDEL_b)
				NTI_SetModDeleteAccess(->$AllowTinMod_b; ->$allowTINDEL_b)
				
				$Popup_txt:=""
				Case of 
					: (User in group:C338(Current user:C182; "Design Access Group"))
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
					: ($AllowAddDistrict_L=1)
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
					: ($AllowAddALL_L=1)
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
					: (User in group:C338(<>CurrentUser_Name; "Bridge Engineer"))
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
					: (User in group:C338(<>CurrentUser_Name; "Bridge Insp Engineer"))
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
					: ($AllowTinMod_b)
						$Popup_txt:="( ;Edit TIN;Open Inspections;Open BINs"
				End case 
				
				$c_L:=Pop up menu:C542($Popup_txt)
				
				Case of 
					: ($c_L=2)  //Edit the TIN
						ARRAY LONGINT:C221(NTI_SelectedRN_aL; 0)
						LONGINT ARRAY FROM SELECTION:C647([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
						
						GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
						
						C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
						GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
						OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
						NTI_CurrentPage_L:=0
						NTI_ControlModification(->[NTI_TunnelInfo:181]; "Input")
						
						SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
						OBJECT GET COORDINATES:C663(*; "SelectListBox"; $wl; $wt; $wr; $wb)
						
						OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $or-$wr; $ob-$wb)
						
						If (In transaction:C397)  //we must have cancelled out of inventory input form
							CANCEL TRANSACTION:C241
						End if 
						
						LISTBOX SELECT ROW:C912(*; "SelectListBox"; NTI_TunnelRow_L)
						OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; NTI_TunnelRow_L)
						ut_SetReadWrite("read"; ->[NTI_TunnelInfo:181])
						REDRAW:C174(NTI_Tunnel_LB)
						
						WIN_SetWindowTitle(->[NTI_TunnelInfo:181])
						
					: ($c_L=3)  //show inspections
						ARRAY LONGINT:C221(NTI_SelectedRN_aL; 0)
						LONGINT ARRAY FROM SELECTION:C647([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
						
						GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
						
						C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
						GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
						OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
						NTI_CurrentPage_L:=0
						NTI_ShowInspectionList
						
						SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
						OBJECT GET COORDINATES:C663(*; "SelectListBox"; $wl; $wt; $wr; $wb)
						
						OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $or-$wr; $ob-$wb)
						
						If (In transaction:C397)  //we must have cancelled out of inventory input form
							CANCEL TRANSACTION:C241
						End if 
						
						LISTBOX SELECT ROW:C912(*; "SelectListBox"; NTI_TunnelRow_L)
						OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; NTI_TunnelRow_L)
						ut_SetReadWrite("read"; ->[NTI_TunnelInfo:181])
						REDRAW:C174(NTI_Tunnel_LB)
						
						WIN_SetWindowTitle(->[NTI_TunnelInfo:181])
						
					: ($c_L=4)  //bring up list of BINs assigned to the TIN
						GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
						READ ONLY:C145([TunnelInfo:151])
						READ ONLY:C145([Bridge MHD NBIS:1])
						QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]NTI_i1_s:33=[NTI_TunnelInfo:181]NTI_i1_s:6)
						SELECTION TO ARRAY:C260([TunnelInfo:151]BIN:1; $BINS_atxt)
						QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $BINS_atxt)
						CREATE SET:C116([Bridge MHD NBIS:1]; "TempSet")
						C_TIME:C306($tempset_t)
						$tempset_t:=Create document:C266(Temporary folder:C486+[NTI_TunnelInfo:181]NTI_i1_s:6+"BIN.set")
						If (OK=1)
							CLOSE DOCUMENT:C267($tempset_t)
							SAVE SET:C184("TempSet"; Document)
							P_LoadBINSelection(Document; [NTI_TunnelInfo:181]NTI_i1_s:6)
						Else 
							ALERT:C41("Unable to create temporary file for the BINs")
						End if 
						
				End case 
				
			End if 
			
		End if 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($ShowDesignerStuff_b)
		
		$ShowDesignerStuff_b:=False:C215
		READ ONLY:C145([LB_QueryTable:147])
		QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1="NT_TunnelOut")
		
		C_LONGINT:C283($BottomCompare_l)
		
		If (Records in selection:C76([LB_QueryTable:147])=0)
			$ShowDesignerStuff_b:=True:C214
			CREATE RECORD:C68([LB_QueryTable:147])
			[LB_QueryTable:147]QueryName_s:1:="NT_TunnelOut"
			[LB_QueryTable:147]ColumnWidths_txt:2:="170, 290, 150, 60, 250, 110"
			[LB_QueryTable:147]TableName_s:4:="NTI_TunnelInfo"
			[LB_QueryTable:147]TableNumber_l:3:=Table:C252(->[NTI_TunnelInfo:181])
			Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
			LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
			InitChangeStack(1)
			PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
			PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
			PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
			PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
			FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
			SAVE RECORD:C53([LB_QueryTable:147])
		Else 
			If (User in group:C338(Current user:C182; "Design Access Group")) & (Shift down:C543)
				$ShowDesignerStuff_b:=True:C214
				ut_LoadRecord(->[LB_QueryTable:147])
				
			End if 
		End if 
		LISTBOX DELETE COLUMN:C830(*; "SelectListBox"; 1; 99)
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; Table:C252(->[NTI_TunnelInfo:181]))
		ARRAY TEXT:C222($ColumnWidths_atxt; 0)
		ColumnWidths_txt:=[LB_QueryTable:147]ColumnWidths_txt:2
		ut_NewTextToArray(ColumnWidths_txt; ->$ColumnWidths_atxt)
		
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		C_TEXT:C284($HeaderVarName_txt)
		$TotalLB_width_L:=0
		$ColumnNumber_l:=1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [NTI_TunnelInfo:181]NTI_i1_s:6; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Tunnel Number (I1)")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "###-###-###-###-###")
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "TIN")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [NTI_TunnelInfo:181]NTI_i2_s:7; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Tunnel Name (I2)")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [NTI_TunnelInfo:181]NTI_TownName_s:71; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Town Name")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [NTI_TunnelInfo:181]NTI_i6_s:11; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "District (I6)")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [NTI_TunnelInfo:181]NTI_i10_s:15; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Facility (I10)")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Route (I7,8)")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ($ColumnNumber_L<=Size of array:C274($ColumnWidths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; Num:C11($ColumnWidths_atxt{$ColumnNumber_L}))
			$TotalLB_width_L:=$TotalLB_width_L+Num:C11($ColumnWidths_atxt{$ColumnNumber_L})
		End if 
		
		
		If ($ShowDesignerStuff_b)
			OBJECT SET VISIBLE:C603(*; "ForDesigner"; True:C214)
			OBJECT SET VISIBLE:C603(*; "ForDesigner1"; True:C214)
			OBJECT SET VISIBLE:C603(*; "ForDesigner2"; True:C214)
			C_LONGINT:C283($Left_l; $top_l; $Right_l; $Bottom_l)
			OBJECT GET COORDINATES:C663(*; "SelectListBox"; $Left_l; $top_l; $Right_l; $Bottom_l)
			C_LONGINT:C283($Left1_l; $top1_l; $Right1_l; $Bottom1_l; $MOVEAMT_L)
			OBJECT GET COORDINATES:C663(*; "ForDesigner"; $Left1_l; $top1_l; $Right1_l; $Bottom1_l)
			If ($Bottom_l>=$top1_l)
				$MOVEAMT_L:=$top1_l-$Bottom_l
				
				OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; 0; $top1_l-$Bottom_l-20)
				
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
		End if 
		
		If ($ColumnNumber_L<Size of array:C274($ColumnWidths_atxt))
			ARRAY TEXT:C222(arrColNames; 0)
			ARRAY TEXT:C222(arrHeaderNames; 0)
			ARRAY POINTER:C280(arrColVars; 0)
			ARRAY POINTER:C280(arrHeaderVars; 0)
			ARRAY BOOLEAN:C223(arrColsVisible; 0)
			ARRAY POINTER:C280(arrStyles; 0)
			LISTBOX GET ARRAYS:C832(*; "SelectListBox"; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)
			
			LB_SetColumnWidths
		Else 
			
			LB_ResizeWindow($TotalLB_width_L; "SelectListBox")
		End if 
End case 
//End Object Method: [NTI_TunnelInfo].OutputListBox.List Box