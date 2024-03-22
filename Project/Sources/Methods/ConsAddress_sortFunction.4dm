//%attributes = {"invisible":true}
//Method: ConsAddress_sortFunction
//Description
//This method sorts consultant address records by 3 check boxes
//[Conslt Address]Func_Design
//[Conslt Address]Func_Insp
//[Conslt Address]Func_Rating
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/09/19, 15:15:38
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07
	//Modified by: Chuck Miller (7/9/19 16:25:21)
	Mods_2019_07  //Added declaration of missing array $RecordNumbers_al
	//Modified by: Chuck Miller (7/18/19 12:13:19)
End if 
//
ARRAY LONGINT:C221($RecordNumbers_al; 0)
LONGINT ARRAY FROM SELECTION:C647([Conslt Address:77]; $RecordNumbers_al)

ARRAY BOOLEAN:C223($FuncRating_aB; 0)
ARRAY BOOLEAN:C223($FuncInsp_aB; 0)
ARRAY BOOLEAN:C223($FuncDesign_aB; 0)
ARRAY LONGINT:C221($sortingArray_aL; 0)

ARRAY TEXT:C222($SortPosition_atxt; 0)
ARRAY TEXT:C222($SortPosition_atxt; 8)
$SortPosition_atxt{1}:=""
$SortPosition_atxt{2}:="Rating"
$SortPosition_atxt{3}:="Inspection"
$SortPosition_atxt{4}:="Design"
$SortPosition_atxt{5}:="Insp.,Ratg."
$SortPosition_atxt{6}:="Insp.,Des."
$SortPosition_atxt{7}:="Ratg.,Des."
$SortPosition_atxt{8}:="Ratg.,Insp.,Des."
SORT ARRAY:C229($SortPosition_atxt; >)
C_LONGINT:C283($Pos_L)
C_LONGINT:C283($numRecs_L)
$numRecs_L:=Size of array:C274($RecordNumbers_al)
ARRAY BOOLEAN:C223($FuncRating_aB; $numRecs_L)
ARRAY BOOLEAN:C223($FuncInsp_aB; $numRecs_L)
ARRAY BOOLEAN:C223($FuncDesign_aB; $numRecs_L)

ARRAY LONGINT:C221($sortingArray_aL; $numRecs_L)
C_TEXT:C284($value_txt)
SELECTION RANGE TO ARRAY:C368(1; $numRecs_L; [Conslt Address:77]Func_Design:21; $FuncDesign_aB; [Conslt Address:77]Func_Insp:20; $FuncInsp_aB; [Conslt Address:77]Func_Rating:19; $FuncRating_aB)
C_LONGINT:C283($Loop_L)
For ($Loop_L; 1; $numRecs_L)
	$value_txt:=""
	Case of 
		: (($FuncRating_aB{$Loop_L}=True:C214) & ($FuncInsp_aB{$Loop_L}=True:C214) & ($FuncDesign_aB{$Loop_L}=True:C214))
			$value_txt:="Ratg.,Insp.,Des."
		: (($FuncDesign_aB{$Loop_L}=True:C214) & ($FuncRating_aB{$Loop_L}=True:C214))
			$value_txt:="Ratg.,Des."
		: (($FuncDesign_aB{$Loop_L}=True:C214) & ($FuncInsp_aB{$Loop_L}=True:C214))
			$value_txt:="Insp.,Des."
		: (($FuncRating_aB{$Loop_L}=True:C214) & ($FuncInsp_aB{$Loop_L}=True:C214))
			$value_txt:="Insp.,Ratg."
		: ($FuncDesign_aB{$Loop_L}=True:C214)
			$value_txt:="Design"
			
		: ($FuncInsp_aB{$Loop_L}=True:C214)
			$value_txt:="Inspection"
		: ($FuncRating_aB{$Loop_L}=True:C214)
			$value_txt:="Rating"
			
	End case 
	
	$Pos_L:=Find in array:C230($SortPosition_atxt; $value_txt)
	$sortingArray_aL{$Loop_L}:=$pos_L
End for 

If (LB_Header3_l>1)
	SORT ARRAY:C229($sortingArray_aL; $RecordNumbers_al; >)
	LB_Header3_l:=1
Else 
	SORT ARRAY:C229($sortingArray_aL; $RecordNumbers_al; <)
	LB_Header3_l:=2
End if 
CREATE SELECTION FROM ARRAY:C640([Conslt Address:77]; $RecordNumbers_al)

//End ConsAddress_sortFunction