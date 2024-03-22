//%attributes = {"invisible":true}
//Method: NTI_ELEMTSTATEQ_Entry
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 12:57:45
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(1/12/18 16:51:04)
	Mods_2018_01
	//  `Calculate condition rating - only for main elements
	// Modified by: Costas Manousakis-(Designer)-(1/22/18 10:24:08)
	Mods_2018_01
	//  `account for multiple noquantity states
End if 
//
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
		
		If (PON_ELEM_Defect_b)
			//NEEDCHANGESHERE:=True  //to account for multiple noquantity states
			C_LONGINT:C283($CS_L; $FirstCSQ_L)
			$FirstCSQ_L:=0
			For ($CS_L; 4; 1; -1)
				If (PON_ElemNoQuantityFlag_L ?? $CS_L)
					//zero q in this state
					$CSQ_ptr{$CS_L}->:=0
					$CSPCT_ptr{$CS_L}->:=0
				Else 
					$FirstCSQ_L:=$CS_L
				End if 
			End for 
			//for defects total q = sum of state qs
			$qt_ptr->:=($qt1_ptr->)+($qt2_ptr->)+($qt3_ptr->)+($qt4_ptr->)
			
			If (PON_ELEMUNIT_txt="percent")
				//must check that total q is not greater than 100
				If (($qt_ptr->)>100)
					//set total q to 100 and alert to change
					$qt_ptr->:=100
					ALERT:C41("Sum of Condition States 1,2,3,4 cannot exceed 100 % ! Total Defect Quantity has been set to 100! Please adjust data in the Condition States!")
				End if 
				
			End if 
			
			//calculate percent for all states except the first wth q
			$CSPCT_ptr{$FirstCSQ_L}->:=100
			For ($CS_L; $FirstCSQ_L+1; 4)
				$CSPCT_ptr{$CS_L}->:=Round:C94(100*($CSQ_ptr{$CS_L}->)/($qt_ptr->); PON_RoundP_L)
				$CSPCT_ptr{$FirstCSQ_L}->:=($CSPCT_ptr{$FirstCSQ_L}->)-($CSPCT_ptr{$CS_L}->)
			End for 
			
			If (False:C215)
				If (PON_ElemNoQuantState1_b)
					$qt1_ptr->:=0
				End if 
				$pcst2_ptr->:=Round:C94(100*($qt2_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst3_ptr->:=Round:C94(100*($qt3_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst4_ptr->:=Round:C94(100*($qt4_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst1_ptr->:=100-($pcst2_ptr->)-($pcst3_ptr->)-($pcst4_ptr->)
				
			End if 
			
		Else 
			
			If (($qt2_ptr->)+($qt3_ptr->)+($qt4_ptr->))>($qt_ptr->)
				ALERT:C41("The Sum of Quantities in States 2,3,4 cannot exceed the Total Quantity!")
			Else 
				($qt1_ptr->):=($qt_ptr->)-($qt2_ptr->)-($qt3_ptr->)-($qt4_ptr->)
				$pcst2_ptr->:=Round:C94(100*($qt2_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst3_ptr->:=Round:C94(100*($qt3_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst4_ptr->:=Round:C94(100*($qt4_ptr->)/($qt_ptr->); PON_RoundP_L)
				$pcst1_ptr->:=100-($pcst2_ptr->)-($pcst3_ptr->)-($pcst4_ptr->)
				$elemRtg_ptr->:=NTI_CalculateRating($qt_ptr->; $qt1_ptr->; $qt2_ptr->; $qt3_ptr->; $qt4_ptr->)
			End if 
			
		End if 
		
End case 

//End NTI_ELEMTSTATEQ_Entry