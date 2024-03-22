//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/06, 14:29:06
	// ----------------------------------------------------
	// Method: ut_GetGroupMembers
	// Description
	// Get the List of Members of a Group from the Password System.
	// 
	// Parameters
	// $1 : String : name of group
	// $2 : pointer : pointer to string/text array that will hold the user names.
	// $3 : pointer : pointer to longint/int array that will hold the user IDs.
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_TEXT:C284($1; $grpname; $grName)
$grpname:=$1
C_POINTER:C301($2; $ArrayUserNames_ptr)
$ArrayUserNames_ptr:=$2
C_BOOLEAN:C305($ReturnIDs_b)
$ReturnIDs_b:=False:C215
If (Count parameters:C259=3)
	C_POINTER:C301($3; $ArrayUserIDs_ptr)
	$ArrayUserIDs_ptr:=$3
	$ReturnIDs_b:=True:C214
End if 

ARRAY TEXT:C222($GrpList_arr_txt; 0)
ARRAY LONGINT:C221($GrpList_ID_L; 0)
ARRAY TEXT:C222($USRList_arr_txt; 0)
ARRAY LONGINT:C221($USRList_ID_L; 0)
GET GROUP LIST:C610($GrpList_arr_txt; $GrpList_ID_L)
C_LONGINT:C283($grpIndex_L; $grOwner; $i; $j)
$grpIndex_L:=Find in array:C230($GrpList_arr_txt; $grpname)
If ($grpIndex_L>0)
	GET USER LIST:C609($USRList_arr_txt; $USRList_ID_L)
	GET GROUP PROPERTIES:C613($GrpList_ID_L{$grpIndex_L}; $grName; $grOwner; $GrMembers)
	If (Size of array:C274($GrMembers)>0)
		For ($i; 1; Size of array:C274($GrMembers))
			$j:=Find in array:C230($USRList_ID_L; $GrMembers{$i})
			If ($j>0)
				INSERT IN ARRAY:C227($ArrayUserNames_ptr->; 1; 1)
				$ArrayUserNames_ptr->{1}:=$USRList_arr_txt{$j}
				If ($ReturnIDs_b)
					INSERT IN ARRAY:C227($ArrayUserIDs_ptr->; 1; 1)
					$ArrayUserIDs_ptr->{1}:=$GrMembers{$i}
				End if 
				
			End if 
		End for 
	End if 
	
End if 
ARRAY TEXT:C222($GrpList_arr_txt; 0)
ARRAY LONGINT:C221($GrpList_ID_L; 0)
ARRAY TEXT:C222($USRList_arr_txt; 0)
ARRAY LONGINT:C221($USRList_ID_L; 0)