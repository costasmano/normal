//Method: Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_LB1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/07/15, 17:34:45
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
End if 
//
C_LONGINT:C283($row_L; $col_L; $choise_L)
C_TEXT:C284($popmenu)

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		LISTBOX GET CELL POSITION:C971(*; "NBESearch_LB1"; $col_L; $row_L)
		
		Case of 
			: (($row_L=0) & ($col_L=1))
				C_TEXT:C284($popmenu)
				//build the popup menu from array
				//$popmenu:=" ;ANY;10 - elem 10;20 - elem 20;30 - elem 30"
				$popmenu:=ut_ArrayToPopupMenu(->SRC_PON_ELEMSELECTLB1_atxt)
				$popmenu:=Replace string:C233($popmenu; " clear..."; " ")
				$choise_L:=Pop up menu:C542($popmenu)
				Case of 
					: ($choise_L>1)
						If (Find in array:C230(NBESRC_LB1_ElemKey_aL; SRC_PON_ELEMSELECTLB1_aL{$choise_L})>0)
							ALERT:C41("Chosen element already in the list of Prot. Systems / Defects!")
						Else 
							LISTBOX INSERT ROWS:C913(*; "NBESearch_LB1"; Size of array:C274(NBESearch_LB1)+1)
							NBESRC_LB1_ElemKey_aL{Size of array:C274(NBESearch_LB1)}:=SRC_PON_ELEMSELECTLB1_aL{$choise_L}
							NBESRC_LB1_Descr_atxt{Size of array:C274(NBESearch_LB1)}:=SRC_PON_ELEMSELECTLB1_atxt{$choise_L}
							REDRAW:C174(NBESearch_LB1)
						End if 
						
				End case 
			: ($row_L>0)
				Case of 
					: ($col_L=1)
						$popmenu:=ut_ArrayToPopupMenu(->SRC_PON_ELEMSELECTLB1_atxt)
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								If (Find in array:C230(NBESRC_LB1_ElemKey_aL; SRC_PON_ELEMSELECTLB1_aL{$choise_L})>0)
									If (Find in array:C230(NBESRC_LB1_ElemKey_aL; SRC_PON_ELEMSELECTLB1_aL{$choise_L})#$row_L)
										ALERT:C41("Chosen element already in the list of Prot. Systems / Defects!")
									Else 
									End if 
								Else 
									NBESRC_LB1_ElemKey_aL{$row_L}:=SRC_PON_ELEMSELECTLB1_aL{$choise_L}
									NBESRC_LB1_Descr_atxt{$row_L}:=SRC_PON_ELEMSELECTLB1_atxt{$choise_L}
									REDRAW:C174(NBESearch_LB1)
								End if 
							: ($choise_L=1)
								LISTBOX DELETE ROWS:C914(*; "NBESearch_LB1"; $row_L)
								REDRAW:C174(NBESearch_LB1)
								
						End case 
						
					: ($col_L=3)  //total quantity operator
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;EQ;GT;GTE;LT;LTE"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB1_TotQ_atxt{$row_L}:=$lists_{$choise_L}
								// OBJECT SET ENTERABLE(NBESRC_LB1_TotQV_ar;True)
								REDRAW:C174(NBESearch_LB1)
							: ($choise_L=1)
								NBESRC_LB1_TotQ_atxt{$row_L}:=""
								NBESRC_LB1_TotQV_ar{$row_L}:=0
								// OBJECT SET ENTERABLE(NBESRC_LB1_TotQV_ar;False)
								REDRAW:C174(NBESearch_LB1)
						End case 
						
					: ($col_L=4)
						// total q value
						If (NBESRC_LB1_TotQ_atxt{$row_L}#"")
							OBJECT SET ENTERABLE:C238(NBESRC_LB1_TotQV_ar; True:C214)
							EDIT ITEM:C870(NBESRC_LB1_TotQV_ar; $row_L)
						Else 
							OBJECT SET ENTERABLE:C238(NBESRC_LB1_TotQV_ar; False:C215)
							
						End if 
					: ($col_L=5)
						// state operation
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;In State;At Most State;At State and After;Past State;Before State"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB1_State_atxt{$row_L}:=$lists_{$choise_L}
								REDRAW:C174(NBESearch_LB1)
							: ($choise_L=1)
								NBESRC_LB1_State_atxt{$row_L}:=""
								NBESRC_LB1_StateN_aL{$row_L}:=0
								REDRAW:C174(NBESearch_LB1)
						End case 
					: ($col_L=6)
						// state
						If (NBESRC_LB1_State_atxt{$row_L}#"")
							ARRAY TEXT:C222($lists_; 0)
							$popmenu:="1;2;3;4"
							ut_TextToArray($popmenu; ->$lists_; ";")
							$choise_L:=Pop up menu:C542($popmenu)
							Case of 
								: ($choise_L>0)
									NBESRC_LB1_StateN_aL{$row_L}:=Num:C11($lists_{$choise_L})
									REDRAW:C174(NBESearch_LB1)
							End case 
						End if 
					: ($col_L=7)
						// state quantity relation
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;EQ;GT;GTE;LT;LTE"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB1_StateQ_atxt{$row_L}:=$lists_{$choise_L}
								// OBJECT SET ENTERABLE(arr7;True)
								REDRAW:C174(NBESearch_LB1)
							: ($choise_L=1)
								NBESRC_LB1_StateQ_atxt{$row_L}:=""
								NBESRC_LB1_StateQV_ar{$row_L}:=0
								// OBJECT SET ENTERABLE(arr7;False)
								REDRAW:C174(NBESearch_LB1)
						End case 
					: ($col_L=8)
						// state total q value
						If (NBESRC_LB1_StateQ_atxt{$row_L}#"")
							OBJECT SET ENTERABLE:C238(NBESRC_LB1_StateQV_ar; True:C214)
							EDIT ITEM:C870(NBESRC_LB1_StateQV_ar; $row_L)
						Else 
							OBJECT SET ENTERABLE:C238(NBESRC_LB1_StateQV_ar; False:C215)
						End if 
						
				End case 
				
		End case 
		
End case 

//End Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_LB1