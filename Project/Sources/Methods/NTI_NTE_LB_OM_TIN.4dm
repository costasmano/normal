//%attributes = {"invisible":true}
If (False:C215)
	
	C_LONGINT:C283(NTI_NTE_LB_OM_TIN; $1)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 17:34:37)
	Mods_2018_03
	//  `addition of protective systems
End if 
//

C_LONGINT:C283($formEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formEvent_L:=$1
Else 
	$formEvent_L:=Form event code:C388
End if 


Case of 
	: ($formEvent_L=On Load:K2:1)
		
		CLEAR SET:C117("$NBEElements0")
		C_LONGINT:C283(PON_HELPWINDOW_PID_L)
		//_ o _DISABLE BUTTON(*;"@PON_ADD_Damage@")
		OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS Btn@"; False:C215)
		//DISABLE BUTTON(*;"@PON_ADD_PROTSYS")
		
	: ($formEvent_L=On Display Detail:K2:22)
		NTI_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT; ->[NTI_ELEM_TIN_INSP:185])
		PON_NBE_LB_Q_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; 1)
		C_TEXT:C284($Qformat_txt; $PCTFormat_txt)
		$Qformat_txt:="###,###,###,###,##0.0;;"
		$PCTFormat_txt:="###,###,###,###,##0.00;;"
		If (PON_NBE_LB_ELEMU_TXT="ea@")
			$Qformat_txt:="###,###,###,###,##0;;"
		Else 
		End if 
		OBJECT SET FORMAT:C236(PON_NBE_LB_Q_r; $Qformat_txt)
		
		If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
			PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; 1)
			PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; 1)
			PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; 1)
			PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; 1)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $Qformat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $Qformat_txt)
		Else 
			PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12; 2)
			PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; 2)
			PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14; 2)
			PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15; 2)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $PCTFormat_txt)
			OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $PCTFormat_txt)
		End if 
		
		Pon_ElemKey_txt:=NTI_ElemKeyTxt([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25)
		If (Pon_ElemKey_txt=" > @")
			// defect - hide the rating column
			//OBJECT SET VISIBLE([NTI_ELEM_TIN_INSP]ELEM_RATING;False)
		Else 
			//OBJECT SET VISIBLE([NTI_ELEM_TIN_INSP]ELEM_RATING;True)
		End if 
	: ($formEvent_L=On Data Change:K2:15)
		
	: ($formEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($rowClick_L; $column_l; $CurrQuant_L; $CurrPerc_L)
			LISTBOX GET CELL POSITION:C971(PON_NBE_LB; $column_l; $rowClick_L)
			// initialize element depth array
			ARRAY LONGINT:C221(PON_ELEMDEPTH_aL; 0)
			
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([NTI_ELEM_TIN_INSP:185]))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245([NTI_ELEM_TIN_INSP:185]; $rowClick_L)
				//APPEND TO ARRAY(PON_ELEMDEPTH_aL;[NTI_ELEM_TIN_INSP]ELEM_KEY)
				
				NTI_OpenElement(->[NTI_ELEM_TIN_INSP:185])
				NTI_ListElements_TIN
				InDoubleClick_B:=False:C215
				REDRAW:C174(PON_NBE_LB)
				//_ o _DISABLE BUTTON(*;"@PON_ADD_Damage Btn@")
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS Btn@"; False:C215)
				
				If (PON_HELPWINDOW_PID_L>0)
					If (Process state:C330(PON_HELPWINDOW_PID_L)#Aborted:K13:1)
						SET PROCESS VARIABLE:C370(PON_HELPWINDOW_PID_L; PON_NEWELEMENTNO_L; -999)
						DELAY PROCESS:C323(Current process:C322; 20)
						POST OUTSIDE CALL:C329(PON_HELPWINDOW_PID_L)
					End if 
				End if 
			End if 
			
		End if 
		
	: (($formEvent_L=On Selection Change:K2:29))  //($formEvent_L=On Clicked) |
		If (Not:C34(vbInspectionLocked))
			C_LONGINT:C283($rowClick_L; $column_l; $row)
			LISTBOX GET CELL POSITION:C971(PON_NBE_LB; $column_l; $rowClick_L)
			
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS Btn@"; False:C215)
			// $rowClick_L:=Selected record number([NTI_ELEM_TIN_INSP])
			If ($rowClick_L<1) | ($rowClick_L>Records in selection:C76([NTI_ELEM_TIN_INSP:185]))
			Else 
				// test if there is no record highlighted
				
				If (Records in set:C195("$NBEElements0")>0)
					GOTO SELECTED RECORD:C245([NTI_ELEM_TIN_INSP:185]; $rowClick_L)
					READ ONLY:C145([NTI_ELEM_TIN_INSP:185])
					LOAD RECORD:C52([NTI_ELEM_TIN_INSP:185])
					// disable the add prosys and adddam buttons
					//_ o _DISABLE BUTTON(*;"@PON_ADD_Damage Btn@")
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "@PON_ADD_protsys Btn@"; False:C215)
					
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					Case of 
						: (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
							// leave disabled for unknown stuff
							
						: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
							// leave disabled for smart flags
						: ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; True:C214)
							
						: ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0)
							// enable both add protsys and add damage
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; True:C214)
							OBJECT SET ENABLED:C1123(*; "@PON_ADD_protsys Btn@"; True:C214)
							
					End case 
					
				End if 
			End if 
			
		End if 
		
	: ($formEvent_L=On Unload:K2:2)
		CLEAR SET:C117("PON_LISTINSPELEMS")
		
End case 

//End NTI_NTE_LB_OM