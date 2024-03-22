//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/03/12, 12:31:32
//----------------------------------------------------
//Method: LB_ProcessINSPQuery2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r004
	//Modified by: Charles Miller (1/3/12 12:31:33)
	Mods_2020_10  // //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/8/20 14:28:27)  
End if 
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr)
		
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; [LB_QueryTable:147]TableNumber_l:3)
		//Column 1
		$ColumnNumber_l:=1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspection Type:31]Description:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header1_l; "Type")
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]BIN:1; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header2_l; "BIN")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]BDEPT:1; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header3_l; "BDEPT")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]Insp Date:78; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header4_l; "Inspection Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; LB_Detail5_txt; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header5_l; "Team Leader")
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]InspComplete:168; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header6_l; "Compl.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; LB_Detail7_pct; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header7_l; "Revwd.")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		
		
		//Column 8
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; LB_Detail8_pct; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header8_l; "Aprvd.")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		
		//Column 9
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]Town Name:175; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header9_l; "Town.")
		
		//Column 10
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]Item7:65; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header10_l; "Item 7")
		
		//Column 11
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]Item6A:63; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header11_l; "Item 6A")
		
		C_LONGINT:C283($0)
	: (Form event code:C388=On Display Detail:K2:22)
		LB_Detail5_txt:=QR_PersonName([Inspections:27]TeamLeader:4)
		Case of 
			: ([Inspections:27]InspApproved:167=0)
				LB_Detail7_pct:=LB_Detail7_pct*0
			: ([Inspections:27]InspApproved:167=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail7_pct)
			: ([Inspections:27]InspApproved:167=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail7_pct)
				
		End case 
		Case of 
			: ([Inspections:27]InspReviewed:12=0)
				LB_Detail8_pct:=LB_Detail8_pct*0
			: ([Inspections:27]InspReviewed:12=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail8_pct)
			: ([Inspections:27]InspReviewed:12=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail8_pct)
				
		End case 
		
	: (Form event code:C388=On Header Click:K2:40)
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		Case of 
			: ($nameofObj_txt="LB_Header5_l")
				If (LB_SortDirection5_l=0)
					ORDER BY FORMULA:C300([Inspections:27]; QR_PersonName([Inspections:27]TeamLeader:4); >)
					LB_Header5_l:=1
					LB_SortDirection5_l:=1
				Else 
					ORDER BY FORMULA:C300([Inspections:27]; QR_PersonName([Inspections:27]TeamLeader:4); <)
					LB_Header5_l:=2
					LB_SortDirection5_l:=0
				End if 
				$0:=-1
		End case 
		
End case 
//End LB_ProcessINSPQuery2

