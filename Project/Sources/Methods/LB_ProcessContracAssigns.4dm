//%attributes = {"invisible":true}
// Method: LB_ProcessContracAssigns
// Description
// 
// 
// Parameters
// $0 : $Result_L
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/12/12, 08:27:23
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	// Modified by: Costas Manousakis-(Designer)-(3/6/14 17:15:17)
	Mods_2014_03
	//  `Removed columns assignment, boston pm, preserv eng, Designer.; added Date to FAPO.
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
End if 
C_LONGINT:C283($0)
$0:=0

C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Display Detail:K2:22)
		
		PRV_Variables("RELATEBRIDGEINFO")
		LB_Detail3_txt:=PRV_Dist_txt
		LB_Detail4_txt:=PRV_BDEPT_txt
		LB_Detail5_txt:=PRV_OverUnder_txt
		
		PRV_Variables("RELATEPINFO")
		
		LB_Detail6_txt:=PRV_ProjDescr_txt
		//LB_Detail8_txt:=PRV_ProjMgr_txt
		
		//LB_Detail9_txt:=PRV_SortByPINFO_txt ("PROJCONS";False)
		
		//C_TEXT($phone_txt)
		//LB_Detail10_txt:=""
		//PERS_GetInfo ([Contract_Assignment_Maintenance]ProjectManagerID_L;"FULLNAME";->LB_Detail10_txt;"PHONE";->$phone_txt)
		//If ($phone_txt#"")
		//LB_Detail10_txt:=LB_Detail10_txt+" ("+$phone_txt+")"
		//End if 
		//LB_Detail10_txt:=PRV_SortByPINFO_txt ("PRESREVIEWER";False)
		//LB_Detail11_d:=PRV_SchedAdDate_d
		//If (PRV_ActualAdDate_d#!00/00/00!)
		//LB_Detail11_d:=PRV_ActualAdDate_d
		//End if 
		LB_Detail8_d:=PRV_SortByPINFO_d("ADDATE"; False:C215)
		
		LB_Detail10_txt:=PRV_OnOff_txt  //Bridge Info
		
		LB_Detail13_txt:=[Contract_Assignment_Maintenance:101]LateAction_s:79+" "+String:C10([Contract_Assignment_Maintenance:101]LateActionDate_d:80; Blank if null date:K1:9)  //Action Taken
		
	: ($FormEvent_L=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		Case of 
			: ($nameofObj_txt="LB_Header3_l")
				If (LB_SortDirection4_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("DIST"); >)
					LB_SortDirection4_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("DIST"); <)
					LB_SortDirection4_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header4_l")
				If (LB_SortDirection5_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("BDEPT"); >)
					LB_SortDirection5_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("BDEPT"); <)
					LB_SortDirection5_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header5_l")
				If (LB_SortDirection6_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("OVERUNDER"); >)
					LB_SortDirection6_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("OVERUNDER"); <)
					LB_SortDirection6_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header6_l")
				If (LB_SortDirection7_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByPINFO_txt("PROJDESC"); >)
					LB_SortDirection7_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByPINFO_txt("PROJDESC"); <)
					LB_SortDirection7_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
				//: ($nameofObj_txt="LB_Header8_l")
				//If (LB_SortDirection8_l=0)
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PROJMGR");>)
				//LB_SortDirection8_l:=1
				//Self->:=1
				//Else 
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PROJMGR");<)
				//LB_SortDirection8_l:=0
				//Self->:=2
				//
				//End if 
				//$0:=-1
				//: ($nameofObj_txt="LB_Header9_l")
				//If (LB_SortDirection9_l=0)
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PROJCONS");>)
				//LB_SortDirection9_l:=1
				//Self->:=1
				//Else 
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PROJCONS");<)
				//LB_SortDirection9_l:=0
				//Self->:=2
				//
				//End if 
				//$0:=-1
				//: ($nameofObj_txt="LB_Header10_l")
				//If (LB_SortDirection10_l=0)
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PRESREVIEWER");>)
				//LB_SortDirection10_l:=1
				//Self->:=1
				//Else 
				//ORDER BY FORMULA([Contract_Assignment_Maintenance];PRV_SortByPINFO_txt ("PRESREVIEWER");<)
				//LB_SortDirection10_l:=0
				//Self->:=2
				//
				//End if 
				//$0:=-1
				
			: ($nameofObj_txt="LB_Header8_l")
				If (LB_SortDirection11_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByPINFO_d("ADDATE"); >)
					LB_SortDirection11_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByPINFO_d("ADDATE"); <)
					LB_SortDirection11_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
				
			: ($nameofObj_txt="LB_Header10_l")
				If (LB_SortDirection13_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("ONOFF"); >)
					LB_SortDirection13_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; PRV_SortByBRGINFO_s("ONOFF"); <)
					LB_SortDirection13_l:=0
					Self:C308->:=2
					
				End if 
				$0:=-1
				
			: ($nameofObj_txt="LB_Header11_l")
				If (LB_SortDirection14_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; Find in array:C230(PRV_ProjectStatus_atxt; [Contract_Assignment_Maintenance:101]ProjectStatus_s:52); >)
					LB_SortDirection14_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; Find in array:C230(PRV_ProjectStatus_atxt; [Contract_Assignment_Maintenance:101]ProjectStatus_s:52); <)
					LB_SortDirection14_l:=0
					Self:C308->:=2
				End if 
				$0:=-1
				
			: ($nameofObj_txt="LB_Header13_l")
				If (LB_SortDirection16_l=0)
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; Find in array:C230(PRV_LateAction_atxt; [Contract_Assignment_Maintenance:101]LateAction_s:79); >)
					LB_SortDirection16_l:=1
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([Contract_Assignment_Maintenance:101]; Find in array:C230(PRV_LateAction_atxt; [Contract_Assignment_Maintenance:101]LateAction_s:79); <)
					LB_SortDirection16_l:=0
					Self:C308->:=2
				End if 
				$0:=-1
				
		End case 
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($LBCol_L; $LBRow_L)
			//ALERT("doubleClicked on "+$LBName_txt)
			
			LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; $LBRow_L)
			C_BOOLEAN:C305($ReSetWinBox_b)
			
			If ($LBRow_L>0)
				C_LONGINT:C283($FM_W_L; $FM_W_H; $W_L_L; $W_T_L; $W_R_L; $W_B_L; $W_W_L; $W_H_L)
				GET WINDOW RECT:C443($W_L_L; $W_T_L; $W_R_L; $W_B_L)
				$W_W_L:=$W_R_L-$W_L_L
				$W_H_L:=$W_B_L-$W_T_L
				FORM GET PROPERTIES:C674([Contract_Assignment_Maintenance:101]; "PreservationInput"; $FM_W_L; $FM_W_H)
				$ReSetWinBox_b:=False:C215
				C_LONGINT:C283($WL_L; $WT_L; $WR_L; $WB_L; $OL_L; $OT_L; $OR_L; $OB_L)
				C_LONGINT:C283($ForDesVertMar_L; $BotBtnVertMar_L; $LBVertMar_L)
				OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
				$ForDesVertMar_L:=$W_H_L-$OB_L
				OBJECT GET COORDINATES:C663(*; "BottomBtn_@"; $OL_L; $OT_L; $OR_L; $OB_L)
				$BotBtnVertMar_L:=$W_H_L-$OB_L
				OBJECT GET COORDINATES:C663(*; "SelectListBox@"; $OL_L; $OT_L; $OR_L; $OB_L)
				$LBVertMar_L:=$W_H_L-$OB_L
				
				If (($FM_W_L>$W_W_L) | ($FM_W_H>$W_H_L))
					SET WINDOW RECT:C444($W_L_L; $W_T_L; $W_L_L+MaxNum($FM_W_L; $W_W_L); $W_T_L+MaxNum($FM_W_H; $W_H_L))
					$ReSetWinBox_b:=True:C214
				End if 
				C_BOOLEAN:C305(PRV_FORM_LOADED_b)
				PRV_FORM_LOADED_b:=False:C215
				FORM SET INPUT:C55([Contract_Assignment_Maintenance:101]; "PreservationInput")
				GOTO SELECTED RECORD:C245([Contract_Assignment_Maintenance:101]; $LBRow_L)
				If ((GRP_UserInGroup("PreservationEdit")=1) | User in group:C338(Current user:C182; "Design Access Group"))
					C_LONGINT:C283($LoadRecord_L)
					$LoadRecord_L:=ut_LoadRecordInteractiveV2(->[Contract_Assignment_Maintenance:101])
					
					Case of 
						: ($LoadRecord_L=1)
							PRV_LockedAssignment_b:=False:C215
							MODIFY RECORD:C57([Contract_Assignment_Maintenance:101])
						: ($LoadRecord_L=2)
							PRV_LockedAssignment_b:=True:C214
							READ ONLY:C145([Contract_Assignment_Maintenance:101])
							DIALOG:C40([Contract_Assignment_Maintenance:101]; "PreservationInput")
					End case 
					
				Else 
					PRV_LockedAssignment_b:=True:C214
					READ ONLY:C145([Contract_Assignment_Maintenance:101])
					DIALOG:C40([Contract_Assignment_Maintenance:101]; "PreservationInput")
				End if 
				
				If (Record number:C243([Contract_Assignment_Maintenance:101])>0)
					LISTBOX SELECT ROW:C912(*; "SelectListBox"; Selected record number:C246([Contract_Assignment_Maintenance:101]); lk replace selection:K53:1)
					OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; Selected record number:C246([Contract_Assignment_Maintenance:101]))
				Else 
					//deleted a record
					ARRAY LONGINT:C221($RecordNumbers_aL; Records in selection:C76([Contract_Assignment_Maintenance:101]))
					SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]; $RecordNumbers_aL)
					C_LONGINT:C283($loop_L)
					For ($loop_L; Size of array:C274($RecordNumbers_aL); 1; -1)
						
						If ($RecordNumbers_aL{$loop_L}<=0)
							DELETE FROM ARRAY:C228($RecordNumbers_aL; $loop_L; 1)
						End if 
					End for 
					
					CREATE SELECTION FROM ARRAY:C640([Contract_Assignment_Maintenance:101]; $RecordNumbers_aL)
					LB_SetWindowTitle  //this one clears the SelectedRecordSet
					
				End if 
				
				//ut_Send2Clipboard ("Obje event before set size "+ut_ReturnTimeStampFromDate (Current date(*);Current time(*))+Char(13))
				GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
				//ut_Send2Clipboard ("W : "+String($WL_L)+" ; "+String($WT_L)+" ; "+String($WR_L)+" ; "+String($WB_L)+Char(13))
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("LB : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("ForDes : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				OBJECT GET COORDINATES:C663(*; "BottomBtn_@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("Buttons  : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				
				SET WINDOW RECT:C444($W_L_L; $W_T_L; $W_L_L+MaxNum($FM_W_L; $W_W_L); $W_T_L+$W_H_L)
				
				//ut_Send2Clipboard ("Obje event after set size "+ut_ReturnTimeStampFromDate (Current date(*);Current time(*))+Char(13))
				GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
				//ut_Send2Clipboard ("W : "+String($WL_L)+" ; "+String($WT_L)+" ; "+String($WR_L)+" ; "+String($WB_L)+Char(13))
				
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("LB  before resize :"+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				C_LONGINT:C283($LBResize; $BottObjMove_L)
				$LBResize:=($WB_L-$WT_L)-$LBVertMar_L-$OB_L
				OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; 0; $LBResize)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("LB  after resize :"+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				
				OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("ForDes before move : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				$BottObjMove_L:=($WB_L-$WT_L)-$ForDesVertMar_L-$OB_L
				OBJECT MOVE:C664(*; "ForDesigner@"; 0; $BottObjMove_L; 0; 0)
				OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("ForDes after move : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				
				OBJECT GET COORDINATES:C663(*; "BottomBtn_@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("Buttons before move : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				$BottObjMove_L:=($WB_L-$WT_L)-$BotBtnVertMar_L-$OB_L
				OBJECT MOVE:C664(*; "BottomBtn_@"; 0; $BottObjMove_L; 0; 0)
				OBJECT GET COORDINATES:C663(*; "BottomBtn_@"; $OL_L; $OT_L; $OR_L; $OB_L)
				//ut_Send2Clipboard ("Buttons after move : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
				
				REDRAW:C174(SelectListBox)
				
			End if 
			
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		C_LONGINT:C283($LBCol_L; $LBRow_L; $SelectedRow_L; $Ret_L; $MinRet_L; $MaxRet_L)
		//ALERT("doubleClicked on "+$LBName_txt)
		
		LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; $LBRow_L)
		If ($LBRow_L>0)
			If ((Right click:C712) | (Macintosh control down:C544))
				
				READ ONLY:C145([Contract_Assignment_Maintenance:101])
				GOTO SELECTED RECORD:C245([Contract_Assignment_Maintenance:101]; $LBRow_L)
				LOAD RECORD:C52([Contract_Assignment_Maintenance:101])
				$SelectedRow_L:=Find in array:C230(PRV_ProjectColors_atxt; [Contract_Assignment_Maintenance:101]ProjectColor_s:75)
				$MinRet_L:=3
				$MaxRet_L:=2+Size of array:C274(PRV_ProjectColors_atxt)
				
				If ($SelectedRow_L>0)
					$SelectedRow_L:=$SelectedRow_L+2
				Else 
					$SelectedRow_L:=0
				End if 
				
				C_LONGINT:C283($Ret_L)
				$Ret_L:=Pop up menu:C542(PRV_ColorMenuPopup_txt; $SelectedRow_L)
				
				If (($Ret_L>=$MinRet_L) & ($Ret_L<=$MaxRet_L))
					$Ret_L:=$Ret_L-2
					
					If (Records in set:C195("SelectedRecordsSet")=1)
						If (ut_LoadRecordInteractive(->[Contract_Assignment_Maintenance:101]))
							[Contract_Assignment_Maintenance:101]ProjectColor_s:75:=PRV_ProjectColors_atxt{$Ret_L}
							LogChanges(->[Contract_Assignment_Maintenance:101]ProjectColor_s:75; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Assignment_Maintenance:101]ContractNo:1; ->[Contract_Assignment_Maintenance:101]AssignID:3; 1)
							SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
						End if 
						
					Else 
						FIRST RECORD:C50([Contract_Assignment_Maintenance:101])
						While (Not:C34(End selection:C36([Contract_Assignment_Maintenance:101])))
							
							If (Is in set:C273("SelectedRecordsSet"))
								If (ut_LoadRecordInteractive(->[Contract_Assignment_Maintenance:101]))
									[Contract_Assignment_Maintenance:101]ProjectColor_s:75:=PRV_ProjectColors_atxt{$Ret_L}
									LogChanges(->[Contract_Assignment_Maintenance:101]ProjectColor_s:75; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Assignment_Maintenance:101]ContractNo:1; ->[Contract_Assignment_Maintenance:101]AssignID:3; 1)
									SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
								End if 
								
							End if 
							
							NEXT RECORD:C51([Contract_Assignment_Maintenance:101])
						End while 
						LISTBOX SELECT ROW:C912(*; "SelectListBox"; 0; lk remove from selection:K53:3)
						
					End if 
					REDRAW:C174(SelectListBox)
					
				End if 
				
			End if 
			
		End if 
		
	: ($FormEvent_L=On Load:K2:1)
		
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt)
		
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; Table:C252(->[Contract_Assignment_Maintenance:101]))
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		C_TEXT:C284($HeaderVarName_txt)
		
		//Column 1
		$ColumnNumber_l:=1
		
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]ProjectIS:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "File No.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]ContractNo:1; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Contract")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//  `Column 3
		//$ColumnNumber_l:=$ColumnNumber_l+1
		//
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//INSERT LISTBOX COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;[Contract_Assignment_Maintenance]AssignNo;$HeaderVarName_txt;$HeaderVar_ptr->)
		//BUTTON TEXT(*;$HeaderVarName_txt;"Assignment")
		//SET ALIGNMENT(*;$ColumnName_txt;Center )
		
		//Column 3 4 
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Dist.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 4 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Bridge No.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		
		//Column 5 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Location")
		//SET ALIGNMENT(*;$ColumnName_txt;Center )
		
		//Column 6 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Project Description")
		//SET ALIGNMENT(*;$ColumnName_txt;Center )
		
		//  `Column 8
		//$ColumnNumber_l:=$ColumnNumber_l+1
		//
		//LB_SetUPVariableColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$ColumnVar_ptr;->$HeaderVar_ptr;->$ColumnName_txt;"txt")
		//INSERT LISTBOX COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;$ColumnVar_ptr->;$HeaderVarName_txt;$HeaderVar_ptr->)
		//BUTTON TEXT(*;$HeaderVarName_txt;"Boston P.M.")
		//
		//  `Column 9
		//$ColumnNumber_l:=$ColumnNumber_l+1
		//
		//LB_SetUPVariableColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$ColumnVar_ptr;->$HeaderVar_ptr;->$ColumnName_txt;"txt")
		//INSERT LISTBOX COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;$ColumnVar_ptr->;$HeaderVarName_txt;$HeaderVar_ptr->)
		//BUTTON TEXT(*;$HeaderVarName_txt;"Designer")
		//  `
		//  `Column 10
		//$ColumnNumber_l:=$ColumnNumber_l+1
		//
		//LB_SetUPVariableColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$ColumnVar_ptr;->$HeaderVar_ptr;->$ColumnName_txt;"txt")
		//INSERT LISTBOX COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;$ColumnVar_ptr->;$HeaderVarName_txt;$HeaderVar_ptr->)
		//BUTTON TEXT(*;$HeaderVarName_txt;"Preservation Reviewer")
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "d")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]DocsSentToFAPO_d:49; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "To FAPO")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(System date short:K1:1+Blank if null date:K1:9))
		
		//
		//Column 8 11
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "d")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Ad Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(System date short:K1:1+Blank if null date:K1:9))
		//
		//Column 9 12
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]Funding_s:53; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "FA/NFA")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//
		//Column 10 13
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Item26")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//
		//Column 11 14
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]ProjectStatus_s:52; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Status")
		
		//Column 12 15
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "d")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Contract_Assignment_Maintenance:101]DeadLine_d:78; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Deadline")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(System date short:K1:1+Blank if null date:K1:9))
		
		//Column 13 16
		$ColumnNumber_l:=$ColumnNumber_l+1
		
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Action Taken")
		//
		OBJECT SET FONT SIZE:C165(*; "LB_Header@"; 11)
		OBJECT SET FONT STYLE:C166(*; "LB_Header@"; Bold:K14:2)
		OBJECT SET ENTERABLE:C238(*; "Column_@"; False:C215)
		
		//$ColumnNumber_l:=Get listbox rows height(*;"SelectListBox")
		//SET LISTBOX ROWS HEIGHT(*;"SelectListBox";$ColumnNumber_l*2)
		PRV_Variables("INIT")
		
	: ($FormEvent_L=On Unload:K2:2)
	: ($FormEvent_L=On Resize:K2:27)
		
		C_LONGINT:C283($WL_L; $WT_L; $WR_L; $WB_L; $OL_L; $OT_L; $OR_L; $OB_L)
		GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
		If (False:C215)
			//ut_Send2Clipboard ("Object event "+ut_ReturnTimeStampFromDate (Current date(*);Current time(*))+Char(13))
			//ut_Send2Clipboard ("W : "+String($WL_L)+" ; "+String($WT_L)+" ; "+String($WR_L)+" ; "+String($WB_L)+Char(13))
			
			OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OL_L; $OT_L; $OR_L; $OB_L)
			//ut_Send2Clipboard ("LB : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
			
			OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
			//ut_Send2Clipboard ("ForDes : "+String($OL_L)+" ; "+String($OT_L)+" ; "+String($OR_L)+" ; "+String($OB_L)+Char(13))
			
		End if 
		
End case 
//End LB_ProcessContracAssigns