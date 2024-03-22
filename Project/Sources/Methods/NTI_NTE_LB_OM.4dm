//%attributes = {"invisible":true}
//Method: NTI_NTE_LB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 16:51:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_NTE_LB_OM; $1)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($formEvent_L)

$formEvent_L:=$1

Case of 
	: ($formEvent_L=On Load:K2:1)
		
		NTI_INIT
		
		NTI_SETARRAYS
		CLEAR SET:C117("$NBEElements0")
		C_LONGINT:C283(PON_HELPWINDOW_PID_L)
		OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_Damage")
		//DISABLE BUTTON(*;"@PON_ADD_PROTSYS")
		
	: ($formEvent_L=On Display Detail:K2:22)
		NTI_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT; ->[NTI_ELEM_BIN_INSP:183])
		PON_NBE_LB_Q_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; 1)
		C_TEXT:C284($Qformat_txt; $PCTFormat_txt)
		$Qformat_txt:="###,###,###,###,##0.0;;"
		$PCTFormat_txt:="###,###,###,###,##0.00;;"
		If (PON_NBE_LB_ELEMU_TXT="ea@")
			$Qformat_txt:="###,###,###,###,##0;;"
		Else 
		End if 
		OBJECT SET FORMAT:C236(PON_NBE_LB_Q_r; $Qformat_txt)
		
		If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
			PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; 1)
			PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18; 1)
			PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19; 1)
			PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20; 1)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $Qformat_txt)
		Else 
			PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE1:12; 2)
			PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE2:13; 2)
			PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE3:14; 2)
			PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE4:15; 2)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $PCTFormat_txt)
		End if 
		Pon_ElemKey_txt:=NTI_ElemKeyTxt
		
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
			// $rowClick_L:=Selected record number([NTI_ELEM_BIN_INSP])
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([NTI_ELEM_BIN_INSP:183]))
			Else 
				GOTO SELECTED RECORD:C245([NTI_ELEM_BIN_INSP:183]; $rowClick_L)
				//APPEND TO ARRAY(PON_ELEMDEPTH_aL;[NTI_ELEM_BIN_INSP]ELEM_KEY)
				
				NTI_OpenElement(->[NTI_ELEM_BIN_INSP:183])
				NTI_ListElements
				REDRAW:C174(PON_NBE_LB)
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_Damage")
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_PROTSYS")
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
			InDoubleClick_B:=False:C215
		End if 
		
	: ($formEvent_L=On Clicked:K2:4)
		If (Not:C34(vbInspectionLocked))
			C_LONGINT:C283($rowClick_L; $column_l; $row)
			LISTBOX GET CELL POSITION:C971(PON_NBE_LB; $column_l; $rowClick_L)
			
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_Damage")
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_PROTSYS")
			
			// $rowClick_L:=Selected record number([NTI_ELEM_BIN_INSP])
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([NTI_ELEM_BIN_INSP:183]))
			Else 
				// test if there is no record highlighted
				
				If (Records in set:C195("$NBEElements0")>0)
					GOTO SELECTED RECORD:C245([NTI_ELEM_BIN_INSP:183]; $rowClick_L)
					READ ONLY:C145([NTI_ELEM_BIN_INSP:183])
					LOAD RECORD:C52([NTI_ELEM_BIN_INSP:183])
					// disable the add prosys and adddam buttons
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_Damage")
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"@PON_ADD_PROTSYS")
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
					Case of 
						: (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
							// leave disabled for unknown stuff
							
						: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
							// leave disabled for smart flags
						: ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7=0)
							// enable both add protsys and add damage
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"@PON_ADD_Damage")
							//ENABLE BUTTON(*;"@PON_ADD_PROTSYS")
						: ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0)
							// enable only the add damage button
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"@PON_ADD_Damage")
							
					End case 
					
				End if 
			End if 
			
		End if 
		
		
	: ($formEvent_L=On Close Detail:K2:24)
		
	: ($formEvent_L=On Unload:K2:2)
		CLEAR SET:C117("PON_LISTINSPELEMS")
		
End case 

//End NTI_NTE_LB_OM