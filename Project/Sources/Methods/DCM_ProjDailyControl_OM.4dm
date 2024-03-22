//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/11, 16:53:23
	// ----------------------------------------------------
	// Method: DCM_ProjDailyControl_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT")
	// $2 : $FormEvent_L (Optional)
	// ----------------------------------------------------
	
	Mods_2011_02
End if 

C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$FormEvent_L:=$2
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($Task_txt="ADD")
		C_LONGINT:C283($WW_L; $WH_L)
		FORM GET PROPERTIES:C674([DCM_ProjDailys:143]; "DistrInput"; $WW_L; $WH_L)
		NewWindow($WW_L; $WH_L; 0; Plain no zoom box window:K34:1; "DAILY INPUT FORM")
		CREATE RECORD:C68([DCM_ProjDailys:143])
		Inc_Sequence("DCMProjDailys"; ->[DCM_ProjDailys:143]DailyID_L:2)
		[DCM_ProjDailys:143]DailyDate_d:3:=Current date:C33(*)
		[DCM_ProjDailys:143]ProjectID:1:=[DCM_Project:138]ProjectID:1
		DIALOG:C40([DCM_ProjDailys:143]; "DistrInput")
		UNLOAD RECORD:C212([DCM_ProjDailyHrs:142])
		UNLOAD RECORD:C212([DCM_ProjDailyItems:144])
		DCM_ProjDailyControl_OM("LOAD")
		DCM_ProjDailyControl_OM("CALCALL")
		
	: ($Task_txt="DEL")
		C_LONGINT:C283($RowSel_L; $Ret_L)
		$RowSel_L:=DCM_ProjDailyID_aL
		If ($RowSel_L>0)
			C_TEXT:C284($msg_txt)
			$msg_txt:="Delete Daily entry for :"+String:C10(DCM_ProjDailyDate_aD{$RowSel_L}; Internal date short:K1:7)+"?"
			CONFIRM:C162($msg_txt; "DELETE"; "CANCEL")
			If (OK=1)
				GOTO SELECTED RECORD:C245([DCM_ProjDailys:143]; $RowSel_L)
				If (ut_LoadRecordInteractive(->[DCM_ProjDailys:143]))
					//delete related dailyprojitems and dailyprojitemhrs
					C_BOOLEAN:C305($ValidateTrans_b)
					$ValidateTrans_b:=True:C214
					START TRANSACTION:C239
					RELATE MANY:C262([DCM_ProjDailys:143]DailyID_L:2)
					RELATE MANY SELECTION:C340([DCM_ProjDailyHrs:142]DailyIItemD_L:1)
					DELETE SELECTION:C66([DCM_ProjDailyHrs:142])
					If (Records in set:C195("LockedSet")>0)
						C_TEXT:C284($msg_txt)
						$msg_txt:="There are Daily Hour records that are locked in the DB and cannot be deleted!"
						$msg_txt:=$msg_txt+" You will have to delete this Daily Entry at a later time!"
						ALERT:C41($msg_txt)
						$ValidateTrans_b:=False:C215
					End if 
					DELETE SELECTION:C66([DCM_ProjDailyItems:144])
					If (Records in set:C195("LockedSet")>0)
						C_TEXT:C284($msg_txt)
						$msg_txt:="There are Daily Item Quantity records that are locked in the DB and cannot be del"+"eted!"
						$msg_txt:=$msg_txt+" You will have to delete this Daily Entry at a later time!"
						ALERT:C41($msg_txt)
						$ValidateTrans_b:=False:C215
					End if 
					If ($ValidateTrans_b)
						DELETE RECORD:C58([DCM_ProjDailys:143])
						VALIDATE TRANSACTION:C240
					Else 
						CANCEL TRANSACTION:C241
					End if 
					DCM_ProjDailyControl_OM("LOAD")
					DCM_ProjDailyControl_OM("CALCALL")
				Else 
					ALERT:C41("Could not Delete Daily Record for "+String:C10([DCM_ProjDailys:143]DailyDate_d:3; Internal date short:K1:7))
				End if 
				
			End if 
			
		End if 
		
	: ($Task_txt="LOAD")
		ARRAY LONGINT:C221(DCM_ProjDailyID_aL; 0)
		ARRAY DATE:C224(DCM_ProjDailyDate_aD; 0)
		ARRAY TEXT:C222(DCM_ProjDailyCmts_atxt; 0)
		ARRAY BOOLEAN:C223(DCM_ProjDailys_LB; 0)
		RELATE MANY:C262([DCM_Project:138]ProjectID:1)
		ORDER BY:C49([DCM_ProjDailys:143]; [DCM_ProjDailys:143]DailyDate_d:3; <)
		SELECTION TO ARRAY:C260([DCM_ProjDailys:143]DailyID_L:2; DCM_ProjDailyID_aL; [DCM_ProjDailys:143]DailyDate_d:3; DCM_ProjDailyDate_aD; [DCM_ProjDailys:143]Comments_txt:4; DCM_ProjDailyCmts_atxt)
		LISTBOX SELECT ROW:C912(DCM_ProjDailys_LB; 0; lk remove from selection:K53:3)
		
	: ($Task_txt="SAVE")
		
	: ($Task_txt="LB")
		Case of 
			: ($FormEvent_L=On Load:K2:1)
				//Load arrays 
				DCM_ProjDailyControl_OM("LOAD")
				
			: ($FormEvent_L=On Double Clicked:K2:5)
				C_LONGINT:C283($RowSel_L; $Ret_L)
				$RowSel_L:=DCM_ProjDailyID_aL
				If ($RowSel_L>0)
					ARRAY LONGINT:C221($origIDs_aL; Records in selection:C76([DCM_ProjDailys:143]))
					SELECTION TO ARRAY:C260([DCM_ProjDailys:143]DailyID_L:2; $origIDs_aL)
					C_LONGINT:C283($PosInSel_L)
					$PosInSel_L:=Find in array:C230($origIDs_aL; DCM_ProjDailyID_aL{$RowSel_L})
					GOTO SELECTED RECORD:C245([DCM_ProjDailys:143]; $PosInSel_L)
					If (ut_LoadRecordInteractive(->[DCM_ProjDailys:143]))
						C_LONGINT:C283($WW_L; $WH_L)
						ARRAY TEXT:C222(DCM_DailyItemsNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
						ARRAY LONGINT:C221(DCM_DailyItemIDs_aL; 0)
						RELATE MANY:C262([DCM_ProjDailys:143]DailyID_L:2)
						SELECTION TO ARRAY:C260([DCM_ProjDailyItems:144]DailyItemID_L:2; DCM_DailyItemIDs_aL; [DCM_ProjDailyItems:144]ItemNo_s:3; DCM_DailyItemsNos_as)
						RELATE MANY SELECTION:C340([DCM_ProjDailyHrs:142]DailyIItemD_L:1)
						FORM GET PROPERTIES:C674([DCM_ProjDailys:143]; "DistrInput"; $WW_L; $WH_L)
						NewWindow($WW_L; $WH_L; 0; Plain no zoom box window:K34:1; "DAILY INPUT FORM")
						DIALOG:C40([DCM_ProjDailys:143]; "DistrInput")
						DCM_ProjDailyControl_OM("LOAD")
						DCM_ProjDailyControl_OM("CALCALL")
					Else 
						$msg_txt:="THE DAILY RECORD COULD NOT BE LOADED FOR EDITING!!!!"
						ALERT:C41($msg_txt)
					End if 
				End if 
				
			: ($FormEvent_L=On Clicked:K2:4)
				C_LONGINT:C283($RowSel_L; $Ret_L)
				$RowSel_L:=DCM_ProjDailyID_aL
				If ($RowSel_L>0)
					If ((Right click:C712) | (Macintosh control down:C544))
						C_TEXT:C284($PopMenuCmds_txt)
						
						$PopMenuCmds_txt:=". Choises for "+String:C10(DCM_ProjDailyDate_aD{$RowSel_L}; Internal date short:K1:7)
						$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Delete All info"
						$PopMenuCmds_txt:=Replace string:C233($PopMenuCmds_txt; "/"; "-")
						C_LONGINT:C283($Ret_L)
						$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
						Case of 
							: ($Ret_L=2)
								DCM_ProjDailyControl_OM("DEL")
							: ($Ret_L=3)
								
							: ($Ret_L=4)
								
						End case 
						
					End if 
					
				End if 
				
		End case 
		
	: ($Task_txt="CALCALL")
		RELATE MANY:C262([DCM_Project:138]ProjectID:1)
		RELATE MANY SELECTION:C340([DCM_ProjDailyItems:144]DailyID_L:1)
		If (Records in selection:C76([DCM_ProjDailyItems:144])>0)
			C_LONGINT:C283($NumDailyItems_L; $loop_L; $ItemIndx_L)
			$NumDailyItems_L:=Records in selection:C76([DCM_ProjDailyItems:144])
			ARRAY TEXT:C222($DailyItems_as; 0)  //Command Replaced was o_ARRAY string length was 7
			DISTINCT VALUES:C339([DCM_ProjDailyItems:144]ItemNo_s:3; $DailyItems_as)
			ARRAY REAL:C219($DailyItemQTotals_ar; Size of array:C274($DailyItems_as))
			ARRAY REAL:C219($DailyItemQs_ar; $NumDailyItems_L)
			ARRAY TEXT:C222($DailyItemNos_as; $NumDailyItems_L)  //Command Replaced was o_ARRAY string length was 7
			SELECTION TO ARRAY:C260([DCM_ProjDailyItems:144]ItemNo_s:3; $DailyItemNos_as; [DCM_ProjDailyItems:144]ItemQuantity_r:4; $DailyItemQs_ar)
			For ($loop_L; 1; Size of array:C274($DailyItemNos_as))
				$ItemIndx_L:=Find in array:C230($DailyItems_as; $DailyItemNos_as{$loop_L})
				$DailyItemQTotals_ar{$ItemIndx_L}:=$DailyItemQTotals_ar{$ItemIndx_L}+$DailyItemQs_ar{$loop_L}
			End for 
			For ($loop_L; 1; Size of array:C274($DailyItems_as))
				$ItemIndx_L:=Find in array:C230(ITMLB_ItemNos_as; $DailyItems_as{$loop_L})
				DCM_P_ITMLB_ItemQEnt_ar{$ItemIndx_L}:=$DailyItemQTotals_ar{$loop_L}
			End for 
			DCM_P_ItemSum_r:=0
			For ($loop_L; 1; Size of array:C274(ITMLB_ItemPrice_ar))
				DCM_P_ItemSum_r:=DCM_P_ItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQEnt_ar{$loop_L})
			End for 
			
			[DCM_Project:138]District:8:=[DCM_Project:138]District:8  // mark change
			
		End if 
End case 