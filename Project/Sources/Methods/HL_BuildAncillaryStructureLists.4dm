//%attributes = {"invisible":true}
//Method: HL_BuildAncillaryStructureLists
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/09/19, 11:28:55
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//

C_LONGINT:C283($Loop_L; $InnerLoop_L; $NewList_L)
C_TEXT:C284($Comparison_txt; $ComparisonOper_txt)

ARRAY TEXT:C222($v_171_004_atxt; 0)
APPEND TO ARRAY:C911($v_171_004_atxt; "ITS")
APPEND TO ARRAY:C911($v_171_004_atxt; "Light")
APPEND TO ARRAY:C911($v_171_004_atxt; "Sign")
APPEND TO ARRAY:C911($v_171_004_atxt; "Signal")

ARRAY TEXT:C222($Values_atxt; 0)
APPEND TO ARRAY:C911($Values_atxt; "ALL")
APPEND TO ARRAY:C911($Values_atxt; "District 1")
APPEND TO ARRAY:C911($Values_atxt; "District 2")
APPEND TO ARRAY:C911($Values_atxt; "District 3")
APPEND TO ARRAY:C911($Values_atxt; "District 4")
APPEND TO ARRAY:C911($Values_atxt; "District 5")
APPEND TO ARRAY:C911($Values_atxt; "District 6")
ARRAY TEXT:C222($MenuLines_atxt; 0)
ARRAY TEXT:C222($MenuParameters_atxt; 0)

For ($Loop_L; 1; Size of array:C274($v_171_004_atxt))
	
	For ($InnerLoop_L; 1; Size of array:C274($Values_atxt))
		APPEND TO ARRAY:C911($MenuLines_atxt; $v_171_004_atxt{$Loop_L}+"\\"+$Values_atxt{$InnerLoop_L})
		APPEND TO ARRAY:C911($MenuParameters_atxt; $v_171_004_atxt{$Loop_L}+";"+$Values_atxt{$InnerLoop_L})
		
		
	End for 
	
	
	
End for 
$NewList_L:=New list:C375

Menu_BuildHLFromArrays($NewList_L; ->$MenuLines_atxt; ->$MenuParameters_atxt; "\\")

SAVE LIST:C384($NewList_L; "Search_AncillaryStructures")

CLEAR LIST:C377($NewList_L; *)


ARRAY TEXT:C222($menuLine_atxt; 0)
ARRAY TEXT:C222($menuParams_atxt; 0)
ARRAY TEXT:C222($Values_atxt; 0)
ARRAY TEXT:C222($Valuesdesc_atxt; 0)
APPEND TO ARRAY:C911($Values_atxt; "1")
APPEND TO ARRAY:C911($Values_atxt; "2")
APPEND TO ARRAY:C911($Values_atxt; "3")
APPEND TO ARRAY:C911($Values_atxt; "4")
APPEND TO ARRAY:C911($Values_atxt; "H")
APPEND TO ARRAY:C911($Values_atxt; "R")
APPEND TO ARRAY:C911($Values_atxt; "X")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "1 Good")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "2 Fair")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "3 Poor")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "4 Critical")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "H Hidden/Inaccessible")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "R Removed")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "X Unknown")

C_LONGINT:C283($ZeroPos_L; $NinePos_L)
$ZeroPos_L:=Find in array:C230($Values_atxt; "0")

$ComparisonOper_txt:="="
$Comparison_txt:="equal to ("+$ComparisonOper_txt+")"

For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="#"
$Comparison_txt:="not equal to ("+$ComparisonOper_txt+")"

For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="<"
$Comparison_txt:="Worse than ("+$ComparisonOper_txt+")"

For ($loop_L; 1; 3)
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="<="
$Comparison_txt:="Worse than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; 4)
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">"
$Comparison_txt:="Better than ("+$ComparisonOper_txt+")"
For ($loop_L; 2; 4)
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">="
$Comparison_txt:="Better than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; 4)
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$NewList_L:=New list:C375

Menu_BuildHLFromArrays($NewList_L; ->$menuLine_atxt; ->$menuParams_atxt; "\\")

SAVE LIST:C384($NewList_L; "Search_ElemRatingAncillary")

CLEAR LIST:C377($NewList_L; *)

//End HL_BuildAncillaryStructureLists