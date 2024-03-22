//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/20/05, 11:50:28
	// ----------------------------------------------------
	// Method: Method: ut_addGroupMembers
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(7/20/10 19:29:14)
	Mods_2010_07
	//  `Use Append to array instead of insert element, etc.
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($1; $groupNo; $i; $numsubs; $j)
$groupNo:=$1
$i:=Find in array:C230(alGRIDs; $groupNo)
$numsubs:=Size of array:C274(alMembers{$i})
For ($j; 1; $numsubs)
	If (Abs:C99(alMembers{$i}{$j})>14999)
		//group -...
		ut_addGroupMembers(alMembers{$i}{$j})
	Else 
		//INSERT ELEMENT(alGroupUserIDs;(Size of array(alGroupUserIDs)+1))
		//alGroupUserIDs{Size of array(alGroupUserIDs)}:=alMembers{$i}{$j}
		APPEND TO ARRAY:C911(alGroupUserIDs; alMembers{$i}{$j})
	End if 
End for 