//%attributes = {"invisible":true}
//Method: FN_ReturnRecordCount
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/12/20, 18:30:00
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03  //Fix issue with clone call to return record counts for
	//[Standard Photos] and [ElementsSafety]
	
End if 
//


C_TEXT:C284($Return_txt)
C_LONGINT:C283($SPCount_L; $ESCount_L; $Size_L; $Loop_L)
C_TEXT:C284($0)
$SPCount_L:=0
$ESCount_L:=0
C_TEXT:C284($1)

C_TEXT:C284($SendArrays_txt)
$SendArrays_txt:=$1
ARRAY TEXT:C222($Parts_atxt; 0)
C_TEXT:C284($queryType_txt)
ARRAY LONGINT:C221($IDs_al; 0)
ut_NewTextToArray($SendArrays_txt; ->$Parts_atxt; ",")
$Size_L:=Num:C11($Parts_atxt{1})

ARRAY LONGINT:C221($IDs_al; $Size_L)
For ($Loop_l; 2; $Size_L)
	$IDs_al{$Loop_L-1}:=Num:C11($Parts_atxt{$Loop_L})
	
End for 

SET QUERY DESTINATION:C396(Into variable:K19:4; $SPCount_L)
QUERY WITH ARRAY:C644([Standard Photos:36]InspID:1; $IDs_al)

$0:=""
SET QUERY DESTINATION:C396(Into variable:K19:4; $ESCount_L)
QUERY WITH ARRAY:C644([ElementsSafety:29]InspID:4; $IDs_al)
$0:=String:C10($SPCount_L)+","+String:C10($ESCount_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

//End FN_ReturnRecordCount