//Method: Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_LB2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/27/15, 14:05:47
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	// Modified by: Costas Manousakis-(Designer)-(4/22/19 16:24:08)
	Mods_2019_04_bug
	//  `remove extra call for a dynamic popup at the end of code for $col=1 
End if 
//

C_LONGINT:C283($row_L; $col_L; $choise_L)
C_TEXT:C284($popmenu)

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		LISTBOX GET CELL POSITION:C971(*; "NBESearch_LB2"; $col_L; $row_L)
		Case of 
			: (($row_L=0) & ($col_L=1))
				//Adding : find which prot sys is selected in lb1
				
				If (Size of array:C274(NBESearch_LB1)>0)
					C_LONGINT:C283($loop_L; $lb1sele_L)
					$lb1sele_L:=Find in array:C230(NBESearch_LB1; True:C214)
					If ($lb1sele_L>0)
						//check if a prot sys is selected
						
						If (Find in array:C230(PON_PROTSYSELEM_KEY_aL; NBESRC_LB1_ElemKey_aL{$lb1sele_L})>0)
							C_TEXT:C284($popmenu)
							//build the popup menu from array
							//$popmenu:=" ;ANY;10 - elem 10;20 - elem 20;30 - elem 30"
							PON_FindAllowedDefects(NBESRC_LB1_ElemKey_aL{$lb1sele_L}; ->SRC_PON_ELEMSELECTLB2_aL)
							If (Size of array:C274(SRC_PON_ELEMSELECTLB1_aL)>0)
								READ ONLY:C145([PON_ELEM_DEFS:178])
								QUERY WITH ARRAY:C644([PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB2_aL)
								SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_LONGNAME:11; SRC_PON_ELEMSELECTLB2_atxt; [PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB2_aL)
								SORT ARRAY:C229(SRC_PON_ELEMSELECTLB2_aL; SRC_PON_ELEMSELECTLB2_atxt)
								INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB2_aL; 1; 1)
								INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB2_atxt; 1; 1)
								SRC_PON_ELEMSELECTLB2_atxt{1}:=" "
								$popmenu:=ut_ArrayToPopupMenu(->SRC_PON_ELEMSELECTLB2_atxt)
								$choise_L:=Pop up menu:C542($popmenu)
								Case of 
									: ($choise_L>1)
										If (Find in array:C230(NBESRC_LB2_ElemKey_aL; SRC_PON_ELEMSELECTLB2_aL{$choise_L})>0)
											ALERT:C41("Chosen element already in the list of Prot. Systems / Defects!")
										Else 
											LISTBOX INSERT ROWS:C913(*; "NBESearch_LB2"; Size of array:C274(NBESearch_LB2)+1)
											NBESRC_LB2_PSYSKEY_aL{Size of array:C274(NBESearch_LB2)}:=NBESRC_LB1_ElemKey_aL{$lb1sele_L}
											NBESRC_LB2_ElemKey_aL{Size of array:C274(NBESearch_LB2)}:=SRC_PON_ELEMSELECTLB2_aL{$choise_L}
											NBESRC_LB2_Descr_atxt{Size of array:C274(NBESearch_LB2)}:=SRC_PON_ELEMSELECTLB2_atxt{$choise_L}
											REDRAW:C174(NBESearch_LB2)
										End if 
										
								End case 
							Else 
								ALERT:C41("Selected Protective System "+String:C10(NBESRC_LB1_ElemKey_aL{$lb1sele_L})+" does not have any associated defects!")
							End if 
							
						Else 
							
						End if 
						
						
					Else 
						ALERT:C41("Select a protective system from the list above!")
						
					End if 
				Else 
					//nothing to do...
				End if 
				
			: ($row_L>0)
				Case of 
					: ($col_L=1)
						//$popmenu:=" ;ANY;10 - elem 10;20 - elem 20;30 - elem 30"
						PON_FindAllowedDefects(NBESRC_LB2_PSYSKEY_aL{$row_L}; ->SRC_PON_ELEMSELECTLB2_aL)
						If (Size of array:C274(SRC_PON_ELEMSELECTLB1_aL)>0)
							READ ONLY:C145([PON_ELEM_DEFS:178])
							QUERY WITH ARRAY:C644([PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB2_aL)
							SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_LONGNAME:11; SRC_PON_ELEMSELECTLB2_atxt; [PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB2_aL)
							SORT ARRAY:C229(SRC_PON_ELEMSELECTLB2_aL; SRC_PON_ELEMSELECTLB2_atxt)
							INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB2_aL; 1; 1)
							INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB2_atxt; 1; 1)
							SRC_PON_ELEMSELECTLB2_atxt{1}:=" Clear..."
							$popmenu:=ut_ArrayToPopupMenu(->SRC_PON_ELEMSELECTLB2_atxt)
							$choise_L:=Pop up menu:C542($popmenu)
							Case of 
								: ($choise_L>1)
									//build combo of prot/defects
									ARRAY TEXT:C222($protsysDefect_atxt; Size of array:C274(NBESRC_LB2_ElemKey_aL))
									C_LONGINT:C283($loop_L)
									For ($loop_L; 1; Size of array:C274($protsysDefect_atxt))
										$protsysDefect_atxt{$loop_L}:=String:C10(NBESRC_LB2_PSYSKEY_aL{$loop_L})+";"+String:C10(NBESRC_LB2_ElemKey_aL{$loop_L})
									End for 
									
									If (Find in array:C230($protsysDefect_atxt; String:C10(NBESRC_LB2_PSYSKEY_aL{$row_L})+";"+String:C10(SRC_PON_ELEMSELECTLB2_aL{$choise_L}))>0)
										If (Find in array:C230($protsysDefect_atxt; String:C10(NBESRC_LB2_PSYSKEY_aL{$row_L})+";"+String:C10(SRC_PON_ELEMSELECTLB2_aL{$choise_L}))#$row_L)
											ALERT:C41("Chosen Prot system/defect combination already in the list of Prot. Systems / Defects!")
										Else 
										End if 
									Else 
										NBESRC_LB2_ElemKey_aL{$row_L}:=SRC_PON_ELEMSELECTLB2_aL{$choise_L}
										NBESRC_LB2_Descr_atxt{$row_L}:=SRC_PON_ELEMSELECTLB2_atxt{$choise_L}
										REDRAW:C174(NBESearch_LB2)
									End if 
								: ($choise_L=1)
									LISTBOX DELETE ROWS:C914(*; "NBESearch_LB2"; $row_L)
									REDRAW:C174(NBESearch_LB2)
									
							End case 
							
						Else 
							ALERT:C41("Selected Protective System "+String:C10(NBESRC_LB2_PSYSKEY_aL{$row_L})+" does not have any associated defects!")
						End if 
						
					: ($col_L=4)  //total quantity operator
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;EQ;GT;GTE;LT;LTE"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB2_TotQ_atxt{$row_L}:=$lists_{$choise_L}
								// OBJECT SET ENTERABLE(NBESRC_LB2_TotQV_ar;True)
								REDRAW:C174(NBESearch_LB2)
							: ($choise_L=1)
								NBESRC_LB2_TotQ_atxt{$row_L}:=""
								NBESRC_LB2_TotQV_ar{$row_L}:=0
								// OBJECT SET ENTERABLE(NBESRC_LB2_TotQV_ar;False)
								REDRAW:C174(NBESearch_LB2)
						End case 
						
					: ($col_L=5)
						// total q value
						If (NBESRC_LB2_TotQ_atxt{$row_L}#"")
							OBJECT SET ENTERABLE:C238(NBESRC_LB2_TotQV_ar; True:C214)
							EDIT ITEM:C870(NBESRC_LB2_TotQV_ar; $row_L)
						Else 
							OBJECT SET ENTERABLE:C238(NBESRC_LB2_TotQV_ar; False:C215)
							
						End if 
					: ($col_L=6)
						// state operation
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;In State;At Most State;At State and After;Past State;Before State"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB2_State_atxt{$row_L}:=$lists_{$choise_L}
								REDRAW:C174(NBESearch_LB2)
							: ($choise_L=1)
								NBESRC_LB2_State_atxt{$row_L}:=""
								NBESRC_LB2_StateN_aL{$row_L}:=0
								REDRAW:C174(NBESearch_LB2)
						End case 
					: ($col_L=7)
						// state
						If (NBESRC_LB2_State_atxt{$row_L}#"")
							ARRAY TEXT:C222($lists_; 0)
							$popmenu:="1;2;3;4"
							ut_TextToArray($popmenu; ->$lists_; ";")
							$choise_L:=Pop up menu:C542($popmenu)
							Case of 
								: ($choise_L>0)
									NBESRC_LB2_StateN_aL{$row_L}:=Num:C11($lists_{$choise_L})
									REDRAW:C174(NBESearch_LB2)
							End case 
						End if 
					: ($col_L=8)
						// state quantity relation
						ARRAY TEXT:C222($lists_; 0)
						$popmenu:=" ;EQ;GT;GTE;LT;LTE"
						ut_TextToArray($popmenu; ->$lists_; ";")
						$choise_L:=Pop up menu:C542($popmenu)
						Case of 
							: ($choise_L>1)
								NBESRC_LB2_StateQ_atxt{$row_L}:=$lists_{$choise_L}
								// OBJECT SET ENTERABLE(arr7;True)
								REDRAW:C174(NBESearch_LB2)
							: ($choise_L=1)
								NBESRC_LB2_StateQ_atxt{$row_L}:=""
								NBESRC_LB2_StateQV_ar{$row_L}:=0
								// OBJECT SET ENTERABLE(arr7;False)
								REDRAW:C174(NBESearch_LB2)
						End case 
					: ($col_L=9)
						// state total q value
						If (NBESRC_LB2_StateQ_atxt{$row_L}#"")
							OBJECT SET ENTERABLE:C238(NBESRC_LB2_StateQV_ar; True:C214)
							EDIT ITEM:C870(NBESRC_LB2_StateQV_ar; $row_L)
						Else 
							OBJECT SET ENTERABLE:C238(NBESRC_LB2_StateQV_ar; False:C215)
						End if 
						
				End case 
				
		End case 
		
End case 

//End Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_LB2