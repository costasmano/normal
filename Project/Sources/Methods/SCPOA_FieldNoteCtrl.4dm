//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/05/09, 09:38:07
	// ----------------------------------------------------
	// Method: SCPOA_FieldNoteCtrl
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("READFROMDISK" | "SAVETODB" | "INIT" |"LOADFROMDB"  |"GETNAMES" |"VIEW" |"PRINT" |"SAVETODISK" | "CLEAR"|"DELFROMDB")
	// ----------------------------------------------------
	
	Mods_2009_12  //Copied to Server on : 12/09/09, 16:54:50
	// Modified by: costasmanousakis-(Designer)-(2/16/10 08:36:47)
	Mods_2010_02
	//  `FIX return variable declaration ; 
	//  `added new tasks "ADDFIELDNOTE" |"VIEWFIELDNOTE" |"DELFIELDNOTE"
	// Modified by: costasmanousakis-(Designer)-(5/12/10 08:14:35)
	Mods_2010_05
	//  `Added option SAVEDISKFIELDNOTE and SAVEALLTODISK;
	//  `Changed method of finding selected field note - search in array for true
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	// Modified by: costasmanousakis-(Designer)-(4/6/11 16:26:28)
	Mods_2011_04
	//  `Added initializing of Listbox array SCPOAFieldNotesListBox
