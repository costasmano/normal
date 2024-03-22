//%attributes = {"invisible":true}
// Method: PON_ELEMDAMLB_OM
// Description
// object method for the defect listbox in the element input form
// 
// Parameters
// $1  : formevent
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 16:45:55
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(11/23/15 17:38:52)
	Mods_2015_11_bug
	//  `use method PON_ELEMINP_SAVE when saving current element.  this to make sure changes are recorded.
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=$1

Case of 
	: ($FormEvent_L=On Display Detail:K2:22)
		PON_LoadLB_elemInfo(->PON_NBE_DAM_LB_desc_txt; ->PON_NBE_DAM_LB_unit_txt; ->PON_NBE_DAM_LB_QP_txt)
		If ([PON_ELEM_INSP:179]ELEM_QorP:29)
			PON_NBE_DAM_LB_CS1_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13
			PON_NBE_DAM_LB_CS2_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14
			PON_NBE_DAM_LB_CS3_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15
			PON_NBE_DAM_LB_CS4_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
		Else 
			PON_NBE_DAM_LB_CS1_r:=[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9
			PON_NBE_DAM_LB_CS2_r:=[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10
			PON_NBE_DAM_LB_CS3_r:=[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11
			PON_NBE_DAM_LB_CS4_r:=[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12
		End if 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($rowClick_L; $col_L)
			LISTBOX GET CELL POSITION:C971(*; "PON_NBE_DAM_LB"; $col_L; $rowClick_L)
			// $rowClick_L:=Selected record number([PON_ELEM_INSP])
			If ($rowClick_L<1)
				InDoubleClick_B:=False:C215
			Else 
				C_BOOLEAN:C305($OpenElem_b)
				$OpenElem_b:=True:C214
				If (Modified record:C314([PON_ELEM_INSP:179]))
					// save it before going further-avoid push and pop
					CONFIRM:C162("Changes were made to current element "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+"! Save them before opening the new one?"; "SAVE"; "CANCEL")
					If (OK=1)
						If (PON_ELEMINP_SAVE)
						Else 
							$OpenElem_b:=False:C215
						End if 
						
					Else 
						
						$OpenElem_b:=False:C215
					End if 
				End if 
				InDoubleClick_B:=$OpenElem_b
				If ($OpenElem_b)
					COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL)))
					USE NAMED SELECTION:C332("PON_NBE_DAMAGE")
					GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $rowClick_L)
					APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; [PON_ELEM_INSP:179]ELEM_KEY:3)
					// LOAD RECORD([PON_ELEM_INSP])
					PON_OpenElement
					//update the defect list
					
					InDoubleClick_B:=False:C215
					// update the parent by rolling up quantities from the defects
					DELETE FROM ARRAY:C228(PON_ELEMDEPTH_aL; Size of array:C274(PON_ELEMDEPTH_aL); 1)
					USE NAMED SELECTION:C332("$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL)))
					CLEAR NAMED SELECTION:C333("$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL)))
					PON_ELEMINPUTIL("RESETUI")
					
					REDRAW:C174(PON_NBE_DAM_LB)
				End if 
				
			End if 
			
		End if 
		
End case 

//End PON_ELEMDAMLB_OM