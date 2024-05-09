//%attributes = {"invisible":true}
// Method: LSS_SetUpInventoryListBox
// Description
// 
//
// Parameters
If (False:C215)
	// ----------------------------------------------------
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/23/14, 13:58:17
	// ----------------------------------------------------
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 16:32:08)
	Mods_2016_02_bug
	//  `for section 3.0 and Highway signs (HS) use field [LSS_Inspection]LSS_CondSignPanelsCurr_s
	// Modified by: Costas Manousakis-(Designer)-(2024-02-28 12:34:06)
	Mods_2024_LSS_1
	//  `added columns for contract number and assignment number
End if 

Compiler_LB
C_LONGINT:C283($ColumnNumber_l; $TotalLB_width_L)
C_TEXT:C284($ColumnName_txt)
ARRAY TEXT:C222($ColumnNames_atxt; 0)
ARRAY TEXT:C222($HeaderNames_atxt; 0)
ARRAY TEXT:C222($ColumnVariables_atxt; 0)
ARRAY TEXT:C222($HeaderVariables_atxt; 0)
ARRAY BOOLEAN:C223($Visible_ab; 0)
ARRAY LONGINT:C221($Styles_aL; 0)

LISTBOX DELETE COLUMN:C830(*; "Inspection_LB"; 1; 99)
LISTBOX SET TABLE SOURCE:C1013(*; "Inspection_LB"; Table:C252(->[LSS_Inspection:164]))

C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
C_TEXT:C284($HeaderVarName_txt)
$TotalLB_width_L:=0

$ColumnNumber_l:=1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_InspectionDate_d:4; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inspection Date")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7))

OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 100)
$TotalLB_width_L:=$TotalLB_width_L+100

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inspection Type")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 100)
$TotalLB_width_L:=$TotalLB_width_L+100

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondFoundationCurr_s:12; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "1.")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 25)
$TotalLB_width_L:=$TotalLB_width_L+25

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondStructureCurr_s:14; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "2.")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 25)
$TotalLB_width_L:=$TotalLB_width_L+25

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
Case of 
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16; $HeaderVarName_txt; $HeaderVar_ptr->)
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18; $HeaderVarName_txt; $HeaderVar_ptr->)
	Else 
		LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondLuminaireCurr_s:22; $HeaderVarName_txt; $HeaderVar_ptr->)
End case 
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "3.")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 25)
$TotalLB_width_L:=$TotalLB_width_L+25

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondTrafficSafetyCurr_s:20; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "4.")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 25)
$TotalLB_width_L:=$TotalLB_width_L+25

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_CondOverallCurr_s:24; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Overall")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 50)
$TotalLB_width_L:=$TotalLB_width_L+50

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_Complete_b:39; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "C")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 30)
$TotalLB_width_L:=$TotalLB_width_L+30

$ColumnNumber_l:=$ColumnNumber_l+1
//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
//INSERT LISTBOX COLUMN(*;"Inspection_LB";$ColumnNumber_l;$ColumnName_txt;[LSS_Inspection]LSS_Approved_L;$HeaderVarName_txt;$HeaderVar_ptr->)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "A")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))

LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 30)
$TotalLB_width_L:=$TotalLB_width_L+30

//start of Mods_2024_LSS_1

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_ContractNo_L:60; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Contract")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 55)
OBJECT SET FORMAT:C236(*; $ColumnName_txt; "#######;;-")
$TotalLB_width_L:=$TotalLB_width_L+55

$ColumnNumber_l:=$ColumnNumber_l+1
LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
LISTBOX INSERT COLUMN:C829(*; "Inspection_LB"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inspection:164]LSS_AssignmentNo_L:61; $HeaderVarName_txt; $HeaderVar_ptr->)
OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "AssignNo")
OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
LISTBOX SET COLUMN WIDTH:C833(*; $ColumnName_txt; 55)
OBJECT SET FORMAT:C236(*; $ColumnName_txt; "#######;;-")
$TotalLB_width_L:=$TotalLB_width_L+55
//start of Mods_2024_LSS_1


C_LONGINT:C283($LBL_L; $LBT_L; $LBR_L; $LBB_L)
OBJECT GET COORDINATES:C663(*; "Inspection_LB_Label"; $LBL_L; $LBT_L; $LBR_L; $LBB_L)
OBJECT MOVE:C664(*; "Inspection_LB_Label"; $LBL_L; $LBT_L; ($LBL_L+$TotalLB_width_L); $LBB_L; *)
OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $LBL_L; $LBT_L; $LBR_L; $LBB_L)
$TotalLB_width_L:=$TotalLB_width_L+20  //add 20 for vert scrollbar
OBJECT MOVE:C664(*; "Inspection_LB"; $LBL_L; $LBT_L; ($LBL_L+$TotalLB_width_L); $LBB_L; *)