//%attributes = {"invisible":true}
//Method: NTI_ELEMPROTLB_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/20/18, 17:44:26
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03
	
	C_LONGINT:C283(NTI_ELEMPROTLB_OM; $1)
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 10:03:13)
	Mods_2021_WP
	//  `
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($FormEvent_L)

$FormEvent_L:=$1

Case of 
	: ($FormEvent_L=On Display Detail:K2:22)
		NTI_LoadLB_elemInfo(->PON_NBE_PROT_LB_desc_txt; ->PON_NBE_PROT_LB_unit_txt; ->PON_NBE_PROT_LB_QP_txt; Current form table:C627)
		If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
			PON_NBE_PROT_LB_CS1_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
			PON_NBE_PROT_LB_CS2_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
			PON_NBE_PROT_LB_CS3_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
			PON_NBE_PROT_LB_CS4_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
		Else 
			PON_NBE_PROT_LB_CS1_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12
			PON_NBE_PROT_LB_CS2_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13
			PON_NBE_PROT_LB_CS3_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14
			PON_NBE_PROT_LB_CS4_r:=[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
		End if 
		PON_NBE_LB_Q_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
		
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($rowClick_L; $col_L)
			LISTBOX GET CELL POSITION:C971(*; "PON_NBE_Prot_LB"; $col_L; $rowClick_L)
			// $rowClick_L:=Selected record number([NTI_ELEM_tin_insp])
			If ($rowClick_L<1)
			Else 
				C_BOOLEAN:C305($OpenElem_b)
				$OpenElem_b:=True:C214
				If (NTI_ModifiedRecord(Current form table:C627))
					// save it before going further-avoid push and pop
					CONFIRM:C162("Changes were made to current element "+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)+"! Save them before opening the new one?"; "SAVE"; "CANCEL")
					If (OK=1)
						If (NTI_ELEMINP_SAVE(Current form table:C627))
						Else 
							$OpenElem_b:=False:C215
						End if 
						
					Else 
						
						$OpenElem_b:=False:C215
					End if 
				End if 
				InDoubleClick_B:=$OpenElem_b
				If ($OpenElem_b)
					C_TEXT:C284($TempSelName_txt)
					
					APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
					$TempSelName_txt:="$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL))  //save current selection of elements
					COPY NAMED SELECTION:C331(Current form table:C627->; $TempSelName_txt)
					
					USE NAMED SELECTION:C332("PON_NBE_PROTSYS")
					GOTO SELECTED RECORD:C245([NTI_ELEM_TIN_INSP:185]; $rowClick_L)
					
					C_LONGINT:C283($CurrWriteArea_L)
					$CurrWriteArea_L:=AreaElmComments
					
					NTI_OpenElement(Current form table:C627)
					InDoubleClick_B:=False:C215
					
					DELETE FROM ARRAY:C228(PON_ELEMDEPTH_aL; Size of array:C274(PON_ELEMDEPTH_aL); 1)
					USE NAMED SELECTION:C332($TempSelName_txt)
					CLEAR NAMED SELECTION:C333($TempSelName_txt)
					
					AreaElmComments:=$CurrWriteArea_L
					NTI_ELEMINPUTIL_TIN("RESETUI")
					//NTI_ElmtRemarksArea (->[NTI_ELEM_BIN_INSP]ELEM_NOTES;AreaElmComments;On Load)
					INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
					
					REDRAW:C174(PON_NBE_Prot_LB)
					REDRAW:C174(AreaElmComments)
					
				End if 
				
			End if 
			
		End if 
		
End case 
//End NTI_ELEMPROTLB_OM