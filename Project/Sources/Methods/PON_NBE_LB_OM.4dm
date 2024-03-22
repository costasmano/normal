//%attributes = {"invisible":true}
//Method: PON_NBE_LB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:25:13
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(6/22/16 16:08:20)
	Mods_2016_06
	//  `combined On Selection Change with the On Clicked event to account for scrolling using the up/down arrow keys.
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(5/6/19 13:15:24)
	Mods_2019_05
	//  `use create empty set instead of Clear Set on Load
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($formEvent_L)

$formEvent_L:=$1

Case of 
	: ($formEvent_L=On Load:K2:1)
		
		PON_SETARRAYS
		CREATE EMPTY SET:C140([PON_ELEM_INSP:179]; "$NBEElements0")
		C_LONGINT:C283(PON_HELPWINDOW_PID_L)
		OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: ($formEvent_L=On Display Detail:K2:22)
		PON_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT)
		PON_NBE_LB_Q_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QUANTITY:7; 1)
		C_TEXT:C284($Qformat_txt; $PCTFormat_txt)
		$Qformat_txt:="###,###,###,###,##0.0;;"
		$PCTFormat_txt:="###,###,###,###,##0.00;;"
		If (PON_NBE_LB_ELEMU_TXT="ea@")
			$Qformat_txt:="###,###,###,###,##0;;"
		Else 
		End if 
		OBJECT SET FORMAT:C236(PON_NBE_LB_Q_r; $Qformat_txt)
		
		If ([PON_ELEM_INSP:179]ELEM_QorP:29)
			PON_NBE_LB_CS1_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; 1)
			PON_NBE_LB_CS2_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; 1)
			PON_NBE_LB_CS3_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; 1)
			PON_NBE_LB_CS4_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; 1)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $Qformat_txt)
		Else 
			PON_NBE_LB_CS1_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE1:9; 2)
			PON_NBE_LB_CS2_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; 2)
			PON_NBE_LB_CS3_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE3:11; 2)
			PON_NBE_LB_CS4_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE4:12; 2)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $PCTFormat_txt)
		End if 
		Pon_ElemKey_txt:=PON_ElemKeytxt
		
	: ($formEvent_L=On Data Change:K2:15)
		
	: ($formEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($rowClick_L; $column_l; $CurrQuant_L; $CurrPerc_L)
			// save status of quant/percent radios
			// $CurrQuant_L:=bQuantity
			// $CurrPerc_L:=bPercent
			LISTBOX GET CELL POSITION:C971(PON_NBE_LB; $column_l; $rowClick_L)
			// initialize element depth array
			ARRAY LONGINT:C221(PON_ELEMDEPTH_aL; 0)
			// $rowClick_L:=Selected record number([PON_ELEM_INSP])
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([PON_ELEM_INSP:179]))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $rowClick_L)
				APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)
				
				PON_OpenElement
				PON_ListElements
				InDoubleClick_B:=False:C215
				REDRAW:C174(PON_NBE_LB)
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				// restore status of quant/percent radios
				// bQuantity:=$CurrQuant_L
				// bPercent:=$CurrPerc_L
				If (PON_HELPWINDOW_PID_L>0)
					If (Process state:C330(PON_HELPWINDOW_PID_L)#Aborted:K13:1)
						SET PROCESS VARIABLE:C370(PON_HELPWINDOW_PID_L; PON_NEWELEMENTNO_L; -999)
						DELAY PROCESS:C323(Current process:C322; 20)
						POST OUTSIDE CALL:C329(PON_HELPWINDOW_PID_L)
					End if 
				End if 
			End if 
			
		End if 
		
	: (($formEvent_L=On Clicked:K2:4) | ($formEvent_L=On Selection Change:K2:29))
		If (Not:C34(vbInspectionLocked))
			C_LONGINT:C283($rowClick_L; $column_l; $row)
			LISTBOX GET CELL POSITION:C971(PON_NBE_LB; $column_l; $rowClick_L)
			
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			
			// $rowClick_L:=Selected record number([PON_ELEM_INSP])
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([PON_ELEM_INSP:179]))
			Else 
				// test if there is no record highlighted
				
				If (Records in set:C195("$NBEElements0")>0)
					GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $rowClick_L)
					READ ONLY:C145([PON_ELEM_INSP:179])
					LOAD RECORD:C52([PON_ELEM_INSP:179])
					// disable the add prosys and adddam buttons
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
					Case of 
						: (Records in selection:C76([PON_ELEM_DEFS:178])=0)
							// leave disabled for unknown stuff
							
						: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
							// leave disabled for smart flags
						: ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=0)
							// enable both add protsys and add damage
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
						: ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)
							// enable only the add damage button
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
							
					End case 
					
				End if 
			End if 
			
		End if 
		
		
	: ($formEvent_L=On Close Detail:K2:24)
		
	: ($formEvent_L=On Unload:K2:2)
		CLEAR SET:C117("PON_LISTINSPELEMS")
		
End case 

//End PON_NBE_LB_OM