// ----------------------------------------------------
// Object Method: bOK
// User name (OS): charlesmiller
// Date and time: 05/23/11, 15:01:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 15:01:17      `Fix bugs found during testing of initial release of v11
	// Modified by: Costas Manousakis-(Designer)-(10/10/17 10:47:10)
	Mods_2017_10
	//  `clear list after using it when saving to file
	//  // clear all lists loaded when reading from file
End if 
C_LONGINT:C283($Loop_l; $ListID_l)
C_TEXT:C284($ListName_txt)
If (Check Box1=0)  //we are saving lists to a document
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	
	
	For ($Loop_l; 1; Size of array:C274(ProcessLists_atxt))
		$ListID_l:=Load list:C383(ProcessLists_atxt{$Loop_l})
		$ListName_txt:=ProcessLists_atxt{$Loop_l}
		VARIABLE TO BLOB:C532($ListName_txt; $Blob_blb; *)
		LIST TO BLOB:C556($ListID_l; $Blob_blb; *)
		CLEAR LIST:C377($ListID_l; *)
	End for 
	C_TIME:C306($Doc)
	$Doc:=Create document:C266("")
	CLOSE DOCUMENT:C267($doc)
	BLOB TO DOCUMENT:C526(Document; $Blob_blb)
	
Else 
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	//we are reloading list data
	ON ERR CALL:C155("ut_LoadListError")
	Repeat 
		For ($Loop_l; Size of array:C274(ProcessLists_atxt); 1; -1)
			SAVE LIST:C384(ProcessListIDS_al{$Loop_l}; ProcessLists_atxt{$Loop_l})
			If (Error=9957)
				ALERT:C41("Could not update List named "+ProcessLists_atxt{$Loop_l})
				Error:=0
			Else 
				DELETE FROM ARRAY:C228(ProcessListIDS_al; $Loop_l; 1)
				DELETE FROM ARRAY:C228(ProcessLists_atxt; $Loop_l; 1)
			End if 
			
		End for 
		If (Size of array:C274(ProcessListIDS_al)=0)
			$Complete_b:=True:C214
		Else 
			CONFIRM:C162("Do you wish to try and update list again"; "Yes"; "No")
			If (OK=0)
				$Complete_b:=True:C214
			End if 
		End if 
	Until ($Complete_b)
	
	ON ERR CALL:C155("")
End if 
//End Object Method: bOK