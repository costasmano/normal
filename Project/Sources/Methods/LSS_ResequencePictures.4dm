//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 08/18/15, 13:02:58
//----------------------------------------------------
//Method: LSS_ResequencePictures
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	Mods_2016_02_bug  // Add code to make sure sequence numbers update when user enters a number > all others found
	//Modified by: administrator (2/9/16 17:35:15)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
C_TEXT:C284($1; $Part_txt)
$Part_txt:=$1
C_LONGINT:C283($Loc_L)

If (Count parameters:C259=4)
	C_TEXT:C284($2; $3; $CurrentID_txt; $Type_txt)
	$CurrentID_txt:=$2
	$Type_txt:=$3
	C_LONGINT:C283($4; $NewSequence_L)
	$NewSequence_L:=$4
End if 
Case of 
	: ($Part_txt="Load")
		C_LONGINT:C283($Size_L)
		$Size_L:=Records in selection:C76([LSS_Photos:166])
		
		COPY NAMED SELECTION:C331([LSS_Photos:166]; "NamedPhoto")
		
		SELECTION RANGE TO ARRAY:C368(1; $Size_L; [LSS_Photos:166]LSS_PhotoId_s:1; v_166_001_atxt; [LSS_Photos:166]LSS_PhotoType_s:3; v_166_003_atxt; [LSS_Photos:166]LSS_PhotoSequence_L:6; v_166_006_aL)
		USE NAMED SELECTION:C332("NamedPhoto")
		CLEAR NAMED SELECTION:C333("NamedPhoto")
		ARRAY LONGINT:C221(LSS_NewPhotoSequence_aL; 0)
		COPY ARRAY:C226(v_166_006_aL; LSS_NewPhotoSequence_aL)
		
		
	: ($Part_txt="Update")
		$Loc_L:=Find in array:C230(v_166_001_atxt; $CurrentID_txt)
		If ($Loc_L<0)
			APPEND TO ARRAY:C911(v_166_001_atxt; $CurrentID_txt)
			APPEND TO ARRAY:C911(v_166_003_atxt; $Type_txt)
			APPEND TO ARRAY:C911(v_166_006_aL; 0)
			APPEND TO ARRAY:C911(LSS_NewPhotoSequence_aL; $NewSequence_L)
		End if 
		C_BOOLEAN:C305($Complete_B)
		$Complete_B:=False:C215
		C_LONGINT:C283($Start_L)
		$Start_L:=0
		ARRAY LONGINT:C221($PosToUpdate_aL; 0)
		C_LONGINT:C283($CurrentHighestNumber_L)
		$CurrentHighestNumber_L:=0
		For ($Loop_L; 1; Size of array:C274(v_166_003_atxt))
			If (v_166_003_atxt{$Loop_L}=$Type_txt)
				If (v_166_006_aL{$Loop_L}>$CurrentHighestNumber_L)
					$CurrentHighestNumber_L:=v_166_006_aL{$Loop_L}
				End if 
			End if 
		End for 
		
		
		Repeat 
			$Loc_L:=Find in array:C230(v_166_003_atxt; $Type_txt; $Start_L)
			If ($Loc_L>0)
				$Start_L:=$Loc_L+1
				If (v_166_001_atxt{$Loc_L}#$CurrentID_txt)
					APPEND TO ARRAY:C911($PosToUpdate_aL; $Loc_L)
				Else 
					LSS_NewPhotoSequence_aL{$Loc_L}:=$NewSequence_L
				End if 
			Else 
				$Complete_B:=True:C214
			End if 
			
		Until ($Complete_B)
		
		If ($CurrentHighestNumber_L<$NewSequence_L)
			For ($Loop_L; 1; Size of array:C274($PosToUpdate_aL))
				If (v_166_006_aL{$PosToUpdate_aL{$Loop_L}}<=$NewSequence_L)
					LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}:=LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}
					LSS_PhotoUpdateSeq_b:=True:C214
				End if 
			End for 
		Else 
			For ($Loop_L; Size of array:C274($PosToUpdate_aL); 1; -1)
				If (v_166_006_aL{$PosToUpdate_aL{$Loop_L}}>=$NewSequence_L)
					LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}:=LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}+1
					LSS_PhotoUpdateSeq_b:=True:C214
				End if 
			End for 
		End if 
	: ($Part_txt="Delete")
		C_LONGINT:C283($Loc_L)
		$Type_txt:=[LSS_Photos:166]LSS_PhotoType_s:3
		$Loc_L:=Find in array:C230(v_166_001_atxt; [LSS_Photos:166]LSS_PhotoId_s:1)
		C_LONGINT:C283($DeletedSequenceNumber_L)
		If ($Loc_L>0)
			DELETE FROM ARRAY:C228(v_166_001_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(v_166_003_atxt; $Loc_L; 1)
			$DeletedSequenceNumber_L:=v_166_006_aL{$Loc_L}
			DELETE FROM ARRAY:C228(v_166_006_aL; $Loc_L; 1)
			
			DELETE FROM ARRAY:C228(LSS_NewPhotoSequence_aL; $Loc_L; 1)
		End if 
		
		C_BOOLEAN:C305($Complete_B)
		$Complete_B:=False:C215
		C_LONGINT:C283($Start_L)
		$Start_L:=0
		ARRAY LONGINT:C221($PosToUpdate_aL; 0)
		
		Repeat 
			$Loc_L:=Find in array:C230(v_166_003_atxt; $Type_txt; $Start_L)
			If ($Loc_L>0)
				$Start_L:=$Loc_L+1
				APPEND TO ARRAY:C911($PosToUpdate_aL; $Loc_L)
			Else 
				$Complete_B:=True:C214
			End if 
			
		Until ($Complete_B)
		For ($Loop_L; Size of array:C274($PosToUpdate_aL); 1; -1)
			If (v_166_006_aL{$PosToUpdate_aL{$Loop_L}}>=$DeletedSequenceNumber_L)
				LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}:=LSS_NewPhotoSequence_aL{$PosToUpdate_aL{$Loop_L}}-1
				LSS_PhotoUpdateSeq_b:=True:C214
			End if 
		End for 
	: ($Part_txt="Save")
		C_LONGINT:C283($Loop_L; $PhotoSequence_L; $SketchSequence_L; $ChartSequence_L)
		
		$PhotoSequence_L:=1
		$SketchSequence_L:=1
		$ChartSequence_L:=1
		//
		
		MULTI SORT ARRAY:C718(v_166_003_atxt; >; LSS_NewPhotoSequence_aL; >; v_166_001_atxt; v_166_006_aL)
		
		For ($Loop_L; 1; Size of array:C274(LSS_NewPhotoSequence_aL))
			
			Case of 
				: (v_166_003_atxt{$Loop_L}="Photo")
					LSS_NewPhotoSequence_aL{$Loop_L}:=$PhotoSequence_L
					$PhotoSequence_L:=$PhotoSequence_L+1
				: (v_166_003_atxt{$Loop_L}="Sketch")
					LSS_NewPhotoSequence_aL{$Loop_L}:=$SketchSequence_L
					$SketchSequence_L:=$SketchSequence_L+1
				: (v_166_003_atxt{$Loop_L}="Chart")
					LSS_NewPhotoSequence_aL{$Loop_L}:=$ChartSequence_L
					$ChartSequence_L:=$ChartSequence_L+1
			End case 
		End for 
		C_TEXT:C284($ErrorMethodCalled_txt)
		$ErrorMethodCalled_txt:=Method called on error:C704
		ON ERR CALL:C155("LSS_ErrorMethod")
		For ($Loop_L; 1; Size of array:C274(LSS_NewPhotoSequence_aL))
			QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoId_s:1=v_166_001_atxt{$Loop_L})
			If ([LSS_Photos:166]LSS_PhotoSequence_L:6#LSS_NewPhotoSequence_aL{$Loop_L})
				If (ut_LoadRecord(->[LSS_Photos:166]))
					[LSS_Photos:166]LSS_PhotoSequence_L:6:=LSS_NewPhotoSequence_aL{$Loop_L}
					LogChanges(->[LSS_Photos:166]LSS_PhotoSequence_L:6; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
					SAVE RECORD:C53([LSS_Photos:166])
				End if 
			End if 
			UNLOAD RECORD:C212([LSS_Photos:166])
		End for 
		ON ERR CALL:C155($ErrorMethodCalled_txt)
		LSS_GetImages
		LSS_ResequencePictures("Load")
		
End case 



//End LSS_ResequencePictures

