//%attributes = {"invisible":true}
//Method: NTI_ELEMSTATEPct_Entry
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/26/16, 16:38:53
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	// Modified by: Costas Manousakis-(Designer)-(1/12/18 16:51:04)
	Mods_2018_01
	//  `Calculate condition rating - only for main elements
	
End if 
//
// called from object method of [NTI_ELEM_BIN_INSP]ELEM_PCTSTATE@ on data change
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_POINTER:C301($Tbl_ptr)
		$Tbl_ptr:=Current form table:C627
		C_POINTER:C301($pcst1_ptr; $pcst2_ptr; $pcst3_ptr; $pcst4_ptr; $qt_ptr; $qt1_ptr; $qt2_ptr; $qt3_ptr; $qt4_ptr; $elemRtg_ptr)
		
		Case of 
			: ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
				$pcst1_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE1:12
				$pcst2_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE2:13
				$pcst3_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE3:14
				$pcst4_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE4:15
				$qt_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21
				$qt1_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17
				$qt2_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18
				$qt3_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19
				$qt4_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20
				$elemRtg_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_RATING:24
				
			: ($Tbl_ptr=(->[NTI_ELEM_TIN_INSP:185]))
				$pcst1_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12
				$pcst2_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13
				$pcst3_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14
				$pcst4_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
				$qt_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
				$qt1_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
				$qt2_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
				$qt3_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
				$qt4_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
				$elemRtg_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24
				
		End case 
		
		ARRAY POINTER:C280($CSQ_ptr; 4)
		$CSQ_ptr{1}:=$qt1_ptr
		$CSQ_ptr{2}:=$qt2_ptr
		$CSQ_ptr{3}:=$qt3_ptr
		$CSQ_ptr{4}:=$qt4_ptr
		
		ARRAY POINTER:C280($CSPCT_ptr; 4)
		$CSPCT_ptr{1}:=$pcst1_ptr
		$CSPCT_ptr{2}:=$pcst2_ptr
		$CSPCT_ptr{3}:=$pcst3_ptr
		$CSPCT_ptr{4}:=$pcst4_ptr
		
		If (PON_ELEM_Defect_b)  //defect
			
			C_LONGINT:C283($CS_L; $FirstCSQ_L)
			$FirstCSQ_L:=0
			C_REAL:C285($percentCheck_r)
			$percentCheck_r:=0
			For ($CS_L; 1; 4)
				If (PON_ElemNoQuantityFlag_L ?? $CS_L)
					//zero q in this state
					$CSQ_ptr{$CS_L}->:=0
					$CSPCT_ptr{$CS_L}->:=0
				Else 
					
					If ($FirstCSQ_L=0)
						//this is first state with non-zero q - will calc pct at the end
						$FirstCSQ_L:=$CS_L
					Else 
						$CSPCT_ptr{$CS_L}->:=Round:C94($CSPCT_ptr{$CS_L}->; PON_RoundP_L)
						$percentCheck_r:=$percentCheck_r+($CSPCT_ptr{$CS_L}->)
					End if 
					
				End if 
			End for 
			
			If ($percentCheck_r>100)
				ALERT:C41("Cannot have more than a total of 100% in Condition States above "+String:C10($FirstCSQ_L))
			Else 
				$CSPCT_ptr{$FirstCSQ_L}->:=100-$percentCheck_r
				$CSQ_ptr{$FirstCSQ_L}->:=$qt_ptr->  //start with total Q
				
				//calculate state Qs
				For ($CS_L; $FirstCSQ_L+1; 4)
					
					If (PON_ElemNoQuantityFlag_L ?? $CS_L)
					Else 
						$CSQ_ptr{$CS_L}->:=Round:C94(($qt_ptr->)*(($CSPCT_ptr{$CS_L}->)/100); PON_RoundQ_L)
						$CSQ_ptr{$FirstCSQ_L}->:=($CSQ_ptr{$FirstCSQ_L}->)-($CSQ_ptr{$CS_L}->)
					End if 
					
				End for 
				
			End if 
			
		Else   // normal element
			
			$pcst3_ptr->:=Round:C94($pcst3_ptr->; PON_RoundP_L)
			$pcst4_ptr->:=Round:C94($pcst4_ptr->; PON_RoundP_L)
			$pcst2_ptr->:=Round:C94(($pcst2_ptr->); PON_RoundP_L)
			If (($pcst2_ptr->)+($pcst3_ptr->)+($pcst4_ptr->))>100
				ALERT:C41("Cannot enter more than a total of 100% in States 2,3,4")
			Else 
				$pcst1_ptr->:=100-($pcst2_ptr->)-($pcst3_ptr->)-($pcst4_ptr->)
				$qt2_ptr->:=Round:C94(($qt_ptr->)*(($pcst2_ptr->)/100); PON_RoundQ_L)
				$qt3_ptr->:=Round:C94(($qt_ptr->)*(($pcst3_ptr->)/100); PON_RoundQ_L)
				$qt4_ptr->:=Round:C94(($qt_ptr->)*(($pcst3_ptr->)/100); PON_RoundQ_L)
				$qt1_ptr->:=($qt_ptr->)-($qt2_ptr->)-($qt3_ptr->)-($qt4_ptr->)
				$elemRtg_ptr->:=NTI_CalculateRating($qt_ptr->; $qt1_ptr->; $qt2_ptr->; $qt3_ptr->; $qt4_ptr->)
				
			End if 
			
		End if 
		
End case 

//End NTI_ELEMSTATEPct_Entry