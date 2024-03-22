//%attributes = {"invisible":true}
// ` ----------------------------------------------------
// ` User name(OS): Chuck Miller
// ` Date and time: 04/14/16, 14:05:25
// ` ----------------------------------------------------
// ` Method: ut_CNVControlImportPictures

// ` Description
// ` 
// ` Parameters
// ` ----------------------------------------------------
If (False:C215)
	// ` 
	// ` Modified by: Chuck Miller(4/14/16 14:05:26)
	// Run this as a new process
	// Enter begin date and end date. Hit the get count button
	// Select Export button in answer to Do You want to report or Update Pictures
	// Select Unattended button in answer to question Do You want to Run
	
	// There are three questions
	// Select folder to store save picture files
	//   `1. Select path named Exported Pictures:Converted in anwer to 1st question
	
	// Select folder to store Original picture files
	//   `2. Select path named Exported Pictures:Originals in answer to 2nd question
	// Select document to list items to treat as jpegs
	//   `3. select file named TreatAsJPEGS.txt in Exported Pictures folder
	
End if 
Compiler_CNV


READ ONLY:C145(*)
C_BOOLEAN:C305($Complete_B; $RunAttended_B)
$Complete_B:=False:C215
Repeat 
	C_LONGINT:C283(<>CNV_TraceRecordNumber_L)
	<>CNV_TraceRecordNumber_L:=-1
	C_LONGINT:C283($Width_L; $Height_L)
	FORM GET PROPERTIES:C674("ConvertPicture"; $Width_L; $Height_L)
	$win:=ut_OpenNewWindow($Width_L; $Height_L; 0; Plain form window:K39:10; "Create Standard Photo Selection for Import")
	DIALOG:C40("ConvertPicture")
	CLOSE WINDOW:C154($win)
	<>CNV_TraceRecordNumber_L:=0
	If (Size of array:C274(CNV_RecordNumber_aL)>0) & (OK=1)
		
		C_BLOB:C604($Report_Blb)
		
		C_LONGINT:C283($RecordCount_L; $ProcID_L; $MyLoop_L)
		CONFIRM:C162("Do You want to Run"; "Unattended"; "Attended")
		$RunAttended_B:=(OK=0)
		
		C_BOOLEAN:C305($RunWithLog_B)
		
		C_BLOB:C604($BlobWithArray_BLB)
		C_TEXT:C284($NewFolderPath_txt; $OriginalFolderPath_txt)
		$NewFolderPath_txt:=Select folder:C670("Select folder containing pictures to import")
		
		
		If (OK=0)
		Else 
			
			
			C_LONGINT:C283($Loop_L)
			SET BLOB SIZE:C606($BlobWithArray_BLB; 0)
			
			VARIABLE TO BLOB:C532(ColumnWidths_txt; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532($RunAttended_B; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532(CNV_RecordNumber_aL; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532($NewFolderPath_txt; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532(CNV_Start_d; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532(CNV_End_d; $BlobWithArray_BLB; *)
			
			
			$ProcID_L:=New process:C317("CNV_ImportPictures"; 0; "Import Pictures_"+String:C10(Current process:C322); $BlobWithArray_BLB)
			
			
			If (Find in array:C230(<>CNV_UpdatePictProcessIDs_aL; $ProcID_L)>0)
				
			Else 
				APPEND TO ARRAY:C911(<>CNV_ProcessName_atxt; "Import Pictures_"+String:C10(Current process:C322))
				APPEND TO ARRAY:C911(<>CNV_UpdatePictProcessIDs_aL; $ProcID_L)
			End if 
			ut_LaunchCNVStop
			
			$RecordCount_L:=Size of array:C274(CNV_RecordNumber_aL)
			C_REAL:C285($Complete_R)
			$Complete_R:=0
			
			C_LONGINT:C283($CurrentLoop_L; $Comparison_L; $Numerator_L)
			C_LONGINT:C283(CurrentLoop_L)
			C_LONGINT:C283($StartTick_L; $EndTick_L; $win)
			$StartTick_L:=Tickcount:C458
			If (False:C215)
				// $win:=ut_OpenNewWindow (500;200;5;4;"Exporting [Standard Photos]")
				// C_TIME($RemainingTime_tm;$StartTime_tm)
				// $StartTime_tm:=Current time
				$MyLoop_L:=100
				Repeat 
					
					C_LONGINT:C283($State_L)
					
					$State_L:=CNV_returnProcessState($ProcID_L; "Export Pictures_"+String:C10(Current process:C322))
					
					If ($State_L<0)
						$MyLoop_L:=-99999
						// Else 
						// If ($MyLoop_L>50)
						// 
						// 
						// GOTO XY(5;2)
						// MESSAGE("Updating "+String($MyLoop_L)+" out of "+String($RecordCount_L))
						// GOTO XY(5;5)
						// MESSAGE("Processing record number "+String(CNV_RecordNumber_aL{$MyLoop_L}))
						// 
						// GOTO XY(5;7)
						// $RemainingTime_tm:=(($RecordCount_L/$MyLoop_L)-1)*(Current time-$StartTime_tm)
						// MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
						// GOTO XY(5;9)
						// MESSAGE("Elapsed time is "+Time string(Current time-$StartTime_tm))
						// 
						// 
						// End if 
						
					End if 
					If ($MyLoop_L>0)
						DELAY PROCESS:C323(Current process:C322; 1020)
					End if 
					GET PROCESS VARIABLE:C371($ProcID_L; CurrentLoop_L; $MyLoop_L)
					
				Until ($MyLoop_L=-99999)
				
				
				If ($RunAttended_B)
					GET PROCESS VARIABLE:C371($ProcID_L; Report_Blb; $Report_Blb)
					$MyLoop_L:=-8888
					SET PROCESS VARIABLE:C370($ProcID_L; CurrentLoop_L; $MyLoop_L)
					$EndTick_L:=Tickcount:C458
					ALERT:C41("Elapsed tick count is "+String:C10($EndTick_L-$StartTick_L))
					C_TIME:C306($Doc_tm)
					C_TEXT:C284($DocName_txt)
					
					$DocName_txt:="ExportPicture_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
					<>MyDocumentsFolder_txt:=<>MyDocumentsFolder_txt+"ResetPictureLogs"
					If (Test path name:C476(<>MyDocumentsFolder_txt)=Is a folder:K24:2)
					Else 
						CREATE FOLDER:C475(<>MyDocumentsFolder_txt)
						
					End if 
					<>MyDocumentsFolder_txt:=<>MyDocumentsFolder_txt+<>PL_DirectorySep_s
					$Doc_tm:=Create document:C266(<>MyDocumentsFolder_txt+$DocName_txt)
					CLOSE DOCUMENT:C267($Doc_tm)
					BLOB TO DOCUMENT:C526(Document; $Report_blb)
				Else 
					$MyLoop_L:=-8888
					SET PROCESS VARIABLE:C370($ProcID_L; CurrentLoop_L; $MyLoop_L)
					
					
					
				End if 
			End if 
			
		End if 
	End if 
	CONFIRM:C162("Process another year"; "yes"; "no")
	$Complete_B:=(OK=0)
Until ($Complete_B)

// End ut_CNVControlResetPicture

