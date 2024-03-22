//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/11, 16:48:15
	// ----------------------------------------------------
	// Method: DCM_DailyControl_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT")
	// $2 : $FormEvent_L (Optional)
	// ----------------------------------------------------
	
	Mods_2011_02
	// Modified by: costasmanousakis-(Designer)-(9/20/11 16:59:40)
	Mods_2011_09
	//  `Added short message on the SAVE task
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
		C_TEXT:C284($PopMenuCmds_txt)
		$PopMenuCmds_txt:=". Choose an Artisan..."
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_CompTblArtisan_atxt))
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+DCM_CompTblArtisan_atxt{$loop_L}
		End for 
		C_LONGINT:C283($Ret_L; $Rows_L)
		$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
		If ($Ret_L>1)
			If (Find in array:C230(DCM_DailyArtisan_atxt; DCM_CompTblArtisan_atxt{$Ret_L-1})>0)
				ALERT:C41("There is already an entry for "+DCM_CompTblArtisan_atxt{$Ret_L-1}+"!")
			Else 
				
				$Rows_L:=Size of array:C274(DCM_DailyArtisanID_aL)+1
				LISTBOX INSERT ROWS:C913(DCM_Daily_LB; $Rows_L)
				DCM_DailyArtisanID_aL{$Rows_L}:=DCM_CompTblArtisanNo_aL{$Ret_L-1}
				DCM_DailyArtisan_atxt{$Rows_L}:=DCM_CompTblArtisan_atxt{$Ret_L-1}
				EDIT ITEM:C870(DCM_DailyArtisanReg_ar; $Rows_L)
				
			End if 
		End if 
		
	: ($Task_txt="DEL")
		C_LONGINT:C283($RowSel_L)
		$RowSel_L:=DCM_DailyArtisan_atxt
		If ($RowSel_L>0)
			C_TEXT:C284($msg_txt)
			$msg_txt:="Delete Entries for "+DCM_DailyArtisan_atxt{$RowSel_L}+" ?"
			CONFIRM:C162($msg_txt; "Delete"; "Cancel")
			If (OK=1)
				LISTBOX DELETE ROWS:C914(DCM_Daily_LB; $RowSel_L)
				DCM_DailyControl_OM("CALCHRS")
			End if 
			
		End if 
		
	: ($Task_txt="LOAD")
		ARRAY LONGINT:C221(DCM_DailyArtisanID_aL; 0)
		ARRAY REAL:C219(DCM_DailyArtisanReg_ar; 0)
		ARRAY REAL:C219(DCM_DailyArtisanOT_ar; 0)
		ARRAY REAL:C219(DCM_DailyArtisanNet_ar; 0)
		ARRAY TEXT:C222(DCM_DailyArtisan_atxt; 0)
		C_LONGINT:C283($loop_L; $ArtisanIdx_L; $StoredRecs_L)
		RELATE MANY:C262([DCM_ProjDailys:143]DailyID_L:2)
		RELATE MANY SELECTION:C340([DCM_ProjDailyHrs:142]DailyIItemD_L:1)
		SELECTION TO ARRAY:C260([DCM_ProjDailyHrs:142]ArtisanNo_L:3; DCM_DailyArtisanID_aL; [DCM_ProjDailyHrs:142]RegHrs_r:4; DCM_DailyArtisanReg_ar; [DCM_ProjDailyHrs:142]OTHrs_r:5; DCM_DailyArtisanOT_ar)
		$StoredRecs_L:=Size of array:C274(DCM_DailyArtisanID_aL)
		ARRAY TEXT:C222(DCM_DailyArtisan_atxt; $StoredRecs_L)
		ARRAY REAL:C219(DCM_DailyArtisanNet_ar; $StoredRecs_L)
		REDRAW:C174(DCM_Daily_LB)
		For ($loop_L; $StoredRecs_L; 1; -1)
			$ArtisanIdx_L:=Find in array:C230(DCM_CompTblArtisanNo_aL; DCM_DailyArtisanID_aL{$loop_L})
			If ($ArtisanIdx_L>0)
				DCM_DailyArtisan_atxt{$loop_L}:=DCM_CompTblArtisan_atxt{$ArtisanIdx_L}
			Else 
				C_TEXT:C284($msg_txt)
				$msg_txt:="Artisan ID "+String:C10(DCM_DailyArtisanID_aL{$loop_L})
				If (DCM_DailyArtisanReg_ar{$loop_L}>0)
					$msg_txt:=$msg_txt+" Reg Hrs: "+String:C10(DCM_DailyArtisanReg_ar{$loop_L})
				End if 
				If (DCM_DailyArtisanOT_ar{$loop_L}>0)
					$msg_txt:=$msg_txt+" OT Hrs: "+String:C10(DCM_DailyArtisanOT_ar{$loop_L})
				End if 
				$msg_txt:=$msg_txt+"  not found! Related Entries will be deleted!"
				ALERT:C41($msg_txt)
				LISTBOX DELETE ROWS:C914(DCM_Daily_LB; $loop_L)
			End if 
		End for 
		DCM_DailyControl_OM("CALCHRS")
		
	: ($Task_txt="SAVE")
		SAVE RECORD:C53([DCM_ProjDailys:143])
		C_LONGINT:C283($numArtisans_L; $Loop_L)
		C_TEXT:C284($msg_txt)
		SHORT_MESSAGE("Saving Data...")
		$numArtisans_L:=LISTBOX Get number of rows:C915(DCM_Daily_LB)
		FIRST RECORD:C50([DCM_ProjDailyHrs:142])
		While (Not:C34(End selection:C36([DCM_ProjDailyHrs:142])))
			If (Find in array:C230(DCM_DailyArtisanID_aL; [DCM_ProjDailyHrs:142]ArtisanNo_L:3)>0)
			Else 
				DELETE RECORD:C58([DCM_ProjDailyHrs:142])
			End if 
			
			NEXT RECORD:C51([DCM_ProjDailyHrs:142])
		End while 
		SELECTION TO ARRAY:C260([DCM_ProjDailyHrs:142]ArtisanNo_L:3; $ArtisansLeft_aL)
		C_LONGINT:C283($BaseLaborRec_L; $BaseLaborItmNo_L; $ContrItem_L; $BaseLaborItemID_L)
		If ($numArtisans_L>0)
			//first verify we have an Items record for Base Labor
			
			$ContrItem_L:=Find in array:C230(ITMLB_ItemDesc_atxt; "BASE LABOR@")
			If ($ContrItem_L>0)
				$BaseLaborRec_L:=Find in array:C230(DCM_DailyItemsNos_as; ITMLB_ItemNos_as{$ContrItem_L})
				If ($BaseLaborRec_L>0)
					//Found a Daily Item for the base labot rate - we need the ID
					$BaseLaborItemID_L:=DCM_DailyItemIDs_aL{$BaseLaborRec_L}
					GOTO SELECTED RECORD:C245([DCM_ProjDailyItems:144]; $BaseLaborRec_L)
				Else 
					//need to create one and add to list of arrays
					CREATE RECORD:C68([DCM_ProjDailyItems:144])
					Inc_Sequence("DCM_ProjDailyItems"; ->[DCM_ProjDailyItems:144]DailyItemID_L:2)
					[DCM_ProjDailyItems:144]DailyID_L:1:=[DCM_ProjDailys:143]DailyID_L:2
					[DCM_ProjDailyItems:144]ItemNo_s:3:=ITMLB_ItemNos_as{$ContrItem_L}
					SAVE RECORD:C53([DCM_ProjDailyItems:144])
					APPEND TO ARRAY:C911(DCM_DailyItemsNos_as; ITMLB_ItemNos_as{$ContrItem_L})
					APPEND TO ARRAY:C911(DCM_DailyItemIDs_aL; [DCM_ProjDailyItems:144]DailyItemID_L:2)
					$BaseLaborItemID_L:=[DCM_ProjDailyItems:144]DailyItemID_L:2
					//UNLOAD RECORD([DCM_ProjDailyItems])
				End if 
				C_LONGINT:C283($ArtisanIndx_L)
				If ($numArtisans_L>0)
					
					For ($Loop_L; 1; $numArtisans_L)
						$ArtisanIndx_L:=Find in array:C230($ArtisansLeft_aL; DCM_DailyArtisanID_aL{$Loop_L})
						If ($ArtisanIndx_L>0)
							//found existing record - update it
							GOTO SELECTED RECORD:C245([DCM_ProjDailyHrs:142]; $ArtisanIndx_L)
							If (ut_LoadRecordInteractive(->[DCM_ProjDailyHrs:142]))
								[DCM_ProjDailyHrs:142]OTHrs_r:5:=DCM_DailyArtisanOT_ar{$Loop_L}
								[DCM_ProjDailyHrs:142]RegHrs_r:4:=DCM_DailyArtisanReg_ar{$Loop_L}
								SAVE RECORD:C53([DCM_ProjDailyHrs:142])
							Else 
								ALERT:C41("Could Save Hour changes for "+DCM_DailyArtisan_atxt{$Loop_L})
								LOAD RECORD:C52([DCM_ProjDailyHrs:142])
								DCM_DailyArtisanOT_ar{$Loop_L}:=[DCM_ProjDailyHrs:142]OTHrs_r:5
								DCM_DailyArtisanReg_ar{$Loop_L}:=[DCM_ProjDailyHrs:142]RegHrs_r:4
							End if 
							
						Else 
							//need to add the record
							CREATE RECORD:C68([DCM_ProjDailyHrs:142])
							[DCM_ProjDailyHrs:142]DailyIItemD_L:1:=$BaseLaborItemID_L
							[DCM_ProjDailyHrs:142]ArtisanNo_L:3:=DCM_DailyArtisanID_aL{$Loop_L}
							[DCM_ProjDailyHrs:142]OTHrs_r:5:=DCM_DailyArtisanOT_ar{$Loop_L}
							[DCM_ProjDailyHrs:142]RegHrs_r:4:=DCM_DailyArtisanReg_ar{$Loop_L}
							SAVE RECORD:C53([DCM_ProjDailyHrs:142])
						End if 
						
					End for 
					
				Else 
					
				End if 
				//calculate things again
				DCM_DailyControl_OM("CALCHRS")
				If (ut_LoadRecordInteractive(->[DCM_ProjDailyItems:144]))
					[DCM_ProjDailyItems:144]ItemQuantity_r:4:=DCM_DailyNetTotal_r
					SAVE RECORD:C53([DCM_ProjDailyItems:144])
				Else 
					$msg_txt:="The Record for Daily Use Item "+ITMLB_ItemNos_as{$ContrItem_L}+" Could not be updated!"
				End if 
				
			Else 
				$msg_txt:="THERE IS NO BASE LABOR ITEM IN THE LIST OF BID ITEMS FOR THIS CONTRACT!!!!"
				$msg_txt:=$msg_txt+" THE HOUR DATA ENTERED CANNOT BE SAVED!!!"
				ALERT:C41($msg_txt)
			End if 
			
		End if 
		CLOSE WINDOW:C154
		
	: ($Task_txt="CLOSE")
		If (Modified record:C314([DCM_ProjDailys:143]))
			CONFIRM:C162("Daily info has been modified! Close without saving or Cancel Close?"; "Close w/out Save"; "Cancel")
			If (OK=1)
				ACCEPT:C269
			End if 
		Else 
			ACCEPT:C269
		End if 
		
	: ($Task_txt="LB")
		Case of 
			: ($FormEvent_L=On Load:K2:1)
				DCM_DailyControl_OM("SETRATEARRPTRS")
				DCM_DailyControl_OM("LOAD")
				
			: ($FormEvent_L=On Data Change:K2:15)
				[DCM_ProjDailys:143]DailyDate_d:3:=DCM_DailyDate_d  //mark change
				
			: ($FormEvent_L=On Clicked:K2:4)
				C_LONGINT:C283($RowSel_L; $Ret_L)
				$RowSel_L:=DCM_DailyArtisan_atxt
				If ($RowSel_L>0)
					If ((Right click:C712) | (Macintosh control down:C544))
						C_TEXT:C284($PopMenuCmds_txt)
						//
						$PopMenuCmds_txt:=". Choises for"+DCM_DailyArtisan_atxt{$RowSel_L}
						$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Reg Hrs"
						$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit OT Hrs"
						//
						C_LONGINT:C283($Ret_L)
						$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
						Case of 
							: ($Ret_L=2)
								EDIT ITEM:C870(DCM_DailyArtisanReg_ar; $RowSel_L)  //
							: ($Ret_L=3)
								EDIT ITEM:C870(DCM_DailyArtisanOT_ar; $RowSel_L)  //
						End case 
						//
					End if 
					//
				End if 
		End case 
		
	: ($Task_txt="CALCHRS")
		C_LONGINT:C283($loop_L; $Dateloop_L; $ArtisanID_L)
		C_REAL:C285($TotalNet_r; $FactorReg_r; $FactorOT_r; DCM_DailyNetTotal_r)
		$TotalNet_r:=0
		For ($loop_L; 1; Size of array:C274(DCM_DailyArtisanReg_ar))
			$ArtisanID_L:=Find in array:C230(DCM_CompTblArtisanNo_aL; DCM_DailyArtisanID_aL{$loop_L})
			If ($ArtisanID_L>0)
				$FactorReg_r:=(DCM_DailyRegArr_ptr->{$ArtisanID_L})
				$FactorOT_r:=(DCM_DailyOTArr_ptr->{$ArtisanID_L})
				DCM_DailyArtisanNet_ar{$loop_L}:=(DCM_DailyArtisanReg_ar{$loop_L}*$FactorReg_r)+(DCM_DailyArtisanOT_ar{$loop_L}*$FactorOT_r)
				$TotalNet_r:=$TotalNet_r+DCM_DailyArtisanNet_ar{$loop_L}
				
			Else 
				ALERT:C41("Invalid Artisan Name ! "+DCM_DailyArtisan_atxt{$loop_L}+" ID:"+String:C10(DCM_DailyArtisanID_aL{$loop_L})+" Not in the list entered for this Contract!")
			End if 
			
		End for 
		DCM_DailyNetTotal_r:=$TotalNet_r
		
	: ($Task_txt="DATEENTRY")
		If ([DCM_Contracts:136]AwardContractDate:4>DCM_DailyDate_d)
			ALERT:C41("Date entered "+String:C10(DCM_DailyDate_d)+" is before Conctract Award date! "+String:C10([DCM_Contracts:136]AwardContractDate:4))
			REJECT:C38
			DCM_DailyDate_d:=[DCM_ProjDailys:143]DailyDate_d:3
			GOTO OBJECT:C206(DCM_DailyDate_d)
			OBJECT SET ENABLED:C1123(*; "DCM_Daily@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(DCM_DailyClose; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			[DCM_ProjDailys:143]DailyDate_d:3:=DCM_DailyDate_d  //mark change
			DCM_DailyControl_OM("SETRATEARRPTRS")
			OBJECT SET ENABLED:C1123(*; "DCM_Daily@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: ($Task_txt="COMMENTS")
		[DCM_ProjDailys:143]Comments_txt:4:=DCM_DailyComment_txt
		
	: ($Task_txt="SETRATEARRPTRS")
		C_POINTER:C301(DCM_DailyRegArr_ptr)
		C_POINTER:C301(DCM_DailyOTArr_ptr)
		C_DATE:C307(DCM_DailyRateDate_d)
		DCM_DailyRateDate_d:=!00-00-00!
		C_DATE:C307($date6_d; $date5_d; $date4_d; $date3_d; $date2_d; $date1_d)
		$date6_d:=!00-00-00!
		$date5_d:=!00-00-00!
		$date4_d:=!00-00-00!
		$date3_d:=!00-00-00!
		$date2_d:=!00-00-00!
		$date1_d:=!00-00-00!
		If (Size of array:C274(DCM_CompTBL_Dates_6_ad)>0)
			$date6_d:=DCM_CompTBL_Dates_6_ad{1}
		End if 
		If (Size of array:C274(DCM_CompTBL_Dates_5_ad)>0)
			$date5_d:=DCM_CompTBL_Dates_5_ad{1}
		End if 
		If (Size of array:C274(DCM_CompTBL_Dates_4_ad)>0)
			$date4_d:=DCM_CompTBL_Dates_4_ad{1}
		End if 
		If (Size of array:C274(DCM_CompTBL_Dates_3_ad)>0)
			$date3_d:=DCM_CompTBL_Dates_3_ad{1}
		End if 
		If (Size of array:C274(DCM_CompTBL_Dates_2_ad)>0)
			$date2_d:=DCM_CompTBL_Dates_2_ad{1}
		End if 
		If (Size of array:C274(DCM_CompTBL_Dates_1_ad)>0)
			$date1_d:=DCM_CompTBL_Dates_1_ad{1}
		End if 
		If (DCM_DailyDate_d#!00-00-00!)
			Case of 
				: (DCM_DailyDate_d>=$date6_d) & ($date6_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_6_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_6_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_6_ad{1}
				: (DCM_DailyDate_d>=$date5_d) & ($date5_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_5_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_5_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_5_ad{1}
				: (DCM_DailyDate_d>=$date4_d) & ($date4_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_4_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_4_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_4_ad{1}
				: (DCM_DailyDate_d>=$date3_d) & ($date3_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_3_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_3_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_3_ad{1}
				: (DCM_DailyDate_d>=$date2_d) & ($date2_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_2_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_2_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_2_ad{1}
				: (DCM_DailyDate_d>=$date1_d) & ($date1_d>!00-00-00!)
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_1_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_1_ar
					DCM_DailyRateDate_d:=DCM_CompTBL_Dates_1_ad{1}
				Else 
					DCM_DailyRegArr_ptr:=->DCM_CompTblREG_1_ar
					DCM_DailyOTArr_ptr:=->DCM_CompTblOT_1_ar
					ALERT:C41("Error Getting REG and OT Rates for "+String:C10(DCM_DailyDate_d))
					
			End case 
			
		End if 
		
End case 