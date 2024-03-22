//%attributes = {"invisible":true}

// >> ----------------------------------------------------
// >> User name(OS): Chuck Miller
// >> Date and time: 04/14/16, 14:05:25
// >> ----------------------------------------------------
// >> Method: ut_CNVControlResetPicture
// >> Description
// >> 
// >> Parameters
// >> ----------------------------------------------------
If (False:C215)
	// >> 
	// >> Modified by: Chuck Miller(4/14/16 14:05:26)
	
End if 
Compiler_CNV
READ ONLY:C145(*)

C_LONGINT:C283($Width_L; $Height_L)

FORM GET PROPERTIES:C674("ConvertPicture"; $Width_L; $Height_L)
$win:=ut_OpenNewWindow($Width_L; $Height_L; 0; Plain form window:K39:10; "Create Standard Photo Selection for Update")
DIALOG:C40("ConvertPicture")
CLOSE WINDOW:C154($win)
If (Size of array:C274(CNV_RecordNumber_aL)>0) & (OK=1)
	
	C_BLOB:C604($Report_Blb)
	
	C_LONGINT:C283($RecordCount_L; $ProcID_L; $MyLoop_L)
	CONFIRM:C162("Do You want to report or Update Pictures"; "Export"; "Report")
	C_BOOLEAN:C305($ReportOnly_B; $RunAttended_B)
	$ReportOnly_B:=(OK=0)
	CONFIRM:C162("Do You want to Run"; "Unattended"; "Attended")
	$RunAttended_B:=(OK=0)
	
	C_BOOLEAN:C305($RunWithLog_B)
	
	C_BLOB:C604($BlobWithArray_BLB)
	C_TEXT:C284($NewFolderPath_txt; $OriginalFolderPath_txt)
	$NewFolderPath_txt:=Select folder:C670("Select folder to store save picture files")
	
	
	If (OK=0)
	Else 
		$OriginalFolderPath_txt:=Select folder:C670("Select folder to store Original picture files")
		
		If (OK=0) | ($OriginalFolderPath_txt=$NewFolderPath_txt)
		Else 
			C_TEXT:C284($path_txt; $text_txt)
			ARRAY TEXT:C222($Selected_atxt; 0)
			$path_txt:=Select document:C905(""; ""; "Select document to list items to trat as jpegs"; Multiple files:K24:7; $Selected_atxt)
			$path_txt:=$Selected_atxt{1}
			C_BLOB:C604($Blob_blb)
			C_LONGINT:C283($offset_L)
			DOCUMENT TO BLOB:C525($path_txt; $Blob_blb)
			
			$text_txt:=BLOB to text:C555($Blob_blb; Mac text without length:K22:10; $offset_L)
			ARRAY TEXT:C222($parts_atxt; 0)
			
			ut_NewTextToArray($text_txt; ->$parts_atxt; Char:C90(Carriage return:K15:38))
			C_LONGINT:C283($Loop_L)
			
			ARRAY LONGINT:C221($TreatAsJPGs_aL; 0)
			ARRAY LONGINT:C221($TreatAsJPGs_aL; Size of array:C274($parts_atxt))
			For ($Loop_L; 1; Size of array:C274($parts_atxt))
				ARRAY TEXT:C222($Selected_atxt; 0)
				ut_NewTextToArray($parts_atxt{$Loop_L}; ->$Selected_atxt; "_")
				$TreatAsJPGs_aL{$Loop_L}:=Num:C11($Selected_atxt{2})
				
				
				
			End for 
			VARIABLE TO BLOB:C532(ColumnWidths_txt; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532($RunAttended_B; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532(CNV_RecordNumber_aL; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532($NewFolderPath_txt; $BlobWithArray_BLB; *)
			
			VARIABLE TO BLOB:C532($OriginalFolderPath_txt; $BlobWithArray_BLB; *)
			VARIABLE TO BLOB:C532($TreatAsJPGs_aL; $BlobWithArray_BLB; *)
			CONFIRM:C162("Execute On"; "Server"; "Local Client")
			If (OK=1)
				$ProcID_L:=Execute on server:C373("ut_CNV_ExportPictures"; 0; "Export Pictures_"+String:C10(Current process:C322); $ReportOnly_B; $BlobWithArray_BLB)
			Else 
				$ProcID_L:=New process:C317("ut_CNV_ExportPictures"; 0; "Export Pictures_"+String:C10(Current process:C322); $ReportOnly_B; $BlobWithArray_BLB)
			End if 
			APPEND TO ARRAY:C911(<>CNV_UpdatePictProcessIDs_aL; $ProcID_L)
			APPEND TO ARRAY:C911(<>CNV_ProcessName_atxt; "Export Pictures_"+String:C10(Current process:C322))
			ut_LaunchCNVStop
			DELAY PROCESS:C323(Current process:C322; 360)
			$RecordCount_L:=Size of array:C274(CNV_RecordNumber_aL)
			C_REAL:C285($Complete_R)
			C_LONGINT:C283($CNV_ProcessCount_L)
			$CNV_ProcessCount_L:=-1
			$State_L:=CNV_returnProcessState($ProcID_L; "Export Pictures_"+String:C10(Current process:C322))
			
			Repeat 
				GET PROCESS VARIABLE:C371($ProcID_L; CNV_ProcessCount_L; $CNV_ProcessCount_L)
				
				
				If ($CNV_ProcessCount_L>0)
					GET PROCESS VARIABLE:C371($ProcID_L; CNV_RecordNumber_aL; CNV_RecordNumber_aL)
					
				Else 
					DELAY PROCESS:C323(Current process:C322; 30)
				End if 
				
			Until ($CNV_ProcessCount_L>0) | ($CNV_ProcessCount_L=-100)
			$RecordCount_L:=$CNV_ProcessCount_L
			$Complete_R:=0
			
			C_LONGINT:C283($CurrentLoop_L; $Comparison_L; $Numerator_L)
			C_LONGINT:C283(CurrentLoop_L)
			C_LONGINT:C283($StartTick_L; $EndTick_L; $win)
			$StartTick_L:=Tickcount:C458
			
			$win:=ut_OpenNewWindow(500; 200; 5; 4; "Exporting [Standard Photos]")
			C_TIME:C306($RemainingTime_tm; $StartTime_tm)
			$StartTime_tm:=Current time:C178
			
			Repeat 
				
				C_LONGINT:C283($State_L)
				
				$State_L:=CNV_returnProcessState($ProcID_L; "Export Pictures_"+String:C10(Current process:C322))
				
				If ($State_L<0)
					$MyLoop_L:=-99999
				Else 
					GET PROCESS VARIABLE:C371($ProcID_L; CurrentLoop_L; $MyLoop_L)
					If ($MyLoop_L>50)
						
						
						GOTO XY:C161(5; 2)
						MESSAGE:C88("Updating "+String:C10($MyLoop_L)+" out of "+String:C10($RecordCount_L))
						GOTO XY:C161(5; 5)
						MESSAGE:C88("Processing record number "+String:C10(CNV_RecordNumber_aL{$MyLoop_L}))
						
						GOTO XY:C161(5; 7)
						$RemainingTime_tm:=(($RecordCount_L/$MyLoop_L)-1)*(Current time:C178-$StartTime_tm)
						MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
						GOTO XY:C161(5; 9)
						MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178-$StartTime_tm))
						
						
					End if 
					If ($MyLoop_L>0)
						DELAY PROCESS:C323(Current process:C322; 1020)
					End if 
				End if 
			Until ($MyLoop_L=-99999)
			CLOSE WINDOW:C154($win)
			
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
// End ut_CNVControlResetPicture

