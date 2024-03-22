//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/05/12, 10:59:33
//----------------------------------------------------
//Method: LB_ProcessStandasrdPhotoQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/5/12 10:59:34)
	
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
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Standard Photos:36]PictType:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header5_l; "Type")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Standard Photos:36]Description:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header6_l; "Type")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Standard Photos:36]SeqNum:6; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header7_l; "Sequence")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		
	: (Form event code:C388=On Display Detail:K2:22)
	: (Form event code:C388=On Header Click:K2:40)
		
End case 
//End LB_ProcessStandasrdPhotoQuery

