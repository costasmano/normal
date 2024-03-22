//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:08:26
	// ----------------------------------------------------
	// Method: SC_Table60_61_value
	// Description
	// get the value from table 60_61
	// Scour vulnerable bridges based on 60 and 61
	// 
	// Parameters
	// $1 : $i60_txt
	// $2 : $i61_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
End if 
C_TEXT:C284($1; $i60_txt; $2; $i61_txt; $0; $value)
$i60_txt:=$1
$i61_txt:=$2
$value:=""
C_LONGINT:C283($i60_L; $i61_L)
$i60_L:=Find in array:C230(SC_TBL6061_ColH_atxt; $i60_txt)
$i61_L:=Find in array:C230(SC_TBL6061_RowH_atxt; $i61_txt)
If ($i60_L>0) & ($i61_L>0)
	C_BLOB:C604($temp_blob)
	ARRAY TEXT:C222($RowVals; 0)
	$temp_blob:=ut_ParseTextToArrayDelim(SC_TBL6061_Rows_atxt{$i61_L}; ",")
	BLOB TO VARIABLE:C533($temp_blob; $RowVals)
	$value:=$RowVals{$i60_L}
	SET BLOB SIZE:C606($temp_blob; 0)
End if 
$0:=$value