//%attributes = {"invisible":true}
//Method: ut_Rank
//Description
//  ` Do a ranking based on values
//  ` $ValuesArray_ptr must be sorted already
// Parameters
// $1 : $ValuesArray_ptr
// $2 : $RankArray_ptr
// $3 : SortOrder_txt (Optional - default <)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/25/14, 09:12:16
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($2)

C_POINTER:C301($ValuesArray_ptr; $RankArray_ptr)
C_TEXT:C284($sortOrder_txt)
$sortOrder_txt:="<"

If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$sortOrder_txt:=$3
End if 

$ValuesArray_ptr:=$1
$RankArray_ptr:=$2
ARRAY LONGINT:C221($RankArray_ptr->; Size of array:C274($ValuesArray_ptr->))

If ((Type:C295($ValuesArray_ptr->)=Real array:K8:17) | (Type:C295($ValuesArray_ptr->)=Integer array:K8:18) | (Type:C295($ValuesArray_ptr->)=LongInt array:K8:19))
	Case of 
		: (Size of array:C274($ValuesArray_ptr->)=0)
			
		: (Size of array:C274($ValuesArray_ptr->)=1)
			$RankArray_ptr->{1}:=1
		Else 
			$RankArray_ptr->{1}:=1
			C_LONGINT:C283($loop_L)
			For ($loop_L; 2; Size of array:C274($ValuesArray_ptr->))
				
				If ($sortOrder_txt="<")
					If (Round:C94($ValuesArray_ptr->{$loop_L}; 5)<Round:C94($ValuesArray_ptr->{$loop_L-1}; 5))
						$RankArray_ptr->{$loop_L}:=$loop_L
					Else 
						$RankArray_ptr->{$loop_L}:=$RankArray_ptr->{$loop_L-1}
					End if 
					
				Else 
					If (Round:C94($ValuesArray_ptr->{$loop_L}; 5)>Round:C94($ValuesArray_ptr->{$loop_L-1}; 5))
						$RankArray_ptr->{$loop_L}:=$loop_L
					Else 
						$RankArray_ptr->{$loop_L}:=$RankArray_ptr->{$loop_L-1}
					End if 
					
				End if 
				
			End for 
			
	End case 
End if 
//End ut_Rank