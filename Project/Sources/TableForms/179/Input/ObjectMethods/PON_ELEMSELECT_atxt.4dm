If (False:C215)
	//Object Method: [PON_ELEM_INSP]."Input".PON_ELEMSELECT_atxt 
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 14:07:24)
	Mods_2016_02_bug
	//  ` use PON_ELEM_Defect_b to keep track if element is a defect - attempt to change 
	//  `logic of doing quantities to allow users to enter quantities in states and then add them to get total Q for defects 
	//  `only for Q - percentages have to go the normal way
	// Modified by: Costas Manousakis-(Designer)-(3/25/19 13:12:23)
	Mods_2019_03
	//  `Use a case statement when checking for Type (prot sys or defect)
	//  `for Prot sys check if selection is in the list of FHWA recommended. - show alert if it is not.
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (vbInspectionLocked)
			C_LONGINT:C283($stored_L)
			$stored_L:=Find in array:C230(PON_ELEMSELECT_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)
			Self:C308->:=$stored_L
		Else 
			C_LONGINT:C283($temp_KEY_L)
			POPUPMENUC(Self:C308; ->PON_ELEMSELECT_aL; ->$temp_KEY_L)
			// need to verify uniqueness-cannot have another
			C_BOOLEAN:C305($Unique_OK_B)
			$Unique_OK_B:=PON_VERIFYUNIQELEM_b($temp_KEY_L; [PON_ELEM_INSP:179]ENVKEY:5; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)
			If ($Unique_OK_B)
				[PON_ELEM_INSP:179]ELEM_KEY:3:=$temp_KEY_L
				// update units-only if defect
				QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
				If ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4#"Y")
					PON_ELEMUNIT_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
				End if 
				PON_ElemNoQuantState1_b:=False:C215
				PON_ELEM_Defect_b:=False:C215
				
				Case of 
					: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
						// for defect check if state 1 is"none"
						PON_ElemNoQuantState1_b:=PON_NoQuantityState1([PON_ELEM_INSP:179]ELEM_KEY:3)
						PON_ELEM_Defect_b:=True:C214
						
					: ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
						//for protective system check if it is one of the recommended
						ARRAY LONGINT:C221($RecProtSys_aL; 0)
						PON_FindAllowedProtSys([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; ->$RecProtSys_aL)
						If (Find in array:C230($RecProtSys_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)>0)
							// OK
						Else 
							C_TEXT:C284($msg_txt; $parentDesc_txt)
							C_LONGINT:C283($parIndx_L)
							$parIndx_L:=Find in array:C230(PON_MASTERELEM_KEY_aL; PON_PARENTKEY_L)
							
							If ($parIndx_L>0)
								$parentDesc_txt:=PON_MASTERELEM_Desc_atxt{$parIndx_L}  //the Desc array contains the elem key
							Else 
								$parentDesc_txt:=String:C10(PON_PARENTKEY_L)+" : (Unknown Element)"
							End if 
							
							If (Size of array:C274($RecProtSys_aL)>0)
								$msg_txt:="Selected protection system "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" : "+[PON_ELEM_DEFS:178]ELEM_SHORTNAME:10+\
									" is not in the list of protective systems recommended by FHWA for parent element "+\
									$parentDesc_txt+". Please verify your selection!\nThe recommended list is :\n"
								SORT ARRAY:C229($RecProtSys_aL; >)
								C_LONGINT:C283($protloop_L; $protIndx_L)
								For ($protloop_L; 1; Size of array:C274($RecProtSys_aL))
									$protIndx_L:=Find in array:C230(PON_PROTSYSELEM_KEY_AL; $RecProtSys_aL{$protloop_L})
									
									If ($protIndx_L>0)
										$msg_txt:=$msg_txt+PON_PROTSYSELEM_DESC_ATXT{$protIndx_L}+"\n"  //the Desc array contains the elem key
									Else 
										$msg_txt:=$msg_txt+String:C10($RecProtSys_aL{$protloop_L})+" : (Unknown System)\n"
									End if 
									
								End for 
								
							Else 
								$msg_txt:=("The Parent Element ["+$parentDesc_txt+"] does not have any "+\
									"protective systems recommended by FHWA. Please verify your selection!")
							End if 
							ALERT:C41($msg_txt)
						End if 
						
				End case 
				
				
				If ([PON_ELEM_INSP:179]ELEM_QUANTITY:7>0)
					
					If (True:C214 | Not:C34(PON_ELEM_Defect_b))  //****  start to make Changes here - currently only  this case is run - (the old case).
						//not a defect  - normal logic for quantities / pcts in states
						If (PON_ElemNoQuantState1_b)
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; False:C215)
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; False:C215)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QTYSTATE2; PON_Color_NotEditable_L)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
							[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=0
							[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=0
							//recalculating states should be done on exit
						Else 
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; True:C214)
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; True:C214)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QTYSTATE2; PON_Color_Editable_L)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_Editable_L)
						End if 
						
					Else 
						//a defect - we will allow entry in all allowed quantity states - percent stays the same logic
						If (PON_ElemNoQuantState1_b)
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; False:C215)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
							[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13:=0
							[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=0
							//recalculating states should be done on exit
						Else 
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; True:C214)
							OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; True:C214)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QTYSTATE1; PON_Color_Editable_L)
							OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_PCTSTATE2; PON_Color_Editable_L)
						End if 
						
					End if 
					
				End if 
				If (([PON_ELEM_INSP:179]ELEM_KEY:3>0) & ([PON_ELEM_INSP:179]ENVKEY:5>0))
					OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QUANTITY:7; True:C214)
					OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QUANTITY:7; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QUANTITY; PON_Color_Editable_L)
				End if 
				OBJECT SET ENABLED:C1123(*; "NBE HELPBUTTON"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				// reset the popup
				ALERT:C41("There is already an element with same Number / Enviroment / Parent / Grandparent! ")
				
				C_LONGINT:C283($inList_L)
				$inList_L:=Find in array:C230(PON_ELEMSELECT_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)
				If ($inList_L<=0)
					$inList_L:=0
				End if 
				Self:C308->:=$inList_L
			End if 
			
		End if 
End case 
