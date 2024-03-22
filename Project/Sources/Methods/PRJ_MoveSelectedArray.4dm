//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_MoveSelectedArray
// User name (OS): cjmiller
// Date and time: 05/20/08, 15:03:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r008 `05/20/08, 15:03:10     
End if 
C_BOOLEAN:C305($New_b)
$New_b:=True:C214
Case of 
	: (Count parameters:C259=6)
		C_POINTER:C301($FromArray_ptr; $FromRecordNumberArray_ptr; $FromGroupArray_ptr; $ToArray_ptr; $ToRecordNumberArray_ptr; $ToGroupArray_ptr; $1; $2; $3; $4; $5; $6)
		$FromArray_ptr:=$1
		$FromRecordNumberArray_ptr:=$2
		$FromGroupArray_ptr:=$3
		$ToArray_ptr:=$4
		$ToRecordNumberArray_ptr:=$5
		$ToGroupArray_ptr:=$6
	: (Count parameters:C259=4)
		C_POINTER:C301($FromArray_ptr; $FromRecordNumberArray_ptr; $ToArray_ptr; $ToRecordNumberArray_ptr; $1; $2; $3; $4)
		$FromArray_ptr:=$1
		$FromRecordNumberArray_ptr:=$2
		$ToArray_ptr:=$3
		$ToRecordNumberArray_ptr:=$4
		$New_b:=False:C215
End case 
C_LONGINT:C283($Size_l)
$Size_l:=Size of array:C274($ToArray_ptr->)+1
INSERT IN ARRAY:C227($ToArray_ptr->; $Size_l; 1)
INSERT IN ARRAY:C227($ToRecordNumberArray_ptr->; $Size_l; 1)
If ($New_b)
	INSERT IN ARRAY:C227($ToGroupArray_ptr->; $Size_l; 1)
End if 
C_LONGINT:C283($Location_l)
$Location_l:=$FromArray_ptr->
$ToArray_ptr->{$Size_l}:=$FromArray_ptr->{$Location_l}
$ToRecordNumberArray_ptr->{$Size_l}:=$FromRecordNumberArray_ptr->{$Location_l}
If ($New_b)
	If (Size of array:C274(GroupDD_as)=0)
		$ToGroupArray_ptr->{$Size_l}:=1
	Else 
		//$Group_l:=Num(Replace string(GroupDD_as{GroupDD_as};"Replacement Group # ";""))
		$ToGroupArray_ptr->{$Size_l}:=GroupDD_as
	End if 
End if 
DELETE FROM ARRAY:C228($FromArray_ptr->; $Location_l; 1)
DELETE FROM ARRAY:C228($FromRecordNumberArray_ptr->; $Location_l; 1)
If ($New_b)
	DELETE FROM ARRAY:C228($FromGroupArray_ptr->; $Location_l; 1)
End if 
OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
Case of 
	: (Count parameters:C259=6)
		SORT ARRAY:C229($FromArray_ptr->; $FromRecordNumberArray_ptr->; $FromGroupArray_ptr->; >)
		SORT ARRAY:C229($ToArray_ptr->; $ToRecordNumberArray_ptr->; $ToGroupArray_ptr->; >)
		
	: (Count parameters:C259=4)
		SORT ARRAY:C229($FromArray_ptr->; $FromRecordNumberArray_ptr->; >)
		SORT ARRAY:C229($ToArray_ptr->; $ToRecordNumberArray_ptr->; >)
		
End case 
$FromArray_ptr->:=0
//End PRJ_MoveSelectedArray