//Method: SelectResources.Button4
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 11:56:38
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//



C_TEXT:C284($Document_txt; $FileName_txt; $PathToResource_txt)
C_BLOB:C604($Blob_blb)
C_LONGINT:C283($Size_L; $Loop_L; $Pos_L)
ARRAY TEXT:C222($Files_atxt; 0)

$Document_txt:=Select document:C905(""; ""; "Select file to move to Resources on Server"; Multiple files:K24:7; $Files_atxt)
If (OK=1)
	$Document_txt:=$Files_atxt{1}
	
	DOCUMENT TO BLOB:C525($Document_txt; $Blob_blb)
	ARRAY TEXT:C222($Parts_txt; 0)
	ut_NewTextToArray($Document_txt; ->$Parts_txt; Folder separator:K24:12)
	$Size_L:=Size of array:C274($Parts_txt)
	C_TEXT:C284($ResourcePath_txt)
	$ResourcePath_txt:=Replace string:C233(v_1_150_txt; $Parts_txt{$Size_L}; $Parts_txt{$Size_L})
	CONFIRM:C162("Are you sure you want to place file named "+$Parts_txt{$Size_L}+" into reosurce folder "+v_1_150_txt+" on the server?"; "Yes"; "No")
	//If ($ResourcePath_txt="")
	//$ResourcePath_txt:=Get 4D folder(Current resources folder)
	//End if 
	If (OK=1)
		If (Server_SaveDocToResourceFolder($ResourcePath_txt; $Parts_txt{$Size_L}; $Blob_blb))
			$Pos_L:=Find in array:C230(LBGeneric_atxt; $ResourcePath_txt+$Parts_txt{$Size_L})
			If ($Pos_L<1)
				$Pos_L:=Position:C15("."; $Document_txt)
				
				APPEND TO ARRAY:C911(v_1_150_atxt; Substring:C12(Uppercase:C13($Document_txt); $Pos_L+1))
				If (v_1_150_txt="")
					APPEND TO ARRAY:C911(LBGeneric_atxt; $Parts_txt{$Size_L})
				Else 
					APPEND TO ARRAY:C911(LBGeneric_atxt; Folder separator:K24:12+v_1_150_txt+$Parts_txt{$Size_L})
				End if 
				APPEND TO ARRAY:C911(v_1_004_ab; True:C214)
				$FileName_txt:=$Parts_txt{$Size_L}
				SORT ARRAY:C229(v_1_150_atxt; LBGeneric_atxt; v_1_004_ab; >)
				ARRAY TEXT:C222($Parts_txt; 0)
				ut_NewTextToArray(v_1_150_txt; ->$Parts_txt; Folder separator:K24:12)
				
				$PathToResource_txt:=Get 4D folder:C485(Current resources folder:K5:16)
				For ($Loop_L; 1; Size of array:C274($Parts_txt))
					$PathToResource_txt:=$PathToResource_txt+$Parts_txt{$Loop_L}
					If (Test path name:C476($PathToResource_txt)=Is a folder:K24:2)
					Else 
						CREATE FOLDER:C475($PathToResource_txt)
					End if 
					$PathToResource_txt:=$PathToResource_txt+Folder separator:K24:12
				End for 
			End if 
			C_BOOLEAN:C305($Copy_B)
			$Copy_B:=True:C214
			If (Test path name:C476($PathToResource_txt+$FileName_txt)=Is a document:K24:1)
				CONFIRM:C162("Do you wish to overwrite local document "+$PathToResource_txt+$FileName_txt)
				$Copy_B:=(OK=1)
			End if 
			If ($Copy_B)
				COPY DOCUMENT:C541($Document_txt; $PathToResource_txt+$FileName_txt; *)
			End if 
		Else 
			ALERT:C41("Could not save document on server")
			
		End if 
	End if 
	
	
	
End if 
//End SelectResources.Button3