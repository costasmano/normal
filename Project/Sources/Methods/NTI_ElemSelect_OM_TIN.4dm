//%attributes = {"invisible":true}
// Method: NTI_ElemSelect_OM_TIN
// Description
// ***** NOT USED *****
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:38:21
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
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
			// need to verify uniqueness-cannot have another
			C_BOOLEAN:C305($Unique_OK_B)
			$Unique_OK_B:=NTI_VERIFYUNIQELEM_b($temp_KEY_L; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; ->[NTI_ELEM_TIN_INSP:185])
			If ($Unique_OK_B)
				[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3:=$temp_KEY_L
				// update units-only if defect
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
				If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y")
					PON_ELEMUNIT_txt:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
				End if 
				// for defect check if state 1 is"none"
				PON_ElemNoQuantState1_b:=False:C215
				PON_ELEM_Defect_b:=False:C215
				If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
					PON_ElemNoQuantState1_b:=NTI_NoQuantityState1([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					PON_ELEM_Defect_b:=True:C214
				End if 
				If ([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21>0)
					
					If (Not:C34(PON_ELEM_Defect_b))
						//not a defect  - normal logic for quantities / pcts in states
						If (PON_ElemNoQuantState1_b)
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; False:C215)
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; False:C215)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE2; PON_Color_NotEditable_L)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
							[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=0
							[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=0
							//recalculating states should be done on exit
						Else 
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; True:C214)
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; True:C214)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE2; PON_Color_Editable_L)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_Editable_L)
						End if 
						
					Else 
						//a defect - we will allow entry in all allowed quantity states - percent stays the same logic
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
						
					End if 
				Else 
					
					If (PON_ELEM_Defect_b)
						//for defects can allow entry in appropriate states only if showing quantity
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
					Else 
						OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
						OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
					End if 
					
				End if 
				If (([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3>0))
					OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; True:C214)
					OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QUANTITY; PON_Color_Editable_L)
				End if 
				OBJECT SET ENABLED:C1123(*; "NBE HELPBUTTON"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				// reset the popup
				ALERT:C41("There is already an element with same Number / Parent ! ")
				
				C_LONGINT:C283($inList_L)
				$inList_L:=Find in array:C230(PON_ELEMSELECT_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
				If ($inList_L<=0)
					$inList_L:=0
				End if 
				Self:C308->:=$inList_L
			End if 
			
		End if 
End case 
//End NTI_ElemSelect_OM