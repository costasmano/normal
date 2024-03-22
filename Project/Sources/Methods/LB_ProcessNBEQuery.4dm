//%attributes = {"invisible":true}
//Method: LB_ProcessNBEQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/07/17, 17:52:57
	// ----------------------------------------------------
	//Created : 
	Mods_2017_04
	
	C_LONGINT:C283(LB_ProcessNBEQuery; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(4/24/17 15:13:16)
	Mods_2017_04
	//  `fix totq rounding to 3
	// Modified by: Costas Manousakis-(Designer)-(8/23/17 15:14:14)
	Mods_2017_08
	//  `several mods in sorting
End if 
//

C_LONGINT:C283($0)
$0:=0
C_LONGINT:C283($progress_L)

Case of 
	: (Form event code:C388=On Load:K2:1)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		C_TEXT:C284(PON_NBE_LB_QP_TXT)
		PON_NBE_LB_QP_TXT:="Q"  //Quantity
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt)
		
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; [LB_QueryTable:147]TableNumber_l:3)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		C_TEXT:C284($HeaderVarName_txt)
		
		//Column 1
		
		$ColumnNumber_l:=1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspection Type:31]Description:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Type")
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]BIN:3; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "BIN")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]BDEPT:1; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "BDEPT")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "#-##-###")
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]Insp Date:78; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inspection Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [PON_ELEM_INSP:179]ELEM_KEY:3; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "EL #")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Element Name")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET FONT SIZE:C165(*; $ColumnName_txt; 12)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Units")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 8
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [PON_ELEM_INSP:179]ENVKEY:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Env.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 9
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;[PON_ELEM_INSP]ELEM_QUANTITY;$HeaderVarName_txt;$HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Total Q")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.000")
		
		If (False:C215)
			//Column 10
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [PON_ELEM_INSP:179]ELEM_QorP:29; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "%/Q")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
		End if 
		
		//Column 11
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 1")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.000;;0")
		
		//Column 12
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 2")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.000;;0")
		
		//Column 13
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 3")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.000;;0")
		
		//Column 14
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 4")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.000;;0")
		
		//$ColumnNumber_l:=LISTBOX Get rows height(*;"SelectListBox")
		//LISTBOX SET ROWS HEIGHT(*;"SelectListBox";$ColumnNumber_l*2)
		ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_BIN_Keys)
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283($NoCSs)
		
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[PON_ELEM_INSP:179]INSPID:21)
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		
		C_TEXT:C284($dummy_txt)
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
		LB_Detail6_txt:=[PON_ELEM_DEFS:178]ELEM_LONGNAME:11
		LB_Detail9_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QUANTITY:7; 3)
		LB_Detail7_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
		
		If (PON_NBE_LB_QP_TXT="P")
			LB_Detail10_r:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 3)
			LB_Detail11_r:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 3)
			LB_Detail12_r:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 3)
			LB_Detail13_r:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 3)
			
		Else 
			LB_Detail10_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; 3)
			LB_Detail11_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; 3)
			LB_Detail12_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; 3)
			LB_Detail13_r:=Round:C94([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; 3)
			
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		
		If (Shift down:C543)
			C_TEXT:C284($QorP_choice_txt)
			$QorP_choice_txt:=" ;Display State Quantities;Display State Percent"
			C_LONGINT:C283($QorP_L)
			$QorP_L:=Pop up menu:C542($QorP_choice_txt)
			Case of 
				: ($QorP_L=2)
					//Quantity
					PON_NBE_LB_QP_TXT:="Q"  //Quantity
					OBJECT SET FORMAT:C236(*; "Column_1@"; "##,###,##0.000;;0")
					
				: ($QorP_L=3)
					//Percent
					PON_NBE_LB_QP_TXT:="P"  //Percent
					OBJECT SET FORMAT:C236(*; "Column_1@"; "##,###,##0.000 %;;0")
			End case 
			REDRAW:C174(SELECTLISTBOX)
			$0:=-1
			
		Else 
			Case of 
				: ($nameofObj_txt="LB_Header1_l")  //Insp type
					//skip it
					$0:=-1
					
				: ($nameofObj_txt="LB_Header2_l")  //BIN
					$progress_L:=Progress New
					Progress SET MESSAGE($progress_L; "Sorting....")
					If (LB_SortDirection2_l=0)
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_BIN_Keys; >)
						LB_SortDirection2_l:=1
						Self:C308->:=1
					Else 
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_BIN_Keys("<"); <)
						LB_SortDirection2_l:=0
						Self:C308->:=2
						
					End if 
					Progress QUIT($progress_L)
					$0:=-1
					
				: ($nameofObj_txt="LB_Header3_l")  //BDEPT
					$progress_L:=Progress New
					Progress SET MESSAGE($progress_L; "Sorting....")
					If (LB_SortDirection3_l=0)
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_BDEPT_Keys; >)
						LB_SortDirection3_l:=1
						Self:C308->:=1
					Else 
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_BDEPT_Keys("<"); <)
						LB_SortDirection3_l:=0
						Self:C308->:=2
						
					End if 
					Progress QUIT($progress_L)
					$0:=-1
					
				: ($nameofObj_txt="LB_Header5_l")  //Elem Key
					$progress_L:=Progress New
					Progress SET MESSAGE($progress_L; "Sorting....")
					If (LB_SortDirection5_l=0)
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_ElemKey; >)
						LB_SortDirection5_l:=1
						Self:C308->:=1
					Else 
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_Sort_ElemKey("<"); <)
						LB_SortDirection5_l:=0
						Self:C308->:=2
						
					End if 
					
					Progress QUIT($progress_L)
					
					//skip it
					$0:=-1
					
				: ($nameofObj_txt="LB_Header4_l")  //Insp date
					//skip it
					$0:=-1
					
				: ($nameofObj_txt="LB_Header7_l")  //units
					If (LB_SortDirection7_l=0)
						ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13; >)
						LB_SortDirection7_l:=1
						Self:C308->:=1
					Else 
						ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13; <)
						LB_SortDirection7_l:=0
						Self:C308->:=2
						
					End if 
					$0:=-1
				: ($nameofObj_txt="LB_Header6_l")  // elem name
					If (LB_SortDirection6_l=0)
						ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_DEFS:178]ELEM_SHORTNAME:10; >)
						LB_SortDirection6_l:=1
						Self:C308->:=1
					Else 
						ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_DEFS:178]ELEM_SHORTNAME:10; <)
						LB_SortDirection6_l:=0
						Self:C308->:=2
						
					End if 
					$0:=-1
					
				: ($nameofObj_txt="LB_Header10_l")  // state1 QorP
					If (LB_SortDirection10_l=0)
						
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); >)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; >)
						End if 
						LB_SortDirection10_l:=1
						Self:C308->:=1
						
					Else 
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); <)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; <)
						End if 
						
						LB_SortDirection10_l:=0
						Self:C308->:=2
					End if 
					$0:=-1
					
				: ($nameofObj_txt="LB_Header11_l")  // state2 Q
					
					If (LB_SortDirection11_l=0)
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); >)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; >)
						End if 
						LB_SortDirection11_l:=1
						Self:C308->:=1
					Else 
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); <)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; <)
						End if 
						LB_SortDirection11_l:=0
						Self:C308->:=2
					End if 
					
					$0:=-1
				: ($nameofObj_txt="LB_Header12_l")  // state3 Q
					If (LB_SortDirection12_l=0)
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); >)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; >)
						End if 
						
						LB_SortDirection12_l:=1
						Self:C308->:=1
					Else 
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); <)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; <)
						End if 
						LB_SortDirection12_l:=0
						Self:C308->:=2
						
					End if 
					$0:=-1
				: ($nameofObj_txt="LB_Header13_l")  // state4 Q
					If (LB_SortDirection13_l=0)
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); >)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; >)
						End if 
						LB_SortDirection13_l:=1
						Self:C308->:=1
					Else 
						If (PON_NBE_LB_QP_TXT="P")
							ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; ([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); <)
						Else 
							ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; <)
						End if 
						LB_SortDirection13_l:=0
						Self:C308->:=2
						
					End if 
					$0:=-1
					
					
			End case 
		End if 
		
		
End case 
//End LB_ProcessNBEQuery