//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/08/16, 13:14:40
//----------------------------------------------------
//Method: ut_ImportResizedPictures
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_12  // 
	//Modified by: administrator (12/8/16 13:14:41)
	
End if 
READ ONLY:C145(*)
READ WRITE:C146([Standard Photos:36])
C_TEXT:C284($FolderPath_txt; $FileName_txt)
$FolderPath_txt:=Select folder:C670("Select Folder with pictures to be imported"; "")
If (ok=1)
	If (Test path name:C476($FolderPath_txt)=Is a folder:K24:2)
		vsForward:=<>Forward
		C_LONGINT:C283($Size_L; $win_L; $documentLoop_L; $PhotoID_L)
		$win_L:=ut_OpenNewWindow(500; 200; 5; 4; "Importing Resized pictures")
		C_TIME:C306($StartTime_tm; $RemainingTime_tm; $Elapsed_tm)
		$StartTime_tm:=Current time:C178
		C_BLOB:C604($Report_blb)
		SET BLOB SIZE:C606($Report_blb; 0)
		TEXT TO BLOB:C554("Inspectipon ID"+Char:C90(Tab:K15:37)+"Photo ID"+Char:C90(Tab:K15:37)+"Original Size"+Char:C90(Tab:K15:37)+"New size"+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
		ARRAY TEXT:C222($Documents_atxt; 0)
		DOCUMENT LIST:C474($FolderPath_txt; $Documents_atxt)
		$Size_L:=Size of array:C274($Documents_atxt)
		C_BOOLEAN:C305($Import_B)
		
		For ($documentLoop_L; 1; Size of array:C274($Documents_atxt))
			$Import_B:=False:C215
			If (Position:C15(".jpg"; $Documents_atxt{$documentLoop_L})>0)
				$FileName_txt:=Replace string:C233($Documents_atxt{$documentLoop_L}; ".jpg"; "")
				$Import_B:=True:C214
			End if 
			If (Position:C15(".tif"; $Documents_atxt{$documentLoop_L})>0)
				$FileName_txt:=Replace string:C233($Documents_atxt{$documentLoop_L}; ".tif"; "")
				$Import_B:=True:C214
			End if 
			If ($Import_B)
				$PhotoID_L:=Num:C11($FileName_txt)
				
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$PhotoID_L)
				
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Standard Photos:36]InspID:1)
				
				GOTO XY:C161(5; 2)
				MESSAGE:C88("Updating "+String:C10($documentLoop_L)+" out of "+String:C10($Size_L))
				GOTO XY:C161(5; 5)
				GOTO XY:C161(5; 6)
				MESSAGE:C88("Processing standard photo ID "+String:C10([Standard Photos:36]StdPhotoID:7))
				
				GOTO XY:C161(5; 7)
				$RemainingTime_tm:=(($Size_L/$documentLoop_L)-1)*(Current time:C178-$StartTime_tm)
				MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
				GOTO XY:C161(5; 9)
				
				$Elapsed_tm:=Current time:C178-$StartTime_tm
				MESSAGE:C88("Elapsed time is "+Time string:C180($Elapsed_tm))
				
				If (ut_LoadRecord(->[Standard Photos:36]))
					TEXT TO BLOB:C554(String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+String:C10($PhotoID_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
					TEXT TO BLOB:C554(String:C10(Picture size:C356([Standard Photos:36]Std Photo:3))+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
					
					ARRAY POINTER:C280(ptr_Changes; 0; 0)
					InitChangeStack(1)
					READ PICTURE FILE:C678($FolderPath_txt+$Documents_atxt{$documentLoop_L}; [Standard Photos:36]Std Photo:3)
					TEXT TO BLOB:C554(String:C10(Picture size:C356([Standard Photos:36]Std Photo:3))+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
					
					PushChange(1; ->[Standard Photos:36]Std Photo:3)
					FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
					
					SAVE RECORD:C53([Standard Photos:36])
					UNLOAD RECORD:C212([Standard Photos:36])
				End if 
				
				
			End if 
			
		End for 
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266("")
		CLOSE DOCUMENT:C267($Doc_tm)
		BLOB TO DOCUMENT:C526(Document; $Report_blb)
		SHOW ON DISK:C922(Document)
		
		CLOSE WINDOW:C154($win_L)
	End if 
End if 
//End ut_ImportResizedPictures

