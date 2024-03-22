
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/15/12, 14:08:15
//----------------------------------------------------
//Method: Object Method: CloneActivityLogListBox.FieldNames_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001
	//Modified by: Charles Miller (3/15/12 14:08:17)
	
End if 

C_LONGINT:C283($ColumnNumber_l; $TableNumber_l)
C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
C_POINTER:C301($HeaderVar_ptr)
C_POINTER:C301($Field_ptr)
$TableNumber_l:=TableNumber_al{TableNames_atxt}
$Field_ptr:=Field:C253($TableNumber_l; FieldNumbers_al{FieldNames_atxt})

$ColumnNumber_l:=LISTBOX Get number of columns:C831(*; "SelectListBox")+1
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
If ($ColumnNumber_l=1)
	SQL_SelectByTable_txt:="'"
	C_LONGINT:C283(SQLTable_l; SQLLocalID_l)
	SQLTable_l:=$TableNumber_l
	
	Case of 
		: (Type:C295($Field_ptr->)=Is integer:K8:5)
			SQLLocalID_txt:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is longint:K8:6)
			SQLLocalID_txt:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is real:K8:4)
			SQLLocalID_txt:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is date:K8:7)
			SQLLocalID_txt:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is alpha field:K8:1)
			SQLLocalID_txt:=$Field_ptr->
		: (Type:C295($Field_ptr->)=Is text:K8:3)
			SQLLocalID_txt:=$Field_ptr->
		Else 
			ALERT:C41("Can not choose this as first column")
			$Continue_b:=False:C215
	End case 
	SQL_SelectByTable_txt:="WHERE [FileID Local]=:SQLTable_l and [Local ID]=:SQLLocalID_txt"
End if 
If ($Continue_b)
	
	C_POINTER:C301(ACTLOGLocalID_Ptr)
	If ($ColumnNumber_l=1)
		ACTLOGLocalID_Ptr:=$Field_ptr
	End if 
	LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
	LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $Field_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
	OBJECT SET TITLE:C194($HeaderVar_ptr->; FieldNames_atxt{FieldNames_atxt})
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
	OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
End if 

//End Object Method: CloneActivityLogListBox.FieldNames_atxt

