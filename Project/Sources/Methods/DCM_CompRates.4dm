//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 08:41:36
	// ----------------------------------------------------
	// Method: DCM_CompRates
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT" | "MODIFY" | "LOADLISTBOX" | "CLOSE")
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_06  // CJ Miller`06/20/11, 10:22:45      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_LONGINT:C283(DCM_COMPTBLMAXDATES_L)
		DCM_COMPTBLMAXDATES_L:=6
		ARRAY TEXT:C222(DCM_CompTblArtisan_atxt; 0)
		ARRAY LONGINT:C221(DCM_CompTblArtisanNo_aL; 0)
		ARRAY REAL:C219(DCM_CompTblREG_1_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_1_ar; 0)
		ARRAY REAL:C219(DCM_CompTblREG_2_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_2_ar; 0)
		ARRAY REAL:C219(DCM_CompTblREG_3_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_3_ar; 0)
		ARRAY REAL:C219(DCM_CompTblREG_4_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_4_ar; 0)
		ARRAY REAL:C219(DCM_CompTblREG_5_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_5_ar; 0)
		ARRAY REAL:C219(DCM_CompTblREG_6_ar; 0)
		ARRAY REAL:C219(DCM_CompTblOT_6_ar; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_1_ad; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_2_ad; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_3_ad; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_4_ad; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_5_ad; 0)
		ARRAY DATE:C224(DCM_CompTBL_Dates_6_ad; 0)
		
		C_LONGINT:C283(DCM_CompTblREGHDR_1_L; DCM_CompTblREGHDR_2_L; DCM_CompTblREGHDR_3_L; DCM_CompTblREGHDR_4_L; DCM_CompTblREGHDR_5_L; DCM_CompTblREGHDR_6_L)
		C_LONGINT:C283(DCM_CompTblOT_1_L; DCM_CompTblOT_2_L; DCM_CompTblOT_3_L; DCM_CompTblOT_4_L; DCM_CompTblOT_5_L; DCM_CompTblOT_6_L)
		C_LONGINT:C283(DCM_CompTBL_DHdr_1_L; DCM_CompTBL_DHdr_2_L; DCM_CompTBL_DHdr_3_L; DCM_CompTBL_DHdr_4_L; DCM_CompTBL_DHdr_5_L; DCM_CompTBL_DHdr_6_L)
		C_BOOLEAN:C305(DCM_COMPTBLCHANGES_b)
		DCM_COMPTBLCHANGES_b:=False:C215
		
	: ($Task_txt="MODIFY")
		C_LONGINT:C283($TTTT)
		$TTTT:=Open form window:C675([DCM_Contracts:136]; "CompRateTable")
		DIALOG:C40([DCM_Contracts:136]; "CompRateTable")
		CLOSE WINDOW:C154
		
	: ($Task_txt="LOAD")
		If (BLOB size:C605([DCM_Contracts:136]ContractRates_x:34)>0)
			C_LONGINT:C283($Offset_L)
			$Offset_L:=0
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblArtisan_atxt; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_1_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_1_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_2_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_2_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_3_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_3_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_4_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_4_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_5_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_5_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblREG_6_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblOT_6_ar; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_1_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_2_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_3_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_4_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_5_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTBL_Dates_6_ad; $Offset_L)
			BLOB TO VARIABLE:C533([DCM_Contracts:136]ContractRates_x:34; DCM_CompTblArtisanNo_aL; $Offset_L)
			If (Size of array:C274(DCM_CompTblArtisanNo_aL)#Size of array:C274(DCM_CompTblArtisan_atxt))
				ARRAY LONGINT:C221(DCM_CompTblArtisanNo_aL; Size of array:C274(DCM_CompTblArtisan_atxt))
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274(DCM_CompTblArtisanNo_aL))
					DCM_CompTblArtisanNo_aL{$loop_L}:=$loop_L
				End for 
			End if 
			
		Else 
			ARRAY DATE:C224(DCM_CompTBL_Dates_1_ad; 1)
			DCM_CompTBL_Dates_1_ad{1}:=[DCM_Contracts:136]AwardContractDate:4
		End if 
	: ($Task_txt="LOADLISTBOX")
		C_LONGINT:C283($loop_L; $NumRates_L)
		C_POINTER:C301($DateArr_ptr)
		For ($loop_L; 2; DCM_COMPTBLMAXDATES_L)
			$DateArr_ptr:=Get pointer:C304("DCM_CompTBL_Dates_"+String:C10($loop_L)+"_ad")
			If (Size of array:C274($DateArr_ptr->)>0)
				If ($DateArr_ptr->{1}#!00-00-00!)
					//Add the rows
					C_POINTER:C301($nextHDR_ptr; $nextReg_ptr)
					$nextHDR_ptr:=Get pointer:C304("DCM_CompTBL_DHdr_"+String:C10($loop_L)+"_L")
					LISTBOX INSERT COLUMN:C829(DCM_CompTBLDates_ab; $loop_L; "DE EFFDATE"+String:C10($loop_L); $DateArr_ptr->; "NEXTHDR"+String:C10($loop_L); $nextHDR_ptr->)
					LISTBOX SET COLUMN WIDTH:C833($DateArr_ptr->; 160)
					OBJECT SET TITLE:C194($nextHDR_ptr->; "Date "+String:C10($loop_L))
					$NumRates_L:=LISTBOX Get number of columns:C831(DCM_CompTable_LB)+1
					$nextReg_ptr:=Get pointer:C304("DCM_CompTblREG_"+String:C10($loop_L)+"_ar")
					$nextHDR_ptr:=Get pointer:C304("DCM_CompTblREGHDR_"+String:C10($loop_L)+"_L")
					$nextHDR_ptr->:=0
					LISTBOX INSERT COLUMN:C829(DCM_CompTable_LB; $NumRates_L; "DE REGULAR"+String:C10($loop_L); $nextReg_ptr->; "REGHDR"+String:C10($loop_L); $NextHdr_ptr->)
					OBJECT SET TITLE:C194($nextHDR_ptr->; "REGULAR "+String:C10($loop_L))
					LISTBOX SET COLUMN WIDTH:C833($nextReg_ptr->; 80)
					$NumRates_L:=LISTBOX Get number of columns:C831(DCM_CompTable_LB)+1
					$nextReg_ptr:=Get pointer:C304("DCM_CompTblOT_"+String:C10($loop_L)+"_ar")
					$nextHDR_ptr:=Get pointer:C304("DCM_CompTblOTHDR_"+String:C10($loop_L)+"_L")
					$nextHDR_ptr->:=0
					LISTBOX INSERT COLUMN:C829(DCM_CompTable_LB; $NumRates_L; "DE OT"+String:C10($loop_L); $nextReg_ptr->; "OTHDR"+String:C10($loop_L); $NextHdr_ptr->)
					OBJECT SET TITLE:C194($nextHDR_ptr->; "OVERTIME "+String:C10($loop_L))
					LISTBOX SET COLUMN WIDTH:C833($nextReg_ptr->; 80)
					OBJECT SET ENABLED:C1123(*; "@HDR@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					
				End if 
				
			End if 
			
		End for 
		$NumRates_L:=LISTBOX Get number of columns:C831(DCM_CompTBLDates_ab)
		If ($NumRates_L>1)
			$NumRates_L:=$NumRates_L-1
			C_LONGINT:C283($W_L; $W_T; $W_R; $W_B)
			GET WINDOW RECT:C443($W_L; $W_T; $W_R; $W_B)
			SET WINDOW RECT:C444($W_L; $W_T; ($W_R+(170*$NumRates_L)); $W_B)
			OBJECT MOVE:C664(DCM_CompTBLDates_ab; 0; 0; 160*$NumRates_L; 0)
			OBJECT MOVE:C664(DCM_CompTable_LB; 0; 0; 160*$NumRates_L; 0)
			OBJECT MOVE:C664(*; "DCMCOMPTABLELABEL"; 0; 0; 160*$NumRates_L; 0)
			
		End if 
		LISTBOX SELECT ROW:C912(DCM_CompTBLDates_ab; 0; lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(DCM_CompTable_LB; 0; lk remove from selection:K53:3)
		
	: ($Task_txt="SAVE")
		C_LONGINT:C283($NumDates_L)
		$NumDates_L:=LISTBOX Get number of columns:C831(DCM_CompTBLDates_ab)
		C_BOOLEAN:C305($DoSave_b)
		$DoSave_b:=True:C214
		If ($NumDates_L>1)
			C_LONGINT:C283($Loop_L)
			C_POINTER:C301($DateArr_ptr)
			For ($Loop_L; 2; $NumDates_L)
				$DateArr_ptr:=Get pointer:C304("DCM_CompTBL_Dates_"+String:C10($Loop_L)+"_ad")
				If ($DateArr_ptr->{1}=!00-00-00!)
					ALERT:C41("Cannot save with a blank Effective Date at No. "+String:C10($Loop_L)+" !!!")
					$DoSave_b:=False:C215
				End if 
				
			End for 
			
		End if 
		If ($DoSave_b)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(DCM_CompTblArtisan_atxt))
				If (DCM_CompTblArtisan_atxt{$loop_L}="")
					ALERT:C41("Blank Artisan Name!!!")
					$DoSave_b:=False:C215
					$loop_L:=Size of array:C274(DCM_CompTblArtisan_atxt)+1
				End if 
				
			End for 
			
		End if 
		If ($DoSave_b)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; (Size of array:C274(DCM_CompTblArtisan_atxt)-1))
				If (Find in array:C230(DCM_CompTblArtisan_atxt; DCM_CompTblArtisan_atxt{$loop_L}; ($loop_L+1))>0)
					ALERT:C41("Duplicate Artisan Name!!! "+DCM_CompTblArtisan_atxt{$loop_L})
					$DoSave_b:=False:C215
					$loop_L:=Size of array:C274(DCM_CompTblArtisan_atxt)+1
				End if 
				
			End for 
			
		End if 
		
		If ($DoSave_b)
			CONFIRM:C162("Save current list of Rate Compensation Table?")
			If (OK=1)
				VARIABLE TO BLOB:C532(DCM_CompTblArtisan_atxt; [DCM_Contracts:136]ContractRates_x:34)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_1_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_1_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_2_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_2_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_3_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_3_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_4_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_4_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_5_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_5_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblREG_6_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblOT_6_ar; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_1_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_2_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_3_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_4_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_5_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTBL_Dates_6_ad; [DCM_Contracts:136]ContractRates_x:34; *)
				VARIABLE TO BLOB:C532(DCM_CompTblArtisanNo_aL; [DCM_Contracts:136]ContractRates_x:34; *)
				DCM_COMPTBLCHANGES_b:=False:C215
			End if 
			
		End if 
		
	: ($Task_txt="CLOSE")
		If (DCM_COMPTBLCHANGES_b)
			CONFIRM:C162("Changes have been made! Closing will not save them!"; "Continue Closing?"; "Cancel")
			If (OK=1)
				DCM_CompRates("LOAD")  //load the saved ones
				DCM_COMPTBLCHANGES_b:=False:C215
				CANCEL:C270
			End if 
		Else 
			CANCEL:C270
		End if 
End case 