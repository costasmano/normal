//%attributes = {"invisible":true}
//Method: NTI_ELEMDAMLB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 16:15:11
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_ELEMDAMLB_OM; $1)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 10:01:13)
	Mods_2021_WP
	//  `
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=$1

Case of 
	: ($FormEvent_L=On Display Detail:K2:22)
		NTI_LoadLB_elemInfo(->PON_NBE_DAM_LB_desc_txt; ->PON_NBE_DAM_LB_unit_txt; ->PON_NBE_DAM_LB_QP_txt; Current form table:C627)
		Case of 
			: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
				PON_NBE_LB_Q_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21
				If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
					PON_NBE_DAM_LB_CS1_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17
					PON_NBE_DAM_LB_CS2_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18
					PON_NBE_DAM_LB_CS3_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19
					PON_NBE_DAM_LB_CS4_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20
				Else 
					PON_NBE_DAM_LB_CS1_r:=[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE1:12
					PON_NBE_DAM_LB_CS2_r:=[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE2:13
					PON_NBE_DAM_LB_CS3_r:=[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE3:14
					PON_NBE_DAM_LB_CS4_r:=[NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE4:15
				End if 
				
			: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
				PON_NBE_LB_Q_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
				If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
					PON_NBE_DAM_LB_CS1_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
					PON_NBE_DAM_LB_CS2_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
					PON_NBE_DAM_LB_CS3_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
					PON_NBE_DAM_LB_CS4_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
				Else 
					PON_NBE_DAM_LB_CS1_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12
					PON_NBE_DAM_LB_CS2_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13
					PON_NBE_DAM_LB_CS3_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14
					PON_NBE_DAM_LB_CS4_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
				End if 
				
		End case 
		
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($rowClick_L; $col_L)
			LISTBOX GET CELL POSITION:C971(*; "PON_NBE_DAM_LB"; $col_L; $rowClick_L)
			// $rowClick_L:=Selected record number([nti_elem_bin_insp])
			If ($rowClick_L<1)
			Else 
				C_BOOLEAN:C305($OpenElem_b)
				$OpenElem_b:=True:C214
				If (NTI_ModifiedRecord(Current form table:C627))
					// save it before going further-avoid push and pop
					
					Case of 
						: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
							CONFIRM:C162("Changes were made to current element "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)+"! Save them before opening the new one?"; "SAVE"; "CANCEL")
						: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
							CONFIRM:C162("Changes were made to current element "+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)+"! Save them before opening the new one?"; "SAVE"; "CANCEL")
					End case 
					
					If (OK=1)
						If (NTI_ELEMINP_SAVE(Current form table:C627))
						Else 
							$OpenElem_b:=False:C215
						End if 
						
					Else 
						$OpenElem_b:=False:C215
					End if 
				End if 
				If ($OpenElem_b)
					C_TEXT:C284($TempSelName_txt)
					
					Case of 
						: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
							APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
						: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
							APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					End case 
					$TempSelName_txt:="$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL))  //save current selection of elements
					COPY NAMED SELECTION:C331(Current form table:C627->; $TempSelName_txt)
					
					USE NAMED SELECTION:C332("PON_NBE_DAMAGE")
					GOTO SELECTED RECORD:C245(Current form table:C627->; $rowClick_L)
					
					C_LONGINT:C283($CurrWriteArea_L)
					$CurrWriteArea_L:=AreaElmComments
					
					NTI_OpenElement(Current form table:C627)
					InDoubleClick_B:=False:C215
					
					DELETE FROM ARRAY:C228(PON_ELEMDEPTH_aL; Size of array:C274(PON_ELEMDEPTH_aL); 1)
					USE NAMED SELECTION:C332($TempSelName_txt)
					CLEAR NAMED SELECTION:C333($TempSelName_txt)
					AreaElmComments:=$CurrWriteArea_L
					Case of 
						: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
							NTI_ELEMINPUTIL("RESETUI")
							//need to reload the comments ares - 
							//NTI_ElmtRemarksArea (->[NTI_ELEM_BIN_INSP]ELEM_NOTES;AreaElmComments;On Load)
							INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
							
						: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
							NTI_ELEMINPUTIL_TIN("RESETUI")
							//NTI_ElmtRemarksArea (->[NTI_ELEM_TIN_INSP]ELEM_NOTES;AreaElmComments;On Load)
							INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
					End case 
					
					REDRAW:C174(PON_NBE_DAM_LB)
					REDRAW:C174(AreaElmComments)
				End if 
				
			End if 
			InDoubleClick_B:=False:C215
			
		End if 
		
End case 

//End NTI_ELEMDAMLB_OM