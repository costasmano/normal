//%attributes = {"invisible":true}
//Method: ut_BlobToStructureLists
//Description
// read from a blob created by method ut_StructListsToBlob and save lists to current structure
// Parameters
// $1 : $StructListBlob_blb
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/06/17, 16:39:55
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_BLOB:C604(ut_BlobToStructureLists; $1)
End if 
//

C_BLOB:C604($StructListBlob_blb; $1)

$StructListBlob_blb:=$1

C_LONGINT:C283($offset_L; $ListID_L; $size_L; $count_L; $readcount_L; $LastOffset_L)
C_TEXT:C284($ListName_txt)
$count_L:=0
$readcount_L:=0
$offset_L:=0
C_BOOLEAN:C305($Error_b)
$Error_b:=False:C215
$size_L:=BLOB size:C605($StructListBlob_blb)
If ($size_L>0)
	Repeat 
		$LastOffset_L:=$offset_L
		BLOB TO VARIABLE:C533($StructListBlob_blb; $ListName_txt; $offset_L)
		If ($LastOffset_L=$offset_L)
			//did not read a text var - Error
			$Error_b:=True:C214
		Else 
			$LastOffset_L:=$offset_L
			
			$ListID_L:=BLOB to list:C557($StructListBlob_blb; $offset_L)
			If ($LastOffset_L=$offset_L)
				//did not read a List  - Error
				$Error_b:=True:C214
			Else 
				
				If ($ListID_L>0) & ($ListName_txt#"")
					$readcount_L:=$readcount_L+1
					ON ERR CALL:C155("ut_LoadListError")
					SAVE LIST:C384($ListID_L; $ListName_txt)
					ON ERR CALL:C155("")
					
					If (Error=9957)
						CONFIRM:C162("Could not update List "+$ListName_txt+" Continue Loading or abort?"; "Continue"; "Abort")
						If (OK=1)
						Else 
							$offset_L:=$size_L+1
						End if 
						Error:=0
					Else 
						$count_L:=$count_L+1
					End if 
					CLEAR LIST:C377($ListID_L; *)
				End if 
				
			End if 
			
		End if 
	Until ($offset_L>=$size_L) | ($Error_b)
	
	ALERT:C41("Finished : Read "+String:C10($readcount_L)+" Lists ; Updated/Saved "+String:C10($count_L)+" Lists")
Else 
	ALERT:C41("Blob is zero size!")
End if 

//End ut_BlobToStructureLists