//%attributes = {"invisible":true}
//Method: NTI_ElemSelect_TIN_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 16:07:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(1/11/18 17:28:37)
	Mods_2018_01
	//  `account for elements with unit=percent
	// Modified by: Costas Manousakis-(Designer)-(1/19/18 17:44:59)
	Mods_2018_01
	//  `changes for states with no Q allowed
	//  //added more checks when changing an element to a new one
	//  //check if units changed, if any existing defects do not match new element
End if 
//

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (vbInspectionLocked)
			C_LONGINT:C283($stored_L)
			$stored_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
			Self:C308->:=$stored_L
		Else 
			C_LONGINT:C283($temp_KEY_L)
			POPUPMENUC(Self:C308; ->PON_ELEMSELECT_aL; ->$temp_KEY_L)
			
			If ($temp_KEY_L=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)  //do nothing if user selected the same key as current element
				
			Else   //picked a different/new key
				
				// need to verify uniqueness-cannot have another
				C_BOOLEAN:C305($Unique_OK_B)
				$Unique_OK_B:=NTI_VERIFYUNIQELEM_b($temp_KEY_L; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; ->[NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25)
				If ($Unique_OK_B)
					
					C_BOOLEAN:C305($ApplyChange_b)
					$ApplyChange_b:=True:C214
					
					C_TEXT:C284($CurrentName_txt; $NewName_txt)
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					$CurrentName_txt:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5
					
					//Now check for conflicts with current data
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$temp_KEY_L)
					$NewName_txt:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5
					// for defect check if state 1 is"none"
					C_LONGINT:C283(PON_ElemNoQuantityFlag_L)
					PON_ElemNoQuantState1_b:=False:C215
					PON_ELEM_Defect_b:=False:C215
					PON_ElemNoQuantityFlag_L:=0
					C_LONGINT:C283($TempNoQuantityFlag_L)
					C_BOOLEAN:C305($TempNoQuantityState1_b)
					$TempNoQuantityState1_b:=False:C215
					$TempNoQuantityFlag_L:=0
					
					C_LONGINT:C283($CS_L)
					
					ARRAY POINTER:C280($CSQT_aptr; 4)
					$CSQT_aptr{1}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
					$CSQT_aptr{2}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
					$CSQT_aptr{3}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
					$CSQT_aptr{4}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
					ARRAY POINTER:C280($CSPCT_aptr; 4)
					$CSPCT_aptr{1}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12
					$CSPCT_aptr{2}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13
					$CSPCT_aptr{3}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14
					$CSPCT_aptr{4}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
					
					If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y")  //not a defect - 
						
						C_TEXT:C284($AlertMsg_txt; $DefectCheck_txt; $UnitsCheck_txt)
						$DefectCheck_txt:=""
						$UnitsCheck_txt:=""
						C_LONGINT:C283($numCurrDefects_L)  //get current list of defects
						$numCurrDefects_L:=LISTBOX Get number of rows:C915(PON_NBE_DAM_LB)
						
						// check defects
						Case of 
							: (Is new record:C668([NTI_ELEM_TIN_INSP:185]))  // new record - nothing to check  - go ahead
								$ApplyChange_b:=True:C214
								
							: ($numCurrDefects_L>0)  //defects exist
								//get the keys
								ARRAY LONGINT:C221($CurrentDefectKeys_aL; 0)
								C_LONGINT:C283($CurrID_L)
								$CurrID_L:=[NTI_ELEM_TIN_INSP:185]ELEMID:2
								
								Begin SQL
									select [NTI_ELEM_TIN_INSP].[ELEM_KEY] from [NTI_ELEM_TIN_INSP], [NTI_ELEM_DEFS]
									where [NTI_ELEM_TIN_INSP].[ELEM_PARENT_ID] = :$CurrID_L 
									and [NTI_ELEM_DEFS].[ELEM_KEY] = [NTI_ELEM_TIN_INSP].[ELEM_KEY]
									and [NTI_ELEM_DEFS].[DEFECTFLAG] = 'Y'
									into :$CurrentDefectKeys_aL ;
								End SQL
								
								ARRAY LONGINT:C221($NewAllowedDefects_aL; 0)
								NTI_FindAllowedDefects($temp_KEY_L; ->$NewAllowedDefects_aL)
								//check if there is a conflict with list of defects 
								C_LONGINT:C283($loop_L)
								For ($loop_L; Size of array:C274($CurrentDefectKeys_aL); 1; -1)
									If (Find in array:C230($NewAllowedDefects_aL; $CurrentDefectKeys_aL{$loop_L})>0)
										DELETE FROM ARRAY:C228($CurrentDefectKeys_aL; $loop_L)
									End if 
								End for 
								
								If (Size of array:C274($CurrentDefectKeys_aL)>0)  //there are unmatched defects
									$DefectCheck_txt:=String:C10($CurrentDefectKeys_aL{1})
									
									For ($loop_L; 2; Size of array:C274($CurrentDefectKeys_aL))
										$DefectCheck_txt:=$DefectCheck_txt+", "+String:C10($CurrentDefectKeys_aL{$loop_L})
									End for 
									//
								End if 
								
						End case 
						
						//unit / quantity check
						// if units are same as current - we keep current data
						If ((PON_ELEMUNIT_txt#"") & (PON_ELEMUNIT_txt=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12))
							//same units - no changes neded due to quantities - need to check if defects match
							
							If ($DefectCheck_txt#"")  // There are un matched defects - user must delete them manually
								//there are defects - we will have to delete them
								$AlertMsg_txt:="To make this change, the current associated defect(s) "+$DefectCheck_txt+\
									" will have to be deleted manually beforehand !"
								ALERT:C41($AlertMsg_txt)
								$ApplyChange_b:=False:C215
								
							Else 
								//no problems
								$ApplyChange_b:=True:C214
							End if 
							
						Else   //change of units - will clear out all quantities and get rid of all defects if any
							
							If (Is new record:C668([NTI_ELEM_TIN_INSP:185]))  //for new record juat check if TotQ >0
								
								If ([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21>0)  //some q has been entered
									$AlertMsg_txt:="Because Units are being changed from "+PON_ELEMUNIT_txt+" to "+[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12+\
										" any entered Quantities"
									
									$AlertMsg_txt:=$AlertMsg_txt+" will be cleared! Proceed or Cancel Element Change?"
									CONFIRM:C162($AlertMsg_txt; "Proceed"; "Cancel")
									
									If (OK=1)  //Clear Qs and proceed
										[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=0
										
										$ApplyChange_b:=True:C214
										
									Else   //Don't change
										$ApplyChange_b:=False:C215
										
									End if 
									
								Else   //total Q is zero : ok to go
									$ApplyChange_b:=True:C214
									
								End if 
								
							Else   //existing record
								
								
								If ($UnitsCheck_txt#"")  //inconsistant defects - cannot continue
									//there are defects - we will have to delete them
									$AlertMsg_txt:="To make this change, the current associated defect(s) : "+$DefectCheck_txt+\
										" will have to be deleted manually beforehand !"
									ALERT:C41($AlertMsg_txt)
									$ApplyChange_b:=False:C215
									
								Else 
									
									$AlertMsg_txt:="Because Units are being changed from "+PON_ELEMUNIT_txt+" to "+[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12+\
										" any entered Quantities for the element will be cleared!"
									If ($numCurrDefects_L>0)
										$AlertMsg_txt:=$AlertMsg_txt+" There are also "+String:C10($numCurrDefects_L)+" associated defects!"
										$AlertMsg_txt:=$AlertMsg_txt+" You must address these issues before saving!"
									End if 
									$AlertMsg_txt:=$AlertMsg_txt+" Proceed or Cancel Element Change?"
									CONFIRM:C162($AlertMsg_txt; "Proceed"; "Cancel")
									
									If (OK=1)  //clear all data
										//
										[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=0
										
										$ApplyChange_b:=True:C214
										
									Else   //Cancel change 
										$ApplyChange_b:=False:C215
										
									End if 
									
								End if 
								
							End if 
							
						End if 
						
					Else   // a defect - 
						
						//have to check if there quantities in states that are not supposed to be
						$TempNoQuantityState1_b:=NTI_NoQuantityState1($temp_KEY_L)
						$TempNoQuantityFlag_L:=NTI_NoQuantityState($temp_KEY_L)
						C_TEXT:C284($Temp_msg_txt)
						$Temp_msg_txt:=""
						
						For ($CS_L; 1; 4)
							If ($TempNoQuantityFlag_L ?? $CS_L) & (($CSQT_aptr{$CS_L}->)>0)
								If ($Temp_msg_txt="")
									$Temp_msg_txt:=String:C10($CS_L)
								Else 
									$Temp_msg_txt:=$Temp_msg_txt+", "+String:C10($CS_L)
									
								End if 
							End if 
						End for 
						
						If ($Temp_msg_txt#"")
							//if we change - quamtities will be erased in the state(s)
							$Temp_msg_txt:="Selected Element "+String:C10($temp_KEY_L)+" ("+$NewName_txt+") cannot have quantities in Condition State(s) "+\
								$Temp_msg_txt+" ! If you proceed these quantities will be cleared!"
							CONFIRM:C162($Temp_msg_txt; "Proceed"; "Cancel")
							$ApplyChange_b:=(OK=1)
						Else 
							//no problems - can go ahead with change
							$ApplyChange_b:=True:C214
						End if 
						
					End if 
					
					If ($ApplyChange_b)
						//now ok to change the element
						
						[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3:=$temp_KEY_L
						// update units - only if not a defect
						If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y")
							PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
						Else 
							PON_ElemNoQuantState1_b:=$TempNoQuantityState1_b
							PON_ELEM_Defect_b:=True:C214
							PON_ElemNoQuantityFlag_L:=$TempNoQuantityFlag_L
						End if 
						
						If (PON_ELEMUNIT_txt="percent")
							[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=True:C214  //percent
							OBJECT SET VISIBLE:C603(*; "DE bQuantity"; False:C215)
							OBJECT SET VISIBLE:C603(*; "DE bPercent"; False:C215)
							bQuantity:=1
							bPercent:=0
						End if 
						
						If ([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21>0)  //already have a quantity - adjust for new element
							
							
							If (Not:C34(PON_ELEM_Defect_b))
								
								//not a defect  - normal logic for quantities / pcts in states
								OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; True:C214)
								OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; True:C214)
								OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE2; PON_Color_Editable_L)
								OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_Editable_L)
								
							Else 
								
								//a defect - we will allow entry in all allowed quantity states - percent stays the same logic
								//first clear values in states with no allowed q
								C_LONGINT:C283($LowAllowed_L)
								$LowAllowed_L:=0
								For ($CS_L; 1; 4)
									If (PON_ElemNoQuantityFlag_L ?? $CS_L)
										$CSQT_aptr{$CS_L}->:=0
										$CSPCT_aptr{$CS_L}->:=0
										//lock the quantity
										OBJECT SET ENTERABLE:C238($CSQT_aptr{$CS_L}->; False:C215)
										OBJECT SET RGB COLORS:C628($CSQT_aptr{$CS_L}; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSQT_aptr{$CS_L}; PON_Color_NotEditable_L)
										//lock the percent
										OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; False:C215)
										OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}; PON_Color_NotEditable_L)
										
									Else 
										//unlock the quantity
										OBJECT SET ENTERABLE:C238($CSQT_aptr{$CS_L}->; True:C214)
										OBJECT SET RGB COLORS:C628($CSQT_aptr{$CS_L}; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR($CSQT_aptr{$CS_L}; PON_Color_Editable_L)
										
										If ($LowAllowed_L=0)
											$LowAllowed_L:=$CS_L
											//lock the percent
											OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; False:C215)
											OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}; PON_Color_NotEditable_L)
										Else 
											//unlock the percent
											OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; True:C214)
											OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}; PON_Color_Editable_L)
											
										End if 
									End if 
								End for 
								
								If (False:C215)
									
									If (PON_ElemNoQuantState1_b)
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; False:C215)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
										[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=0
										[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=0
										//recalculating states should be done on exit
									Else 
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; True:C214)
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; True:C214)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_Editable_L)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_Editable_L)
									End if 
									
								End if   //old method using PON_ElemNoQuantState1_b
								
							End if 
							
						Else   // Zero current total quantity - new element
							
							If (PON_ELEM_Defect_b)  //
								//for defects can allow entry in appropriate states only if showing quantity
								C_LONGINT:C283($LowAllowed_L)
								$LowAllowed_L:=0
								For ($CS_L; 1; 4)
									If (PON_ElemNoQuantityFlag_L ?? $CS_L)
										$CSQT_aptr{$CS_L}->:=0
										$CSPCT_aptr{$CS_L}->:=0
										//lock the quantity
										OBJECT SET ENTERABLE:C238($CSQT_aptr{$CS_L}->; False:C215)
										OBJECT SET RGB COLORS:C628($CSQT_aptr{$CS_L}->; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSQT_aptr{$CS_L}->; PON_Color_NotEditable_L)
										//lock the percent
										OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; False:C215)
										OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}->; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}->; PON_Color_NotEditable_L)
										
									Else 
										//unlock the quantity
										OBJECT SET ENTERABLE:C238($CSQT_aptr{$CS_L}->; True:C214)
										OBJECT SET RGB COLORS:C628($CSQT_aptr{$CS_L}->; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR($CSQT_aptr{$CS_L}->; PON_Color_Editable_L)
										
										If ($LowAllowed_L=0)
											$LowAllowed_L:=$CS_L
											//lock the percent
											OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; False:C215)
											OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}->; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}->; PON_Color_NotEditable_L)
										Else 
											//unlock the percent
											OBJECT SET ENTERABLE:C238($CSPCT_aptr{$CS_L}->; True:C214)
											OBJECT SET RGB COLORS:C628($CSPCT_aptr{$CS_L}->; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR($CSPCT_aptr{$CS_L}->; PON_Color_Editable_L)
											
										End if 
									End if 
								End for 
								
								If (False:C215)
									
									If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
										
										If (PON_ElemNoQuantState1_b)
											OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
											OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
										Else 
											OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; True:C214)
											OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_Editable_L)
										End if 
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; True:C214)
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; True:C214)
										OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; True:C214)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE2; PON_Color_Editable_L)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE3; PON_Color_Editable_L)
										OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE4; PON_Color_Editable_L)
										
									End if 
									
								End if 
								
							Else 
								
								//for normal elements block state1
								OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
								OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
								//if the units are percent - set total q to 100 and state 1 to 100
								
								If (PON_ELEMUNIT_txt="percent")
									[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=100
									[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=100
									[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100
									NTI_ElemQuantity_OM(On Data Change:K2:15)  // have to do this here because we do not allow entry in quantity for units=percent
								End if 
								
							End if 
							
						End if 
						
						If (PON_ELEMUNIT_txt="percent") & (Not:C34(PON_ELEM_Defect_b))
							//for percent lock quantity to 100 `unless it is a defect
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; False:C215)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QUANTITY; PON_Color_NotEditable_L)
							
						Else 
							//all others can change it
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; True:C214)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QUANTITY; PON_Color_Editable_L)
						End if 
						
						OBJECT SET ENABLED:C1123(*; "NBE HELPBUTTON"; True:C214)
						
					Else 
						
						//reset popup
						C_LONGINT:C283($inList_L)
						$inList_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
						If ($inList_L<=0)
							$inList_L:=0
						End if 
						Self:C308->:=$inList_L
						
					End if 
					
					
				Else 
					// reset the popup
					ALERT:C41("There is already an element with same Number / Parent / GrandParent ! ")
					
					C_LONGINT:C283($inList_L)
					$inList_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					If ($inList_L<=0)
						$inList_L:=0
					End if 
					Self:C308->:=$inList_L
				End if 
				
			End if 
			
		End if 
End case 

//End NTI_ElemSelect_TIN_OM