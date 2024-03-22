//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/04/05, 20:41:02
	// ----------------------------------------------------
	// Method: WKHR_RecalcRevEdt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($RevPageTotal; $NumItems; $i; $j)
C_REAL:C285($RevPageTot1; $RevPageTot2; $RevPageTot3; $RevPageTot4; $RevPageTot5; $RevPageTot6)

arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")

//Sum total hours
$NumItems:=Size of array:C274(arrPtr_3->{1})
For ($j; 1; 6)
	For ($i; 1; $NumItems)
		arrPtr_4->{$j}:=arrPtr_4->{$j}+arrPtr_3->{$j}{$i}
	End for 
End for 

$RevPageTotal:=Find in array:C230(Arr_WKHR_ReviewRef; Num:C11(CategoryPrefix))