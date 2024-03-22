//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_MoveToIncluded
// User name (OS): cjmiller
// Date and time: 04/19/05, 11:49:00
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:54:29
End if 
C_LONGINT:C283($iSize)  //Command Replaced was o_C_INTEGER
$iSize:=Size of array:C274(aIt8OwnerDesIncluded)
INSERT IN ARRAY:C227(aIt8OwnerDesIncluded; $iSize+1; 1)
INSERT IN ARRAY:C227(aIt8OwnerDesIncludedCode; $iSize+1; 1)

aIt8OwnerDesIncluded{$iSize+1}:=aIt8OwnerDes{aIt8OwnerDes}
aIt8OwnerDesIncludedCode{$iSize+1}:=aIt8OwnerCode{aIt8OwnerDes}
C_LONGINT:C283($element_l)
$element_l:=aIt8OwnerDes
DELETE FROM ARRAY:C228(aIt8OwnerDes; $element_l; 1)
DELETE FROM ARRAY:C228(aIt8OwnerCode; $element_l; 1)

SORT ARRAY:C229(aIt8OwnerDesIncludedCode; aIt8OwnerDesIncluded; >)
//End SD_MoveToIncluded
