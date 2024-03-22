//%attributes = {"invisible":true}
// >> Method: ut_CNV_CheckPictures
// >> Description
// >> 
// >> Parameters
// >> ----------------------------------------------------
If (False:C215)
	
	// >> ----------------------------------------------------
	// >> User name(OS): Chuck Miller
	// >> Date and time: 04/12/16, 11:53:38
	// >> ----------------------------------------------------
	// >> 
	// >> Modified by: Chuck Miller(4/12/16 11:53:40)
	C_BOOLEAN:C305(ut_CNV_CheckPictures; $1)
	C_BLOB:C604(ut_CNV_CheckPictures; $2)
	// Modified by: Costas Manousakis-(Designer)-(5/31/16 14:58:22)
	Mods_2016_05_bug
	//  `adjusted scaling for sketches and charts
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:10:07)
	Mods_2021_09
	//  `replaced hmfree commands with GET PICTURE FORMATS
End if 

READ ONLY:C145(*)
C_LONGINT:C283(CurrentLoop_L)
C_BOOLEAN:C305(CNV_StopMe_B)

C_BOOLEAN:C305($ReportOnly_B; $RunAttended_B)
$ReportOnly_B:=True:C214
$StartTick_L:=Tickcount:C458
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$ReportOnly_B:=$1
End if 

If (Count parameters:C259>1)
	C_BLOB:C604($2; $BlobWithArray_BLB)
	$BlobWithArray_BLB:=$2
	
	C_LONGINT:C283($Offset_L)
	$Offset_L:=0
	C_TEXT:C284(ColumnWidths_txt)
	ARRAY LONGINT:C221(CNV_RecordNumber_aL; 0)
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; ColumnWidths_txt; $Offset_L)
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; $RunAttended_B; $Offset_L)
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; CNV_RecordNumber_aL; $Offset_L)
	
	
End if 




C_POINTER:C301($Table_ptr)
If (ColumnWidths_txt="Standard Photos")
	$Table_ptr:=->[Standard Photos:36]
	
	READ WRITE:C146([Standard Photos:36])
Else 
	$Table_ptr:=->[Standard Photos:36]
	
	READ WRITE:C146([Standard Photos:36])
End if 
C_TEXT:C284($InspectionYear_txt; $InspectionMonth_txt; $InpsectionID_txt)


C_TIME:C306(CNV_Doc_tm)
C_TEXT:C284($DocName_txt; $MyDocumentsFolder_txt; $MydocSpec_txt)

$DocName_txt:="ResetPictureProcessLog_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)
//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
C_TEXT:C284($PL_DirectorySep_s)

//If ($Platform_L=Windows)// MassDOT_PS - conversion
If (Is Windows:C1573)
	$MydocSpec_txt:="My Documents"
	$PL_DirectorySep_s:="\\"
Else 
	$MydocSpec_txt:="Documents"
	$PL_DirectorySep_s:=":"
End if 

