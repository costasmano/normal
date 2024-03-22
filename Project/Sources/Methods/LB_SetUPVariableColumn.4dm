//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/11/12, 10:46:36
//----------------------------------------------------
//Method: LB_SetUPVariableColumn
//Description
//LB_SetUPColumns($ColumnNumber_l;->$HeaderVarName_txt;->;$ColumnVar_ptr;$HeaderVar_ptr;$ColumnName_txt->;"txt")
// Parameters
// ----------------------------------------------------
//$1 long column number
//$2 pointer to header variable name
//$3 pointer to column variable pointer
//$4 pointer to header variable pointer
//$5 pointer to column name 

If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/11/12 10:46:40)
	ut_TextToArray
End if 
C_LONGINT:C283($1; $ColumnNumber_l)
C_POINTER:C301($3; $4; $2; $5)
$ColumnNumber_l:=$1
C_TEXT:C284($6; $HeaderVarName_txt; $Type_txt)
$Type_txt:=$6

$HeaderVarName_txt:="LB_Header"+String:C10($ColumnNumber_l)+"_l"
$2->:=$HeaderVarName_txt
$3->:=Get pointer:C304("LB_Detail"+String:C10($ColumnNumber_l)+"_"+$Type_txt)
$4->:=Get pointer:C304($HeaderVarName_txt)
$5->:="Column_"+String:C10($ColumnNumber_l; "00")

//End LB_SetUPVariableColumn