End if 
C_BOOLEAN:C305($0; $Result_b)
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_BLOB:C604($Part1_x)
C_TEXT:C284($Filename_txt; $tempFileName_txt; $originalPath_txt)
C_LONGINT:C283($origSize_L; $copypart_L; $CopyDest_L; $startPos_L; $NumPieces_L; $Piece_L; $fldNoteCount_L; $CurrSCPOAID; $imageSeq_L)
$Result_b:=True:C214
$CurrSCPOAID:=[ScourPOA:132]ScourPOAID:1
Case of 
	: ($Task_txt="INIT")
		C_BLOB:C604(SCPOA_FLDNOTE_X)
		C_TEXT:C284(SCPOA_FLDNOTEDESC_TXT)
		C_LONGINT:C283(SCPOA_MAXBLOBPIECE_L)
		SCPOA_MAXBLOBPIECE_L:=500000
		ARRAY TEXT:C222(SCPOA_FLDNOTENAMES_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_FLDNOTESeq_aL; 0)
		ARRAY TEXT:C222(SCPOA_TEMPFILES_atxt; 0)
		ARRAY BOOLEAN:C223(SCPOAFieldNotesListBox; 0)
		
	: ($Task_txt="ADDFIELDNOTE")
		If (SCPOA_FieldNoteCtrl("READFROMDISK"))
			SCPOA_FieldNoteCtrl("SAVETODB")
			SET BLOB SIZE:C606(SCPOA_FLDNOTE_X; 0)
		End if 
		
	: ($Task_txt="VIEWFIELDNOTE")
		C_LONGINT:C283($currentFldNote_L)
		$currentFldNote_L:=Find in array:C230(SCPOAFieldNotesListBox; True:C214)
		If ($currentFldNote_L>0)
			SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$currentFldNote_L}
			SCPOA_FieldNoteCtrl("LOADFROMDB")
			SCPOA_FieldNoteCtrl("VIEW")
		End if 
		
	: ($Task_txt="SAVEDISKFIELDNOTE")
		C_LONGINT:C283($currentFldNote_L)
		$currentFldNote_L:=Find in array:C230(SCPOAFieldNotesListBox; True:C214)
		If ($currentFldNote_L>0)
			SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$currentFldNote_L}
			SCPOA_FieldNoteCtrl("LOADFROMDB")
			SCPOA_FieldNoteCtrl("SAVETODISK")
		End if 
		
	: ($Task_txt="DELFIELDNOTE")
		C_LONGINT:C283($currentFldNote_L)
		$currentFldNote_L:=Find in array:C230(SCPOAFieldNotesListBox; True:C214)
		If ($currentFldNote_L>0)
			SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$currentFldNote_L}
			CONFIRM:C162("Do you want to Remove Field Note "+SCPOA_FLDNOTEDESC_TXT+" from the Database?"; "Remove"; "Cancel")
			If (OK=1)
				SCPOA_FieldNoteCtrl("DELFROMDB")
			End if 
		End if 
		
	: ($Task_txt="READFROMDISK")
		C_TIME:C306($pickafile_doc)
		$pickafile_doc:=Open document:C264(""; ""; Get pathname:K24:6)
		$Result_b:=False:C215
		
		If (OK=1)
			SCPOA_FLDNOTEDESC_TXT:=Document
			$originalPath_txt:=GetPath(SCPOA_FLDNOTEDESC_TXT)
			SCPOA_FLDNOTEDESC_TXT:=Replace string:C233(Document; $originalPath_txt; "")
			$tempFileName_txt:=Temporary folder:C486+SCPOA_FLDNOTEDESC_TXT
			COPY DOCUMENT:C541(Document; $tempFileName_txt)
			C_BLOB:C604(SCPOA_FLDNOTE_X; $Part1_x; $resBlb_x)
			DOCUMENT TO BLOB:C525($tempFileName_txt; SCPOA_FLDNOTE_X)
			DELETE DOCUMENT:C159($tempFileName_txt)
			$Result_b:=True:C214
		End if 
		
	: ($Task_txt="SAVETODB")
		$origSize_L:=BLOB size:C605(SCPOA_FLDNOTE_X)
		$NumPieces_L:=$origSize_L/SCPOA_MAXBLOBPIECE_L+1
		C_BOOLEAN:C305($SavetoDB_b; $Done_b)
		$SavetoDB_b:=False:C215
		$Result_b:=False:C215
		
		If (Find in array:C230(SCPOA_FLDNOTENAMES_atxt; SCPOA_FLDNOTEDESC_TXT)>0)
			C_LONGINT:C283($Choise_L)
			$Done_b:=False:C215
			Repeat 
				$Choise_L:=ut_3Option_Confirm("There is already a field note entry <"+SCPOA_FLDNOTEDESC_TXT+">!"; "Cancel"; "Replace"; "New")
				Case of 
					: ($Choise_L=1)
						$Done_b:=True:C214
					: ($Choise_L=2)
						SCPOA_FieldNoteCtrl("DELFROMDB")
						$imageSeq_L:=SCPOA_FLDNOTESeq_aL{Find in array:C230(SCPOA_FLDNOTENAMES_atxt; SCPOA_FLDNOTEDESC_TXT)}
						$Done_b:=True:C214
						SavetoDB_b:=True:C214
					: ($Choise_L=3)
						SCPOA_FLDNOTEDESC_TXT:=Request:C163("Enter new Field note entry name:"; SCPOA_FLDNOTEDESC_TXT)
						If (Find in array:C230(SCPOA_FLDNOTENAMES_atxt; SCPOA_FLDNOTEDESC_TXT)>0)
						Else 
							$Done_b:=True:C214
							$imageSeq_L:=0
							For ($Loop_L; 1; Size of array:C274(SCPOA_FLDNOTESeq_aL))
								If (SCPOA_FLDNOTESeq_aL{$Loop_L}>$imageSeq_L)
									$imageSeq_L:=SCPOA_FLDNOTESeq_aL{$Loop_L}
								End if 
							End for 
							$imageSeq_L:=1+$imageSeq_L
							$SavetoDB_b:=True:C214
						End if 
						
				End case 
				
			Until ($Done_b)
			
		Else 
			$imageSeq_L:=0
			For ($Loop_L; 1; Size of array:C274(SCPOA_FLDNOTESeq_aL))
				If (SCPOA_FLDNOTESeq_aL{$Loop_L}>$imageSeq_L)
					$imageSeq_L:=SCPOA_FLDNOTESeq_aL{$Loop_L}
				End if 
			End for 
			$imageSeq_L:=1+$imageSeq_L
			$SavetoDB_b:=True:C214
		End if 
		
		If ($SavetoDB_b)
			
			COPY NAMED SELECTION:C331([ScourPOA_Images:134]; "SCPOAFLDNOTEPRESET")
			SHORT_MESSAGE("Saving File "+SCPOA_FLDNOTEDESC_TXT+" to DB")
			For ($Piece_L; 1; $NumPieces_L)
				$startPos_L:=($Piece_L-1)*SCPOA_MAXBLOBPIECE_L
				$copypart_L:=MinNum(($origSize_L-$startPos_L); SCPOA_MAXBLOBPIECE_L)
				If ($copypart_L>0)
					COPY BLOB:C558(SCPOA_FLDNOTE_X; $Part1_x; $startPos_L; 0; $copypart_L)
					SET BLOB SIZE:C606($Part1_x; $copypart_L)
					CREATE RECORD:C68([ScourPOA_Images:134])
					Inc_Sequence("ScourPOA_Images"; ->[ScourPOA_Images:134]ScourPOAImgID:1)
					[ScourPOA_Images:134]ScourPOAID:2:=$CurrSCPOAID
					[ScourPOA_Images:134]ImageType:5:="FIELDNOTE"
					[ScourPOA_Images:134]ImageSeq:6:=$imageSeq_L
					[ScourPOA_Images:134]ImagePart:8:=$Piece_L
					[ScourPOA_Images:134]Image_x:3:=$Part1_x
					[ScourPOA_Images:134]ImgDescr_txt:4:=SCPOA_FLDNOTEDESC_TXT
					ARRAY POINTER:C280(ptr_Changes; 0; 0)
					InitChangeStack(1)  //or 2 if necessary........
					PushChange(1; ->[ScourPOA_Images:134]ImageType:5)
					PushChange(1; ->[ScourPOA_Images:134]ImageSeq:6)
					PushChange(1; ->[ScourPOA_Images:134]ImagePart:8)
					PushChange(1; ->[ScourPOA_Images:134]Image_x:3)
					PushChange(1; ->[ScourPOA_Images:134]ImgDescr_txt:4)
					LogNewRecord(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 1; "ScourPOA_Images")
					FlushGrpChgs(1; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 1)
					SAVE RECORD:C53([ScourPOA_Images:134])
					
				End if 
				
			End for 
			SET BLOB SIZE:C606($Part1_x; 0)
			USE NAMED SELECTION:C332("SCPOAFLDNOTEPRESET")
			CLEAR NAMED SELECTION:C333("SCPOAFLDNOTEPRESET")
			APPEND TO ARRAY:C911(SCPOA_FLDNOTESeq_aL; $imageSeq_L)
			APPEND TO ARRAY:C911(SCPOA_FLDNOTENAMES_atxt; SCPOA_FLDNOTEDESC_TXT)
			CLOSE WINDOW:C154
			$Result_b:=True:C214
			
		End if 
		
	: ($Task_txt="LOADFROMDB")
		COPY NAMED SELECTION:C331([ScourPOA_Images:134]; "SCPOAFLDNOTEPRESET")
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=$CurrSCPOAID; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="FIELDNOTE"; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImgDescr_txt:4=SCPOA_FLDNOTEDESC_TXT)
		
		READ ONLY:C145([ScourPOA_Images:134])
		ORDER BY:C49([ScourPOA_Images:134]; [ScourPOA_Images:134]ImagePart:8)
		FIRST RECORD:C50([ScourPOA_Images:134])
		SHORT_MESSAGE("Reading File "+SCPOA_FLDNOTEDESC_TXT+" from DB")
		SET BLOB SIZE:C606(SCPOA_FLDNOTE_X; 0)
		$NumPieces_L:=Records in selection:C76([ScourPOA_Images:134])
		For ($Piece_L; 1; $NumPieces_L)
			GOTO SELECTED RECORD:C245([ScourPOA_Images:134]; $Piece_L)
			LOAD RECORD:C52([ScourPOA_Images:134])
			$Part1_x:=[ScourPOA_Images:134]Image_x:3
			$startPos_L:=BLOB size:C605(SCPOA_FLDNOTE_X)
			COPY BLOB:C558($Part1_x; SCPOA_FLDNOTE_X; 0; $startPos_L; BLOB size:C605($Part1_x))
		End for 
		
		READ WRITE:C146([ScourPOA_Images:134])
		USE NAMED SELECTION:C332("SCPOAFLDNOTEPRESET")
		CLEAR NAMED SELECTION:C333("SCPOAFLDNOTEPRESET")
		SET BLOB SIZE:C606($Part1_x; 0)
		
		CLOSE WINDOW:C154
		
	: ($Task_txt="GETNAMES")
		COPY NAMED SELECTION:C331([ScourPOA_Images:134]; "SCPOAFLDNOTEPRESET")
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=$CurrSCPOAID; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="FIELDNOTE")
		SELECTION TO ARRAY:C260([ScourPOA_Images:134]ImgDescr_txt:4; SCPOA_FLDNOTENAMES_atxt; [ScourPOA_Images:134]ImageSeq:6; SCPOA_FLDNOTESeq_aL)
		SORT ARRAY:C229(SCPOA_FLDNOTESeq_aL; SCPOA_FLDNOTENAMES_atxt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; Size of array:C274(SCPOA_FLDNOTESeq_aL); 2; -1)
			If (SCPOA_FLDNOTESeq_aL{$loop_L}=SCPOA_FLDNOTESeq_aL{$loop_L-1})
				DELETE FROM ARRAY:C228(SCPOA_FLDNOTESeq_aL; $loop_L; 1)
				DELETE FROM ARRAY:C228(SCPOA_FLDNOTENAMES_atxt; $loop_L; 1)
			End if 
		End for 
		USE NAMED SELECTION:C332("SCPOAFLDNOTEPRESET")
		CLEAR NAMED SELECTION:C333("SCPOAFLDNOTEPRESET")
		For ($loop_L; 1; Size of array:C274(SCPOAFieldNotesListBox))
			SCPOAFieldNotesListBox{$loop_L}:=False:C215
		End for 
		
	: (($Task_txt="VIEW") | ($Task_txt="PRINT"))
		C_TEXT:C284($tempFile_txt)
		C_LONGINT:C283($rand_L)
		$rand_L:=Random:C100
		$tempFile_txt:=ut_CreateTimeStamp+String:C10($rand_L)
		$tempFile_txt:=Temporary folder:C486+$tempFile_txt
		CREATE FOLDER:C475($tempFile_txt)
		//◊PL_DirectorySep_s
		$tempFile_txt:=$tempFile_txt+<>PL_DirectorySep_s+SCPOA_FLDNOTEDESC_TXT
		C_TIME:C306($pickafile_doc)
		$pickafile_doc:=Create document:C266($tempFile_txt)
		CLOSE DOCUMENT:C267($pickafile_doc)
		BLOB TO DOCUMENT:C526($tempFile_txt; SCPOA_FLDNOTE_X)
		If (<>MacPL_b)
			//_ O _SET DOCUMENT TYPE($tempFile_txt;"????")
		End if 
		
		ut_OpenDocument($tempFile_txt)
		If (Find in array:C230(SCPOA_TEMPFILES_atxt; $tempFile_txt)>0)
		Else 
			APPEND TO ARRAY:C911(SCPOA_TEMPFILES_atxt; $tempFile_txt)
		End if 
		
	: ($Task_txt="SAVETODISK")
		C_TEXT:C284($newfolder_txt)
		$newfolder_txt:=Select folder:C670("Choose new folder for "+SCPOA_FLDNOTEDESC_TXT)
		If (OK=1)
			C_TIME:C306($pickafile_doc)
			$pickafile_doc:=Create document:C266($newfolder_txt+SCPOA_FLDNOTEDESC_TXT)
			CLOSE DOCUMENT:C267($pickafile_doc)
			BLOB TO DOCUMENT:C526($newfolder_txt+SCPOA_FLDNOTEDESC_TXT; SCPOA_FLDNOTE_X)
			If (<>MacPL_b)
				//_ O _SET DOCUMENT TYPE($newfolder_txt+SCPOA_FLDNOTEDESC_TXT;"????")
			End if 
		End if 
		
	: ($Task_txt="SAVEALLTODISK")
		If (Size of array:C274(SCPOAFieldNotesListBox)>0)
			C_TEXT:C284($newfolder_txt)
			$newfolder_txt:=Select folder:C670("Choose new folder for all Attachments")
			If (OK=1)
				C_TIME:C306($pickafile_doc)
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274(SCPOA_FLDNOTENAMES_atxt))
					SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$loop_L}
					SCPOA_FieldNoteCtrl("LOADFROMDB")
					$pickafile_doc:=Create document:C266($newfolder_txt+SCPOA_FLDNOTEDESC_TXT)
					CLOSE DOCUMENT:C267($pickafile_doc)
					BLOB TO DOCUMENT:C526($newfolder_txt+SCPOA_FLDNOTEDESC_TXT; SCPOA_FLDNOTE_X)
					If (<>MacPL_b)
						//_ O _SET DOCUMENT TYPE($newfolder_txt+SCPOA_FLDNOTEDESC_TXT;"????")
					End if 
				End for 
			End if 
		End if 
		
	: ($Task_txt="CLEAR")
		C_LONGINT:C283($loop_L)
		ON ERR CALL:C155("SCPOA_DELDOCERROR")
		For ($loop_L; 1; Size of array:C274(SCPOA_TEMPFILES_atxt))
			If (Test path name:C476(SCPOA_TEMPFILES_atxt{$loop_L})=Is a document:K24:1)
				DELETE DOCUMENT:C159(SCPOA_TEMPFILES_atxt{$loop_L})
			End if 
		End for 
		ON ERR CALL:C155("")
		
		SET BLOB SIZE:C606(SCPOA_FLDNOTE_X; 0)
		ARRAY TEXT:C222(SCPOA_FLDNOTENAMES_atxt; 0)
		ARRAY TEXT:C222(SCPOA_TEMPFILES_atxt; 0)
		
	: ($Task_txt="DELFROMDB")
		
		COPY NAMED SELECTION:C331([ScourPOA_Images:134]; "SCPOAFLDNOTEPRESET")
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=$CurrSCPOAID; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="FIELDNOTE"; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImgDescr_txt:4=SCPOA_FLDNOTEDESC_TXT)
		InitGrpDelete
		FIRST RECORD:C50([ScourPOA_Images:134])
		While (Not:C34(End selection:C36([ScourPOA_Images:134])))
			PushGrpDelete(->[ScourPOA_Images:134]ScourPOAImgID:1)
			NEXT RECORD:C51([ScourPOA_Images:134])
		End while 
		DELETE SELECTION:C66([ScourPOA_Images:134])
		FlushGrpDeletions(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 1)
		C_LONGINT:C283($currFld_L)
		$currFld_L:=SCPOAFieldNotesListBox
		DELETE FROM ARRAY:C228(SCPOA_FLDNOTENAMES_atxt; $currFld_L; 1)
		DELETE FROM ARRAY:C228(SCPOA_FLDNOTESeq_aL; $currFld_L; 1)
		
		USE NAMED SELECTION:C332("SCPOAFLDNOTEPRESET")
		CLEAR NAMED SELECTION:C333("SCPOAFLDNOTEPRESET")
		
End case 

$0:=$Result_b