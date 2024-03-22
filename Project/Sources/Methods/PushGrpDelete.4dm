//%attributes = {"invisible":true}
If (False:C215)
	//PushGrpDelete
	//Push a Deletion in a stack to be grouped together with
	//other deletions of records from same table with
	//same parent.  
	//Parameters
	//$1 : pointer to local ID field of record being deleted
	
	Mods_2005_CM04
	
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:51:07)
	Mods_2017_06_bug
	//  `arr_DeletedIDs can be text array
End if 

C_LONGINT:C283($vType; $vLength; $n)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($1; $localid)
C_TEXT:C284($vtRecID)  // Command Replaced was o_C_STRING length was 80

$localid:=$1
If ((Type:C295(arr_DeletedIDs)=String array:K8:15) | (Type:C295(arr_DeletedIDs)=Text array:K8:16))
	GET FIELD PROPERTIES:C258($localid; $vType; $vLength; $vIndex)
	If ($vType=0)
		$vtRecID:=$localid->
	Else 
		$vtRecID:=String:C10($localid->)
	End if 
	$n:=Size of array:C274(arr_DeletedIDs)+1
	If (Find in array:C230(arr_DeletedIDs; $vtRecID)<0)
		INSERT IN ARRAY:C227(arr_DeletedIDs; $n; 1)
		arr_DeletedIDs{$n}:=$vtRecID
	End if 
	
End if 