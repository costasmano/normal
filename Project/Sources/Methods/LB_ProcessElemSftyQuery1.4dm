//%attributes = {"invisible":true}
//Method: LB_ProcessElemSftyQuery1
//Description
//
// Parameters
// $0 : ReturnCode - default 0
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 01/03/12, 14:56:58
	//----------------------------------------------------
	Mods_2011_12  //r004
	//Modified by: Charles Miller (1/3/12 14:56:59)
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(2/12/14 12:33:12)
	Mods_2014_02_bug
	//  `Made  vars for ELEMSafetyQuery2 non enterable
	// Modified by: Costas Manousakis-(Designer)-(2021-12-27T00:00:00 19:06:50)
	Mods_2021_12_bug
	//  `use methods INSP_LoadElemsByInspType and INSP_GetElmtNumber to account for reports where insp type controls the 
	//  `element numbering
End if 
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
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
		
		If ([LB_QueryTable:147]QueryName_s:1="ELEMSafetyQuery2")  //addin remaining columns
			//Column 5
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header5_l; "Item No")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
			
			//Column 6
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header6_l; "Description")
			OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
			
			//Column 7
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [ElementsSafety:29]Rating:2; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header7_l; "Cur")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
			//Column 8
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [ElementsSafety:29]AltRating:21; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header8_l; "Dive")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
			//Column 9
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [ElementsSafety:29]Deficiency:3; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header9_l; "Def")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
			//Column 10
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [ElementsSafety:29]Priority:20; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header10_l; "Prio")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
			//Column 11
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [ElementsSafety:29]Comment Flag:6; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(LB_Header11_l; "T")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
		End if 
		
		//define object with element number defs by insp type
		INSP_LoadElemsByInspType
		
	: (Form event code:C388=On Display Detail:K2:22)
		If ([LB_QueryTable:147]QueryName_s:1="ELEMSafetyQuery2")  //add in remaining columns
			C_LONGINT:C283($Element_l)
			LB_Detail5_txt:=INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1)
			LB_Detail6_txt:=INSP_GetElmtNumber+" "+[ElementsSafety:29]Description:22
			If (INSP_IsInspRoutine_b)
				If ([ElementsSafety:29]SpecMemb Flag:8)
					LB_Detail6_txt:=LB_Detail6_txt+" - (Spec.Mb.)"
				End if 
				LB_RowStyle_l:=0
				If (([ElementsSafety:29]ElementNo:1=300) | ([ElementsSafety:29]ElementNo:1=313) | ([ElementsSafety:29]ElementNo:1=325))
					LB_RowStyle_l:=Bold:K14:2
				End if 
			End if 
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		If ([LB_QueryTable:147]QueryName_s:1="ELEMSafetyQuery2")  //addin remaining columns
			C_TEXT:C284($NameofObj_txt)
			C_LONGINT:C283($dumTbl_L; $dumFld_L)
			RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
			Case of 
				: ($nameofObj_txt="LB_Header5_l")
					If (LB_SortDirection5_l=0)
						ORDER BY FORMULA:C300([ElementsSafety:29]; INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1); >)
						LB_SortDirection5_l:=1
						LB_Header5_l:=1
					Else 
						ORDER BY FORMULA:C300([ElementsSafety:29]; INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1); <)
						LB_SortDirection5_l:=0
						LB_Header5_l:=2
					End if 
					$0:=-1
					
				: ($nameofObj_txt="LB_Header6_l")
					If (LB_SortDirection6_l=0)
						ORDER BY FORMULA:C300([ElementsSafety:29]; INSP_GetElmtNumber+" "+[ElementsSafety:29]Description:22; >)
						LB_SortDirection6_l:=1
						LB_Header6_l:=1
					Else 
						ORDER BY FORMULA:C300([ElementsSafety:29]; INSP_GetElmtNumber+" "+[ElementsSafety:29]Description:22; <)
						LB_Header6_l:=2
						LB_SortDirection6_l:=0
					End if 
					$0:=-1
					
			End case 
		End if 
		
End case 
//End LB_ProcessElemSftyQuery1