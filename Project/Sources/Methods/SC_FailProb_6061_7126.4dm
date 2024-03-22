//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:07:14
	// ----------------------------------------------------
	// Method: SC_FailProb_6061_7126
	// Description
	// Get the failure probability based on item61,60,71,26
	// 
	// Parameters
	// $1 : $i60_txt
	// $2 : $i61_txt
	// $3 : $i71_txt
	// $4 : $i26_txt
	
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
End if 
C_REAL:C285($0; $FailProb_r)
C_TEXT:C284($1; $i60_txt; $2; $i61_txt; $3; $i71_txt; $4; $i26_txt)
If (Count parameters:C259=4)
	C_TEXT:C284($1; $2; $3; $4)
	$i60_txt:=$1
	$i61_txt:=$2
	$i71_txt:=$3
	$i26_txt:=$4
Else 
	$i60_txt:=[Bridge MHD NBIS:1]Item60:132
	$i61_txt:=[Bridge MHD NBIS:1]Item61:133
	$i71_txt:=[Bridge MHD NBIS:1]Item71:145
	$i26_txt:=[Bridge MHD NBIS:1]Item26:120
End if 
C_TEXT:C284($1; $i60_txt; $2; $i61_txt; $3; $i71_txt; $4; $i26_txt)
$FailProb_r:=0
C_TEXT:C284($i6061res; $i7126res)
$i6061res:=SC_Table60_61_value($i60_txt; $i61_txt)
$i7126res:=SC_Table71_26_value($i71_txt; $i26_txt)
C_LONGINT:C283($FailProbCol_L; $FailProbRow_L)
$FailProbCol_L:=Find in array:C230(SC_TBLFail_colH_atxt; $i7126res)
$FailProbRow_L:=Find in array:C230(SC_TBLFail_RowH_atxt; $i6061res)
If (($FailProbCol_L>0) & ($FailProbRow_L>0))
	C_BLOB:C604($temp_blob)
	ARRAY TEXT:C222($RowVals; 0)
	$temp_blob:=ut_ParseTextToArrayDelim(SC_TBLFail_Rows_atxt{$FailProbRow_L}; ",")
	BLOB TO VARIABLE:C533($temp_blob; $RowVals)
	$FailProb_r:=Num:C11($RowVals{$FailProbCol_L})
	SET BLOB SIZE:C606($temp_blob; 0)
	
End if 
$0:=$FailProb_r