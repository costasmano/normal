//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/11/12, 11:21:17
//----------------------------------------------------
//Method: LB_SetUPFieldColumn
//Description
//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)

// Parameters
// ----------------------------------------------------
//$1 longint column number
//$2 pointer to heaer name
//$3 Pointer to header nae
//$4 pointer to column name
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/11/12 11:21:18)
	
End if 
C_LONGINT:C283($1; $ColumnNumber_l)
C_POINTER:C301($3; $4; $2)
$ColumnNumber_l:=$1
C_TEXT:C284($HeaderVarName_txt)


$HeaderVarName_txt:="LB_Header"+String:C10($ColumnNumber_l)+"_l"
$2->:=$HeaderVarName_txt
$3->:=Get pointer:C304($HeaderVarName_txt)
$4->:="Column_"+String:C10($ColumnNumber_l; "00")

//End LB_SetUPFieldColumn

