//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/18/2006 16:20:01)
	Mods_2006_CM04
End if 

//MULTILEVEL
C_POINTER:C301($1; $2)
C_BOOLEAN:C305($3)
C_LONGINT:C283($LevelNb; $i; $k)
SortBdept:=0
SorttmLdr:=0

If (Not:C34($3))  //Simple sort (one-level)
	If (Type:C295(aPtrSortOrder)=Pointer array:K8:23)
		//check previous sort order pointers
		$LevelNb:=Size of array:C274(aPtrSortOrder)
		If ($LevelNb>0)
			$k:=Find in array:C230(aPtrSortOrder; $2)
			For ($i; 1; $LevelNb)
				If ($i#$k)  //to avoid changing the current value
					aPtrSortOrder{$i}->:=0
				End if 
			End for 
		End if 
	End if 
	ARRAY POINTER:C280(aPtrSortField; 1)
	ARRAY POINTER:C280(aPtrSortOrder; 1)
	aPtrSortField{1}:=$1
	aPtrSortOrder{1}:=$2
Else 
	$LevelNb:=Find in array:C230(aPtrSortField; $1)  //Is this field already sorted?
	If ($LevelNb<0)  //If not
		INSERT IN ARRAY:C227(aPtrSortField; Size of array:C274(aPtrSortField)+1; 1)
		aPtrSortField{Size of array:C274(aPtrSortField)}:=$1
		INSERT IN ARRAY:C227(aPtrSortOrder; Size of array:C274(aPtrSortOrder)+1; 1)
		aPtrSortOrder{Size of array:C274(aPtrSortOrder)}:=$2
	End if 
End if 
$LevelNb:=Size of array:C274(aPtrSortField)

If ($LevelNb>0)  //There is at least one order level
	If (Records in selection:C76(MultiLevelTBL->)>500)
		SHORT_MESSAGE("Sorting, Please wait..")
	End if 
	
	For ($i; 1; $LevelNb)
		If ((aPtrSortOrder{$i})->=1)
			ORDER BY:C49(MultiLevelTBL->; (aPtrSortField{$i})->; >; *)  //Building sort definition
		Else 
			ORDER BY:C49(MultiLevelTBL->; (aPtrSortField{$i})->; <; *)  //Building sort definition
		End if 
		
	End for 
	ORDER BY:C49(MultiLevelTBL->)  //No * ends the sort definition and starts the actual sort operation
	If (Records in selection:C76(MultiLevelTBL->)>500)
		CLOSE WINDOW:C154
	End if 
End if 