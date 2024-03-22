//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/26/09, 19:37:26
	// ----------------------------------------------------
	// Method: SCPOA_PhotoListBox_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $formEvent
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(4/24/10 09:50:44)
	Mods_2010_04
	//  `added needed code in the on load event
	//  `on the double cilcked event, call the SCPOA_Variables ("PHOTOS") method to re   `load listbox arrays, 
	//  `also sort by sequence number after exiting the input form
	//  `on the row moved, renumber the sequence numbers
	//  `Make sure the sequence array is kept in sync with the listbox order after any   `editing
	//  `Also after deleting, and clearing the listbox arrays recreate the selection.
	// Modified by: costasmanousakis-(Designer)-(4/6/11 16:28:32)
	Mods_2011_04
	//  `Added initializing of Listbox array SCPOAImagesListBox
	// Modified by: Costas Manousakis-(Designer)-(2/27/12 22:18:09)
	Mods_2012_02
	//  `increased the number of pictures to 5 for the new FVC
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 21:55:30)
	Mods_2012_03
	//  `FV Photo changes : can add more than 4 photos
	// Modified by: Costas Manousakis-(Designer)-(10/27/12 14:04:04)
	Mods_2012_11
	//  `Added updating of variable SCPOA_PhotoAttach_L after double-click
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
Case of 
	: ($FormEvent=On Load:K2:1)
		InDoubleClick_B:=False:C215
		
		SCPOA_Variables("INITPHOTOS")
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(SCPOAImagesListBox))
			SCPOAImagesListBox{$loop_L}:=False:C215
		End for 
		
	: ($FormEvent=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($currItem_L; $FirstId; $LastID; $newRow_L; $NumCurrPhotos)
			$currItem_L:=SCPOAImagesListBox
			C_POINTER:C301($myListBox_ptr)
			$myListBox_ptr:=->SCPOAImagesListBox
			$NumCurrPhotos:=Size of array:C274(SCPOAImagesListBox)
			If ($currItem_L>0)
				GOTO SELECTED RECORD:C245([ScourPOA_Images:134]; $currItem_L)
				If (ut_LoadRecordInteractive(->[ScourPOA_Images:134]))
					FORM SET INPUT:C55([ScourPOA_Images:134]; "Input")
					$FirstId:=[ScourPOA_Images:134]ScourPOAImgID:1
					MODIFY RECORD:C57([ScourPOA_Images:134])
					$LastID:=[ScourPOA_Images:134]ScourPOAImgID:1
					CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
					
					SCPOA_Variables("PHOTOS")
					C_LONGINT:C283($loop_L)
					
					For ($loop_L; Size of array:C274(SCPOA_PhotoRecs_aL); 1; -1)
						If (SCPOA_PhotoIDs_aL{$loop_L}=0)
							//DELETE FROM ARRAY(SCPOA_PhotoDesc_atxt;$loop_L)
							//DELETE FROM ARRAY(SCPOA_PhotoIDsArr_ptr->;$loop_L)
							//DELETE FROM ARRAY(SCPOA_PhotosSeqArr_ptr->;$loop_L)
							//DELETE FROM ARRAY(SCPOA_PhotoRecArr_ptr->;$loop_L)
							LISTBOX DELETE ROWS:C914(SCPOAImagesListBox; $loop_L)
						End if 
						
					End for 
					
					CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
					
					If ($LastID>0)
						$newRow_L:=Find in array:C230(SCPOA_PhotoIDs_aL; $LastID)
						If ($newRow_L<=0)
							$newRow_L:=1
						End if 
						LISTBOX SELECT ROW:C912($myListBox_ptr->; $newRow_L)
						OBJECT SET SCROLL POSITION:C906($myListBox_ptr->)
						
					End if 
					
				End if 
				
			Else 
				If (SCPOA_EditRecord_b)
					If (True:C214)
						//If ($NumCurrPhotos<5)
						//Add if editable
						FORM SET INPUT:C55([ScourPOA_Images:134]; "Input")
						ADD RECORD:C56([ScourPOA_Images:134])
						$LastID:=Record number:C243([ScourPOA_Images:134])
						QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
						QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="Photo")
						ORDER BY:C49([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageSeq:6)
						C_LONGINT:C283($NewNumPhotos_L)
						$NewNumPhotos_L:=Records in selection:C76([ScourPOA_Images:134])
						If ($NewNumPhotos_L=$NumCurrPhotos)
							//to reset the order - there was no addition
							CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
						Else 
							APPEND TO ARRAY:C911(SCPOA_PhotoRecs_aL; $LastID)
							CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
							SCPOA_Variables("PHOTOS")
							//To keep the current order
							[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //make validate event go
							$NumCurrPhotos:=$NewNumPhotos_L
							LISTBOX SELECT ROW:C912($myListBox_ptr->; $NumCurrPhotos)
							OBJECT SET SCROLL POSITION:C906($myListBox_ptr->)
							
						End if 
					Else 
						ALERT:C41("Already have 5 Photos! Cannot add any more. Either delete existing ones, or edit "+"them!")
					End if 
				Else 
					//Do notunig
				End if 
				
			End if 
			
			C_LONGINT:C283($numpics_L)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $numpics_L)
			QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)  //Update Attachm G photos checkbox
			QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="Photo")
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($numpics_L>0)
				SCPOA_PhotoAttach_L:=1
			Else 
				SCPOA_PhotoAttach_L:=0
			End if 
			
			C_LONGINT:C283($loop_L)
			
			If (SCPOA_IMAGETYPELIST_L=1)
				For ($loop_L; 1; Size of array:C274(SCPOA_PhotoSeq_aL))
					SCPOA_PhotoSeq_aL{$loop_L}:=$loop_L
				End for 
			Else 
				For ($loop_L; 1; Size of array:C274(SCPOA_FVPhotoSeq_aL))
					SCPOA_FVPhotoSeq_aL{$loop_L}:=$loop_L
				End for 
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
		
	: ($FormEvent=On Row Moved:K2:32)
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
		C_LONGINT:C283($loop_L)
		If (SCPOA_IMAGETYPELIST_L=1)
			For ($loop_L; 1; Size of array:C274(SCPOA_PhotoSeq_aL))
				SCPOA_PhotoSeq_aL{$loop_L}:=$loop_L
			End for 
		Else 
			For ($loop_L; 1; Size of array:C274(SCPOA_FVPhotoSeq_aL))
				SCPOA_FVPhotoSeq_aL{$loop_L}:=$loop_L
			End for 
		End if 
		
		[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //make validate event go
		
End case 