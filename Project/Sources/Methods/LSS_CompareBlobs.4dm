//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/18/14, 13:56:16
//----------------------------------------------------
//Method: LSS_CompareBlobs
//Description: This method will compare the content of two blobs
//Parameter:
// $1 = Blob; $2 = Blob 
//Return Value:
// $0: True if different, otherwise false

// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/18/14 13:56:22)
End if 
// $0: True if different, otherwise false

C_BLOB:C604($1; $2)
C_BOOLEAN:C305($0; $Equality_B)
$0:=False:C215
C_LONGINT:C283($vByte)
If (BLOB size:C605($1)=BLOB size:C605($2))
	For ($vByte; 0; BLOB size:C605($1)-1)
		If ($1{$vByte}#$2{$vByte})
			$0:=True:C214
			$vByte:=BLOB size:C605($1)
		End if 
	End for 
Else 
	$0:=True:C214
End if 
//End LSS_CompareBlobs