$MyDocumentsFolder_txt:=Replace string:C233($MyDocumentsFolder_txt; $PL_DirectorySep_s+"Desktop"+$PL_DirectorySep_s; $PL_DirectorySep_s+$MydocSpec_txt+$PL_DirectorySep_s)
$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ResetPictureLogs"
If (Test path name:C476($MyDocumentsFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($MyDocumentsFolder_txt)
	
End if 
$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+$PL_DirectorySep_s
CNV_Doc_tm:=Create document:C266($MyDocumentsFolder_txt+$DocName_txt)
SEND PACKET:C103(CNV_Doc_tm; "Start prrocess"+Char:C90(Carriage return:K15:38))

C_BLOB:C604(Report_blb)
SET BLOB SIZE:C606(Report_blb; 0)
C_BOOLEAN:C305($IsDepracated_B; $IsPDF_B)
TEXT TO BLOB:C554("BIN"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp ID"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp Date"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp Type"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Std Ph ID"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Photo Type"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Original Size"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Width"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Height"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Scale"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("New Size"+Char:C90(Tab:K15:37); Report_blb; *)

TEXT TO BLOB:C554("Size Difference [New - original]"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Percentage Change"+Char:C90(Tab:K15:37); Report_blb; *)

TEXT TO BLOB:C554("Deprecated"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Pict Sequence"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Picture types"+Char:C90(Carriage return:K15:38); Report_blb; *)



C_LONGINT:C283(CurrentLoop_L; $TypeLoop_L; $RecordCount_L)
//If (hmFree_IsLicensed >=0)

//Else 

//$RecordCount_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")

//End if 
C_LONGINT:C283($ProgressID_L)
// $ProgressID_L:=Progress New
C_REAL:C285($Complete_R)
C_LONGINT:C283($NextUpdate_L; $Width_L; $Height_L; $OriginalSize_L; $NewSize_L; $RecordCount_L; $StartLocation_L)
C_LONGINT:C283($TargetW_L; $TargetH_L)
C_REAL:C285($ScW_r; $ScH_r)
C_BOOLEAN:C305($ResetUpdate_B)
$ResetUpdate_B:=False:C215
$NextUpdate_L:=500
// Progress SET MESSAGE($ProgressID_L;"Checking standard photo types";True)
$RecordCount_L:=Size of array:C274(CNV_RecordNumber_aL)
C_TEXT:C284(CNV_ProcessDocument_txt)
CNV_ProcessDocument_txt:=$MyDocumentsFolder_txt+$DocName_txt

C_LONGINT:C283($StartTick_L; $EndTick_L; $ProcessCount_L)
$StartTick_L:=Tickcount:C458
C_TIME:C306($Start_tm)
$ProcessCount_L:=0
C_PICTURE:C286($Converted_pic; $ThumbConverted_pic)
$Start_tm:=Current time:C178
ON ERR CALL:C155("CNV_Error")
C_TEXT:C284($RecordNumbers_txt)
C_LONGINT:C283($SendPacketCount_L)
$SendPacketCount_L:=0

CurrentLoop_L:=1
//For (CurrentLoop_L;1;$RecordCount_L)
Repeat 
	
	$IsDepracated_B:=False:C215
	$IsPDF_B:=False:C215
	
	If (ColumnWidths_txt="Standard Photos")
		
		
		SEND PACKET:C103(CNV_Doc_tm; String:C10(CNV_RecordNumber_aL{CurrentLoop_L})+Char:C90(Carriage return:K15:38))
		
		GOTO RECORD:C242([Standard Photos:36]; CNV_RecordNumber_aL{CurrentLoop_L})
		
		ARRAY TEXT:C222($TypesFound_atxt; 0)
		If (Picture size:C356([Standard Photos:36]Std Photo:3)>0)
			
			RELATE ONE:C42([Standard Photos:36]InspID:1)
			//If ([Inspections]BIN="0X8")
			C_TEXT:C284($StartFolder; $InspectionYear_txt; $InspectionMonth_txt; $InpsectionID_txt)
			$InspectionYear_txt:=String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")
			$InspectionMonth_txt:=String:C10(Month of:C24([Inspections:27]Insp Date:78); "0000")
			
			//hmFree_GET PICTURE TYPES ([Standard Photos]Std Photo;$TypesFound_atxt)
			GET PICTURE FORMATS:C1406([Standard Photos:36]Std Photo:3; $TypesFound_atxt)
			If (Position:C15("PICT"; $TypesFound_atxt{1})>0)
				$IsDepracated_B:=True:C214
			End if 
			$IsPDF_B:=False:C215
			If (Position:C15("pdf"; $TypesFound_atxt{1})>0)
				$IsDepracated_B:=True:C214
				$IsPDF_B:=True:C214
			End if 
			If ($IsDepracated_B)
				TEXT TO BLOB:C554([Inspections:27]BIN:1+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(String:C10([Inspections:27]Insp Date:78)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554([Inspections:27]Insp Type:6+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(String:C10([Standard Photos:36]StdPhotoID:7)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554([Standard Photos:36]PictType:5+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				
				$OriginalSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
				TEXT TO BLOB:C554(String:C10($OriginalSize_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $Width_L; $Height_L)
				TEXT TO BLOB:C554(String:C10($Width_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(String:C10($Height_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
				
			End if 
			C_REAL:C285($Scale_r)
			
			
			If ($IsDepracated_B)
				If (Not:C34($IsPDF_B))
					If (ut_LoadRecordonServer(->[Standard Photos:36]))
						$ProcessCount_L:=$ProcessCount_L+1
						Case of 
							: ([Standard Photos:36]PictType:5=BMS Photo)
								CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; "image/jpeg")
								TEXT TO BLOB:C554("NO THUMBNAIL"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
							: (([Standard Photos:36]PictType:5=BMS Sketch) | ([Standard Photos:36]PictType:5=BMS Chart))
								If ([Standard Photos:36]Portrait:4)
									$TargetW_L:=1472
									$TargetH_L:=1967
								Else 
									$TargetW_L:=1992
									$TargetH_L:=1242
								End if 
								PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $Width_L; $Height_L)
								
								If ($Width_L>=$TargetW_L) | ($Height_L>$TargetH_L)
									CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; "image/png")
									TEXT TO BLOB:C554("NO THUMBNAIL"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
								Else 
									$ScW_r:=Round:C94($TargetW_L/$Width_L; 4)
									$ScH_r:=Round:C94($TargetH_L/$Height_L; 4)
									$Scale_r:=MinNum($ScW_r; $ScH_r)
									//If ($Scale_r>2)
									//$Scale_r:=2
									//End if 
									TEXT TO BLOB:C554(String:C10($Scale_r)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
									$Converted_pic:=[Standard Photos:36]Std Photo:3
									TRANSFORM PICTURE:C988($Converted_pic; Scale:K61:2; $Scale_r; $Scale_r)
									C_LONGINT:C283($Width_L; $Height_L)
									PICTURE PROPERTIES:C457($Converted_pic; $Width_L; $Height_L)
									
									CREATE THUMBNAIL:C679($Converted_pic; $ThumbConverted_pic; $Width_L; $Height_L)
									
									CONVERT PICTURE:C1002($ThumbConverted_pic; "image/png")
									[Standard Photos:36]Std Photo:3:=$ThumbConverted_pic
									$ThumbConverted_pic:=$ThumbConverted_pic*0
									$Converted_pic:=$Converted_pic*0
								End if 
								
							: ([Standard Photos:36]PictType:5=BMS Chart)
								PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $Width_L; $Height_L)
								If ($Width_L>=1290) | ($Height_L>1290)
									CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; "image/png")
									TEXT TO BLOB:C554("NO THUMBNAIL"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
									
								Else 
									$Scale_r:=MaxNum((1290/$Width_L); (1290/$Height_L))
									If ($Scale_r>2)
										$Scale_r:=2
									End if 
									TEXT TO BLOB:C554(String:C10($Scale_r)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
									$Converted_pic:=[Standard Photos:36]Std Photo:3
									TRANSFORM PICTURE:C988($Converted_pic; Scale:K61:2; $Scale_r; $Scale_r)
									
									PICTURE PROPERTIES:C457($Converted_pic; $Width_L; $Height_L)
									
									CREATE THUMBNAIL:C679($Converted_pic; $ThumbConverted_pic; $Width_L; $Height_L)
									
									CONVERT PICTURE:C1002($ThumbConverted_pic; "image/png")
									[Standard Photos:36]Std Photo:3:=$ThumbConverted_pic
								End if 
						End case 
						$NewSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
						
						TEXT TO BLOB:C554(String:C10($NewSize_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554(String:C10($NewSize_L-$OriginalSize_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
						C_REAL:C285($Result_r)
						$Result_r:=Round:C94(($NewSize_L-$OriginalSize_L)/$OriginalSize_L; 4)
						
						TEXT TO BLOB:C554(String:C10(($Result_r*100); "######.00%")+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
						
						TEXT TO BLOB:C554(String:C10($IsDepracated_B)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554(String:C10([Standard Photos:36]SeqNum:6)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
						
						If (Size of array:C274($TypesFound_atxt)=0)
							TEXT TO BLOB:C554("No Types found "+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
							
						Else 
							For ($TypeLoop_L; 1; Size of array:C274($TypesFound_atxt))
								If ($TypeLoop_L=Size of array:C274($TypesFound_atxt))
									TEXT TO BLOB:C554($TypesFound_atxt{$TypeLoop_L}+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
									
								Else 
									TEXT TO BLOB:C554($TypesFound_atxt{$TypeLoop_L}+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
									
								End if 
								
							End for 
						End if 
					End if 
					
					If (Not:C34($ReportOnly_B))
						SAVE RECORD:C53([Standard Photos:36])
						UNLOAD RECORD:C212([Standard Photos:36])
					End if 
				Else 
					TEXT TO BLOB:C554("PDF Document"+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
				End if 
			End if 
			//End if 
			
		End if 
	End if 
	//IDLE
	DELAY PROCESS:C323(Current process:C322; 15)  //let's give every else a few ticks before going to next record
	If (CNV_StopMe_B)
		CurrentLoop_L:=$RecordCount_L+10
	End if 
	CurrentLoop_L:=CurrentLoop_L+1
Until ((CNV_StopMe_B) | (CurrentLoop_L>$RecordCount_L))
//end for

CLOSE DOCUMENT:C267(CNV_Doc_tm)

C_TIME:C306($End_tm)
$End_tm:=Current time:C178

$EndTick_L:=Tickcount:C458
TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($StartTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($EndTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("Elapsed Tick count"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($EndTick_L-$StartTick_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

TEXT TO BLOB:C554("Elapsed time"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(Time string:C180($End_tm-$Start_tm)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

TEXT TO BLOB:C554("Number processed"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($ProcessCount_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

If (Not:C34($RunAttended_B))
	
	C_TEXT:C284($DocName_txt; $MyDocumentsFolder_txt; $MydocSpec_txt)
	//C_LONGINT($Platform_L)
	
	$DocName_txt:="ResetPicture_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
	$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)
	//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
	C_TEXT:C284($PL_DirectorySep_s)
	
	//If ($Platform_L=Windows)// MassDOT_PS - conversion
	If (Is Windows:C1573)
		$MydocSpec_txt:="My Documents"
		$PL_DirectorySep_s:="\\"
	Else 
		$MydocSpec_txt:="Documents"
		$PL_DirectorySep_s:=":"
	End if 
	
	$MyDocumentsFolder_txt:=Replace string:C233($MyDocumentsFolder_txt; $PL_DirectorySep_s+"Desktop"+$PL_DirectorySep_s; $PL_DirectorySep_s+$MydocSpec_txt+$PL_DirectorySep_s)
	
	If (Test path name:C476($MyDocumentsFolder_txt)=Is a folder:K24:2)
	Else 
		$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)  //set to desktop if something not correct
	End if 
	$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ResetPictureLogs"
	If (Test path name:C476($MyDocumentsFolder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($MyDocumentsFolder_txt)
		
	End if 
	$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+$PL_DirectorySep_s
	CNV_Doc_tm:=Create document:C266($MyDocumentsFolder_txt+$DocName_txt)
	CLOSE DOCUMENT:C267(CNV_Doc_tm)
	BLOB TO DOCUMENT:C526(Document; Report_blb)
End if 
CurrentLoop_L:=-99999
Repeat 
	
	DELAY PROCESS:C323(Current process:C322; 120)
	
Until (CurrentLoop_L=-8888)
//Progress QUIT($ProgressID_L)

// End ut_CNV_CheckPictures