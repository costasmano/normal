//%attributes = {"invisible":true}
//Method: Temp_FixStdPhotoSizes
//Description
// fix the photosizes of standard photos - Save to folders current pictures if they get replaced
// Can use Temp_LoadSavedLargePhoto to load saved pictures
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/21/17, 12:55:42
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
	// Modified by: Costas Manousakis-(Designer)-(3/31/17 17:31:44)
	Mods_2017_03
	//  `mods to read std photo ids from a file and log activity to file
	// Modified by: Costas Manousakis-(Designer)-(4/19/17 15:58:55)
	Mods_2017_04
	//  `mods to logic and messages
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:08:55)
	Mods_2021_09
	//  `replaced hmfree commands with GET PICTURE FORMATS
End if 
//

C_LONGINT:C283($vlWidth; $vlHt; $vlThumbNlW; $colorDepth_I; $origSize_L; $finalsize_L; $Reduced_L; $total0_L; $total1_L)
C_PICTURE:C286($vPic1)
C_TEXT:C284($Lastmod_txt; $LogFile_txt; $LogMessage_txt; $Thumb_txt; $Replace_txt)

//get a list of photoIds from pasteboard - probably an excel list
//select file with list of IDs one in each line
C_TIME:C306($photoIDfile_t)
ARRAY LONGINT:C221($IDs_aL; 0)
$photoIDfile_t:=Open document:C264(""; ""; Read mode:K24:5)
If (OK=1)
	$LogFile_txt:=Document+"_log"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
	C_TEXT:C284($Pasted_txt)
	
	Repeat 
		RECEIVE PACKET:C104($photoIDfile_t; $Pasted_txt; Char:C90(13))
		If (Num:C11($Pasted_txt)>0)
			APPEND TO ARRAY:C911($IDs_aL; Num:C11($Pasted_txt))
		End if 
	Until (OK=0)
	
	CLOSE DOCUMENT:C267($photoIDfile_t)
	
	CONFIRM:C162("Search for "+String:C10(Size of array:C274($IDs_aL))+" IDs of StdPhoto records?"; "Search"; "Cancel")
	
	READ ONLY:C145([Inspections:27])
	READ WRITE:C146([Standard Photos:36])
	If (OK=1)
		C_LONGINT:C283($hmfreeRes_L)
		//If (hmFree_IsLicensed >=0)
		//Else 
		//$hmfreeRes_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
		//End if 
		C_BOOLEAN:C305($saveToDB_b; $exportPicToFile_B)
		CONFIRM:C162("Save the modified photos to db or just report?"; "Save"; "ReportOnly")
		$saveToDB_b:=(OK=1)
		$exportPicToFile_B:=$saveToDB_b
		C_TEXT:C284($TemplateFile_txt; $FilePath_txt; $folderNeeded_txt; $baseFolder_txt)
		ARRAY TEXT:C222($folders_atxt; 3)
		
		$TemplateFile_txt:="000"+<>PL_DirectorySep_s+"000"+<>PL_DirectorySep_s+"000"+<>PL_DirectorySep_s+"000"
		C_BLOB:C604($blb_x)
		C_TIME:C306($doc_t)
		
		If (Not:C34($saveToDB_b))
			CONFIRM:C162("Export the pic data to file?")
			$exportPicToFile_B:=(OK=1)
		End if 
		If ($exportPicToFile_B)
			$baseFolder_txt:=Select folder:C670("Select Folder where pictures will be saved")
			If (OK=1)
				
			Else 
				//will not run !
				ALERT:C41("An Export folder MUST be selected!  Process will not run - log file will be empty!")
				ARRAY LONGINT:C221($IDs_aL; 0)  // clear the array - that will stop the loop
			End if 
		End if 
		C_TIME:C306($LogFile_t)
		$LogFile_t:=Create document:C266($LogFile_txt)
		$LogMessage_txt:="ID"+Char:C90(Tab:K15:37)+"Size 0 /Msg"+Char:C90(Tab:K15:37)+"Width0"+Char:C90(Tab:K15:37)+"Height0"+Char:C90(Tab:K15:37)
		$LogMessage_txt:=$LogMessage_txt+"Size 1"+Char:C90(Tab:K15:37)+"Width1"+Char:C90(Tab:K15:37)+"Height1"+Char:C90(Tab:K15:37)
		$LogMessage_txt:=$LogMessage_txt+"Size 2"+Char:C90(Tab:K15:37)
		$LogMessage_txt:=$LogMessage_txt+"Size 3"+Char:C90(Tab:K15:37)+"Width3"+Char:C90(Tab:K15:37)+"Height3"+Char:C90(Tab:K15:37)+"Thumbnail"+Char:C90(Tab:K15:37)+"Replace"+Char:C90(Carriage return:K15:38)
		SEND PACKET:C103($LogFile_t; $LogMessage_txt)
		C_LONGINT:C283($loop_L; $Floop_L)
		//start the bar
		C_LONGINT:C283(<>ProgressPID)
		<>ProgressPID:=StartProgress("Std Photo Convert"; "Button"; "Processing "+String:C10(Size of array:C274($IDs_aL))+" Standard Photo IDs"; "Standard Photo IDs")
		// initialize the bar 
		If (Size of array:C274($IDs_aL)>0)
			UpdateProgress(0; Size of array:C274($IDs_aL))
		End if 
		C_PICTURE:C286($savePic_pic)
		C_LONGINT:C283($startTic_L; $EndTick_L)
		$startTic_L:=Milliseconds:C459
		For ($loop_L; 1; Size of array:C274($IDs_aL))
			4DError_b:=False:C215
			If ($loop_L%20=0)
				//update the bar
				UpdateProgress($loop_L; Size of array:C274($IDs_aL))
			End if 
			$LogMessage_txt:=String:C10($IDs_aL{$loop_L})
			ON ERR CALL:C155("4D_Errors")
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$IDs_aL{$loop_L})
			If (4DError_b)
				$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+"Error Loading record!!"
				REDUCE SELECTION:C351([Standard Photos:36]; 0)
				ON ERR CALL:C155("")
			End if 
			
			If (Records in selection:C76([Standard Photos:36])=0)
				If (Not:C34(4DError_b))
					$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+"Not Found!"
				End if 
			Else 
				ut_LoadRecordInteractive(->[Standard Photos:36])
				If (Picture size:C356([Standard Photos:36]Std Photo:3)>100)  //picture should be more than 100 bytes!
					ARRAY TEXT:C222($TypesFound_atxt; 0)
					//hmFree_GET PICTURE TYPES ([Standard Photos]Std Photo;$TypesFound_atxt)
					GET PICTURE FORMATS:C1406([Standard Photos:36]Std Photo:3; $TypesFound_atxt)
					If (Position:C15("PICT"; $TypesFound_atxt{1})>0)
						// *****   SKIP PICTS - they will be converted in other step
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+"PICT Type!!"
					Else 
						$savePic_pic:=[Standard Photos:36]Std Photo:3  //save the picture
						PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vlWidth; $vlHt)
						
						$vlThumbNlW:=900
						$origSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
						$total0_L:=$total0_L+$origSize_L
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+String:C10($origSize_L)+Char:C90(Tab:K15:37)+String:C10($vlWidth)+Char:C90(Tab:K15:37)+String:C10($vlHt)
						If ($vlWidth>$vlThumbNlW)
							C_LONGINT:C283($colorDepth_I)  //Command Replaced was o_C_INTEGER
							$colorDepth_I:=32
							CREATE THUMBNAIL:C679([Standard Photos:36]Std Photo:3; $vPic1; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colorDepth_I)
							$Thumb_txt:="Thumbnail"
						Else 
							$vPic1:=[Standard Photos:36]Std Photo:3
							$Thumb_txt:="No Thumbnail"
						End if 
						PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+String:C10(Picture size:C356($vPic1))+Char:C90(Tab:K15:37)+String:C10($vlWidth)+Char:C90(Tab:K15:37)+String:C10($vlHt)
						
						$vPic1:=F_CompressPic($vPic1)  // make sure picture is compressed to reduce size and converted to jpeg
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+String:C10(Picture size:C356($vPic1))
						PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
						If ((Round:C94((Picture size:C356($vPic1)/Picture size:C356([Standard Photos:36]Std Photo:3)); 2)<1) & ($vlWidth>0) & (Picture size:C356($vPic1)>0))
							[Standard Photos:36]Std Photo:3:=$vPic1
							//don't log changes!!!!!!!!
							//LogChanges (->[Standard Photos]Std Photo;->[Inspections]InspID;->[Standard Photos]InspID;->[Standard Photos]StdPhotoID;2)
							If ($saveToDB_b)
								SAVE RECORD:C53([Standard Photos:36])
							End if 
							$Replace_txt:="Replaced"
							If ($exportPicToFile_B)
								//now should save the picture blob - break file name by photoID
								$FilePath_txt:=$baseFolder_txt+String:C10([Standard Photos:36]StdPhotoID:7; $TemplateFile_txt)+".4pct"  //4d format pict
								
								$folders_atxt{1}:=Substring:C12(String:C10([Standard Photos:36]StdPhotoID:7; $TemplateFile_txt); 1; 3)
								$folders_atxt{2}:=Substring:C12(String:C10([Standard Photos:36]StdPhotoID:7; $TemplateFile_txt); 5; 3)
								$folders_atxt{3}:=Substring:C12(String:C10([Standard Photos:36]StdPhotoID:7; $TemplateFile_txt); 9; 3)
								$folderNeeded_txt:=$baseFolder_txt
								For ($Floop_L; 1; 3)
									$folderNeeded_txt:=$folderNeeded_txt+$folders_atxt{$Floop_L}+<>PL_DirectorySep_s
									If (Test path name:C476($folderNeeded_txt)#Is a folder:K24:2)
										CREATE FOLDER:C475($folderNeeded_txt)
									End if 
								End for 
								//$FilePath_txt:=$baseFolder_txt+$FilePath_txt
								$doc_t:=Create document:C266($FilePath_txt)
								CLOSE DOCUMENT:C267($doc_t)
								//WRITE PICTURE FILE($FilePath_txt;$savePic_pic)
								SET BLOB SIZE:C606($blb_x; 0)
								VARIABLE TO BLOB:C532($savePic_pic; $blb_x)
								BLOB TO DOCUMENT:C526($FilePath_txt; $blb_x)
								$savePic_pic:=$savePic_pic*0
							End if 
						Else 
							$Replace_txt:="NOTReplaced"
						End if 
						$finalsize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
						$total1_L:=$total1_L+$finalsize_L
						$Reduced_L:=$Reduced_L+($origSize_L-$finalsize_L)
						PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vlWidth; $vlHt)
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+String:C10($finalsize_L)+Char:C90(Tab:K15:37)+String:C10($vlWidth)+Char:C90(Tab:K15:37)+String:C10($vlHt)
						$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+$Thumb_txt+Char:C90(Tab:K15:37)+$Replace_txt
						$vPic1:=$vPic1*0
						
					End if 
				Else 
					$LogMessage_txt:=$LogMessage_txt+Char:C90(Tab:K15:37)+"Size has been almost zeroed!"+Char:C90(Tab:K15:37)+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3))
				End if 
				
			End if 
			
			SEND PACKET:C103($LogFile_t; $LogMessage_txt+Char:C90(Carriage return:K15:38))
			
			If (<>Abort)
				$loop_L:=Size of array:C274($IDs_aL)+1
			End if 
			
		End for 
		//stop the progress bar
		POST OUTSIDE CALL:C329(<>ProgressPID)
		CLOSE DOCUMENT:C267($LogFile_t)
		SHOW ON DISK:C922($LogFile_txt)
		$EndTick_L:=Milliseconds:C459
		If ($total0_L=0)
			$LogMessage_txt:="Zero Original size!!!!"
		Else 
			$LogMessage_txt:="Original Size "+String:C10($total0_L; "###,###,###,###,###,###")+" - Final size "+String:C10($total1_L; "###,###,###,###,###,###")
			$LogMessage_txt:=$LogMessage_txt+" - Reduction "+String:C10($Reduced_L; "###,###,###,###,###,###")
			$LogMessage_txt:=$LogMessage_txt+" - Ratio "+String:C10(100*$total1_L/$total0_L; "###,##0.00000")
		End if 
		C_LONGINT:C283($TickElapsed_L; $Seconds_L; $Dt_L)
		$TickElapsed_L:=$EndTick_L-$startTic_L
		C_TEXT:C284($TimeStr_txt)
		$TimeStr_txt:=""
		$Dt_L:=$TickElapsed_L
		
		C_REAL:C285($deCsec_r)
		C_LONGINT:C283($Min_L; $hrs_L; $days_L)
		
		$deCsec_r:=$dt_L/1000
		$Min_L:=$deCsec_r\60
		$deCsec_r:=$deCsec_r-($Min_L*60)
		$hrs_L:=$Min_L\60
		$Min_L:=$Min_L-($hrs_L*60)
		$days_L:=$hrs_L\24
		$hrs_L:=$hrs_L-($days_L*24)
		C_TEXT:C284($TimeStr_txt)
		$TimeStr_txt:=String:C10($days_L; "###,###,###d ;;")+String:C10($hrs_L; "###h ;;")+String:C10($Min_L; "###m ;;")+String:C10($deCsec_r; "###.###s;;")
		$LogMessage_txt:=$LogMessage_txt+" - Time elapsed "+$TimeStr_txt
		
		ALERT:C41($LogMessage_txt)
		
	End if 
	
End if 

//End Temp_FixStdPhotoSizes