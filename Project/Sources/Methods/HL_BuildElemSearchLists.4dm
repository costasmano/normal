//%attributes = {"invisible":true}
//Method: HL_BuildElemSearchLists
//Description
// build the Lists that can be used in Inspection element searches [ElementsSafety] or [LSS_ElementInspection]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/08/19, 10:38:38
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//

ARRAY TEXT:C222($menuLine_atxt; 0)
ARRAY TEXT:C222($menuParams_atxt; 0)
ARRAY TEXT:C222($Values_atxt; 0)
ARRAY TEXT:C222($Valuesdesc_atxt; 0)
C_LONGINT:C283($NewList_L)
C_LONGINT:C283($loop_L)
C_TEXT:C284($Comparison_txt; $ComparisonOper_txt)

APPEND TO ARRAY:C911($Values_atxt; "M")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "M=Minor deficiency")
APPEND TO ARRAY:C911($Values_atxt; "S")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "S=Severe deficiency")
APPEND TO ARRAY:C911($Values_atxt; "C-S")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "C-S=Critical Structural deficiency")
APPEND TO ARRAY:C911($Values_atxt; "C-H")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "C-H=Critical Hazard deficiency")
COPY ARRAY:C226(<>aDefCAT; $Valuesdesc_atxt)
COPY ARRAY:C226(<>aDefCode; $Values_atxt)
DELETE FROM ARRAY:C228($Valuesdesc_atxt; 1; 1)
DELETE FROM ARRAY:C228($Values_atxt; 1; 1)

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
$Comparison_txt:="less than ("+$ComparisonOper_txt+")"

For ($loop_L; 2; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="<="
$Comparison_txt:="less than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$ComparisonOper_txt:=">"
$Comparison_txt:="greater than ("+$ComparisonOper_txt+")"
For ($loop_L; 1; (Size of array:C274($Values_atxt)-1))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$ComparisonOper_txt:=">="
$Comparison_txt:="greater than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$NewList_L:=New list:C375

Menu_BuildHLFromArrays($NewList_L; ->$menuLine_atxt; ->$menuParams_atxt; "\\")

SAVE LIST:C384($NewList_L; "Search_ElemDeficiency")

CLEAR LIST:C377($NewList_L; *)


ARRAY TEXT:C222($menuLine_atxt; 0)
ARRAY TEXT:C222($menuParams_atxt; 0)
ARRAY TEXT:C222($Values_atxt; 0)
ARRAY TEXT:C222($Valuesdesc_atxt; 0)
APPEND TO ARRAY:C911($Values_atxt; "I")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "I=Immediate")
APPEND TO ARRAY:C911($Values_atxt; "A")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "A=ASAP")
APPEND TO ARRAY:C911($Values_atxt; "P")
APPEND TO ARRAY:C911($Valuesdesc_atxt; "P=Prioritize")
COPY ARRAY:C226(<>aUORCAT; $Valuesdesc_atxt)
COPY ARRAY:C226(<>aUORCode; $Values_atxt)
DELETE FROM ARRAY:C228($Valuesdesc_atxt; 1; 1)
DELETE FROM ARRAY:C228($Values_atxt; 1; 1)

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
$Comparison_txt:="less than ("+$ComparisonOper_txt+")"

For ($loop_L; 1; (Size of array:C274($Values_atxt)-1))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="<="
$Comparison_txt:="less than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">"
$Comparison_txt:="greater than ("+$ComparisonOper_txt+")"
For ($loop_L; 2; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">="
$Comparison_txt:="greater than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; 1; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$NewList_L:=New list:C375

Menu_BuildHLFromArrays($NewList_L; ->$menuLine_atxt; ->$menuParams_atxt; "\\")

SAVE LIST:C384($NewList_L; "Search_ElemUrgency")

CLEAR LIST:C377($NewList_L; *)

ARRAY TEXT:C222($menuLine_atxt; 0)
ARRAY TEXT:C222($menuParams_atxt; 0)
ARRAY TEXT:C222($Values_atxt; 0)
ARRAY TEXT:C222($Valuesdesc_atxt; 0)

LIST TO ARRAY:C288("Rating Categories"; $Valuesdesc_atxt)
LIST TO ARRAY:C288("Rating Codes"; $Values_atxt)
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
$Comparison_txt:="less than ("+$ComparisonOper_txt+")"

For ($loop_L; ($ZeroPos_L+1); Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:="<="
$Comparison_txt:="less than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; $ZeroPos_L; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">"
$Comparison_txt:="greater than ("+$ComparisonOper_txt+")"
For ($loop_L; $ZeroPos_L; (Size of array:C274($Values_atxt)-1))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 

$ComparisonOper_txt:=">="
$Comparison_txt:="greater than or equal to ("+$ComparisonOper_txt+")"
For ($loop_L; $ZeroPos_L; Size of array:C274($Values_atxt))
	APPEND TO ARRAY:C911($menuLine_atxt; $Comparison_txt+"\\"+$Valuesdesc_atxt{$loop_L})
	APPEND TO ARRAY:C911($menuParams_atxt; $Comparison_txt+" : "+$Valuesdesc_atxt{$loop_L}+";"+$ComparisonOper_txt+";"+$Values_atxt{$loop_L})
End for 
$NewList_L:=New list:C375

Menu_BuildHLFromArrays($NewList_L; ->$menuLine_atxt; ->$menuParams_atxt; "\\")

SAVE LIST:C384($NewList_L; "Search_ElemRating")

CLEAR LIST:C377($NewList_L; *)


//End HL_BuildElemSearchLists