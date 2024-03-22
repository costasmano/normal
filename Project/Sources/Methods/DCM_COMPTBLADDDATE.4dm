//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 08:40:19
	// ----------------------------------------------------
	// Method: DCM_COMPTBLADDDATE
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_06  // CJ Miller`06/20/11, 10:22:53      ` Type all local variables for v11
End if 

Case of 
	: (DCM_COMPADDDATE_2=1)
		C_LONGINT:C283($NumDates_L; $NumRates_L)
		C_POINTER:C301($nextDate_ptr; $nextHDR_ptr; $nextReg_ptr)
		If ($NumDates_L<6)
			$NumDates_L:=LISTBOX Get number of columns:C831(DCM_CompTBLDates_ab)+1
			C_POINTER:C301($nextDate_ptr; $nextHDR_ptr; $nextReg_ptr)
			$nextDate_ptr:=Get pointer:C304("DCM_CompTBL_Dates_"+String:C10($NumDates_L)+"_ad")
			$nextHDR_ptr:=Get pointer:C304("DCM_CompTBL_DHdr_"+String:C10($NumDates_L)+"_L")
			ARRAY DATE:C224($nextDate_ptr->; 1)
			LISTBOX INSERT COLUMN:C829(DCM_CompTBLDates_ab; $NumDates_L; "DE EFFDATE"+String:C10($NumDates_L); $nextDate_ptr->; "NEXTHDR"+String:C10($NumDates_L); $nextHDR_ptr->)
			LISTBOX SET COLUMN WIDTH:C833($nextDate_ptr->; 160)
			OBJECT SET TITLE:C194($nextHDR_ptr->; "Date "+String:C10($NumDates_L))
			
			$NumRates_L:=LISTBOX Get number of columns:C831(DCM_CompTable_LB)+1
			$nextReg_ptr:=Get pointer:C304("DCM_CompTblREG_"+String:C10($NumDates_L)+"_ar")
			ARRAY REAL:C219($nextReg_ptr->; Size of array:C274(DCM_CompTable_LB))
			$nextHDR_ptr:=Get pointer:C304("DCM_CompTblREGHDR_"+String:C10($NumDates_L)+"_L")
			$nextHDR_ptr->:=0
			LISTBOX INSERT COLUMN:C829(DCM_CompTable_LB; $NumRates_L; "DE REGULAR"+String:C10($NumDates_L); $nextReg_ptr->; "REGHDR"+String:C10($NumDates_L); $NextHdr_ptr->)
			OBJECT SET TITLE:C194($nextHDR_ptr->; "REGULAR "+String:C10($NumDates_L))
			LISTBOX SET COLUMN WIDTH:C833($nextReg_ptr->; 80)
			$NumRates_L:=LISTBOX Get number of columns:C831(DCM_CompTable_LB)+1
			$nextReg_ptr:=Get pointer:C304("DCM_CompTblOT_"+String:C10($NumDates_L)+"_ar")
			ARRAY REAL:C219($nextReg_ptr->; Size of array:C274(DCM_CompTable_LB))
			$nextHDR_ptr:=Get pointer:C304("DCM_CompTblOTHDR_"+String:C10($NumDates_L)+"_L")
			$nextHDR_ptr->:=0
			LISTBOX INSERT COLUMN:C829(DCM_CompTable_LB; $NumRates_L; "DE OT"+String:C10($NumDates_L); $nextReg_ptr->; "OTHDR"+String:C10($NumDates_L); $NextHdr_ptr->)
			OBJECT SET TITLE:C194($nextHDR_ptr->; "OVERTIME "+String:C10($NumDates_L))
			LISTBOX SET COLUMN WIDTH:C833($nextReg_ptr->; 80)
			
			DCM_COMPTBLCHANGES_b:=True:C214
			
			C_LONGINT:C283($W_L; $W_T; $W_R; $W_B)
			GET WINDOW RECT:C443($W_L; $W_T; $W_R; $W_B)
			SET WINDOW RECT:C444($W_L; $W_T; ($W_R+170); $W_B)
			OBJECT MOVE:C664(DCM_CompTBLDates_ab; 0; 0; 160; 0)
			OBJECT MOVE:C664(DCM_CompTable_LB; 0; 0; 160; 0)
			OBJECT MOVE:C664(*; "DCMCOMPTABLELABEL@"; 0; 0; 160; 0)
			OBJECT SET ENABLED:C1123(*; "@HDR@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			EDIT ITEM:C870($nextDate_ptr->; 1)
		Else 
			ALERT:C41("Can only have up to 6 Effective Dates for the Compensation Rates!")
		End if 
		
	: (DCM_COMPADDDATE_2=2)
		C_LONGINT:C283($Col_L; $Row_L; $NumDates_L)
		C_POINTER:C301($ColVar_ptr; $RegRateArr_ptr; $OTRateArr_ptr; $RateArr_ptr)
		LISTBOX GET CELL POSITION:C971(DCM_CompTBLDates_ab; $Col_L; $Row_L; $ColVar_ptr)
		If ($Col_L>1)
			$NumDates_L:=LISTBOX Get number of columns:C831(DCM_CompTBLDates_ab)
			If ($Col_L=$NumDates_L)
				CONFIRM:C162("Delete Compensation Rates for Effective Date "+String:C10($ColVar_ptr->{1})+"?"; "Delete"; "Cancel")
				If (OK=1)
					$ColVar_ptr->{1}:=!00-00-00!
					LISTBOX DELETE COLUMN:C830(DCM_CompTBLDates_ab; $Col_L)
					ARRAY DATE:C224($ColVar_ptr->; 0)
					$RateArr_ptr:=Get pointer:C304("DCM_CompTblREG_"+String:C10($NumDates_L)+"_ar")
					$OTRateArr_ptr:=Get pointer:C304("DCM_CompTblOT_"+String:C10($NumDates_L)+"_ar")
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274($OTRateArr_ptr->))
						$RateArr_ptr->{$loop_L}:=0
						$OTRateArr_ptr->{$loop_L}:=0
					End for 
					$Col_L:=LISTBOX Get number of columns:C831(DCM_CompTable_LB)
					LISTBOX DELETE COLUMN:C830(DCM_CompTable_LB; ($Col_L-1); 2)
					ARRAY REAL:C219($RateArr_ptr->; 0)
					ARRAY REAL:C219($OTRateArr_ptr->; 0)
					OBJECT MOVE:C664(DCM_CompTable_LB; 0; 0; -160; 0)
					OBJECT MOVE:C664(*; "DCMCOMPTABLELABEL"; 0; 0; -160; 0)
					OBJECT MOVE:C664(DCM_CompTBLDates_ab; 0; 0; -160; 0)
					C_LONGINT:C283($W_L; $W_T; $W_R; $W_B)
					GET WINDOW RECT:C443($W_L; $W_T; $W_R; $W_B)
					SET WINDOW RECT:C444($W_L; $W_T; ($W_R-170); $W_B)
					DCM_COMPTBLCHANGES_b:=True:C214
					
				End if 
			Else 
				ALERT:C41("Can only delete last date!")
			End if 
			
		End if 
		
End case 
DCM_COMPADDDATE_2:=0