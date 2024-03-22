//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_MoveToExluded
// User name (OS): cjmiller
// Date and time: 04/19/05, 11:49:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:54:44
End if 
C_LONGINT:C283($iSize)  //Command Replaced was o_C_INTEGER
$iSize:=Size of array:C274(aIt8OwnerDes)
INSERT IN ARRAY:C227(aIt8OwnerDes; $iSize+1; 1)
INSERT IN ARRAY:C227(aIt8OwnerCode; $iSize+1; 1)

aIt8OwnerDes{$iSize+1}:=aIt8OwnerDesIncluded{aIt8OwnerDesIncluded}
aIt8OwnerCode{$iSize+1}:=aIt8OwnerDesIncludedCode{aIt8OwnerDesIncluded}
C_LONGINT:C283($element_l)
$element_l:=aIt8OwnerDesIncluded
DELETE FROM ARRAY:C228(aIt8OwnerDesIncluded; $element_l; 1)
DELETE FROM ARRAY:C228(aIt8OwnerDesIncludedCode; $element_l; 1)

SORT ARRAY:C229(aIt8OwnerCode; aIt8OwnerDes; >)
//End SD_MoveToExluded
