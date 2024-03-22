//%attributes = {"invisible":true}
// >> Method: ut_CNV_ExportPictures
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
	C_BOOLEAN:C305(ut_CNV_ExportPictures; $1)
	C_BLOB:C604(ut_CNV_ExportPictures; $2)
	// Modified by: Costas Manousakis-(Designer)-(5/31/16 14:58:22)
	Mods_2016_05_bug
	//  `adjusted scaling for sketches and charts
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:11:15)
	Mods_2021_09
	//  `replaced hmfree commands with GET PICTURE FORMATS
End if 

READ ONLY:C145(*)
C_LONGINT:C283(CurrentLoop_L)
C_BOOLEAN:C305(CNV_StopMe_B)
ARRAY LONGINT:C221($TreatAsJPGs_aL; 0)
C_BOOLEAN:C305($ReportOnly_B; $RunAttended_B; $EXPORTME_B)
$ReportOnly_B:=True:C214
$StartTick_L:=Tickcount:C458
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$ReportOnly_B:=$1
End if 
C_TEXT:C284($NewFolderPath_txt; $OriginalFolderPath_txt; $PDFFolderPath_txt)
C_BLOB:C604($JPEGPicture_blb)
C_PICTURE:C286($Convertedpng_pic; $ConvertedJpg_pic)
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
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; $NewFolderPath_txt; $Offset_L)
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; $OriginalFolderPath_txt; $Offset_L)
	BLOB TO VARIABLE:C533($BlobWithArray_BLB; $TreatAsJPGs_aL; $Offset_L)
End if 


C_POINTER:C301($Table_ptr)
C_TEXT:C284($PL_DirectorySep_s; $Path_txt)

//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
If (Is Windows:C1573)
	$MydocSpec_txt:="My Documents"
	$PL_DirectorySep_s:="\\"
Else 
	$MydocSpec_txt:="Documents"
	$PL_DirectorySep_s:=":"
End if 
C_TEXT:C284($InspectionYear_txt; $InspectionMonth_txt; $InpsectionID_txt; $ExportFileWithBlob_txt)
C_BLOB:C604($Exported_blb)
SET BLOB SIZE:C606($Exported_blb; 0)
ARRAY TEXT:C222($Paths_atxt; 0)
ARRAY LONGINT:C221($InspectionIDs_aL; 0)
ARRAY LONGINT:C221($PhotoIDs_aL; 0)
ARRAY TEXT:C222($PictureExtension_atxt; 0)

$ExportFileWithBlob_txt:=$NewFolderPath_txt+"Export_blob.txt"
If (Test path name:C476($ExportFileWithBlob_txt)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($ExportFileWithBlob_txt; $Exported_blb)
	$Offset_L:=0
	BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
	
	CREATE SELECTION FROM ARRAY:C640([Standard Photos:36]; CNV_RecordNumber_aL)
	CREATE SET:C116([Standard Photos:36]; "ProcessSet")
	SET QUERY DESTINATION:C396(Into set:K19:2; "ProcessedSet")
	QUERY WITH ARRAY:C644([Standard Photos:36]StdPhotoID:7; $PhotoIDs_aL)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIFFERENCE:C122("ProcessSet"; "ProcessedSet"; "ProcessSet")
	USE SET:C118("ProcessSet")
	LONGINT ARRAY FROM SELECTION:C647([Standard Photos:36]; CNV_RecordNumber_aL)
	CLEAR SET:C117("ProcessSet")
	CLEAR SET:C117("ProcessedSet")
End if 
C_LONGINT:C283(CNV_ProcessCount_L)
CNV_ProcessCount_L:=Size of array:C274(CNV_RecordNumber_aL)
If (CNV_ProcessCount_L=0)
	CNV_ProcessCount_L:=-100
End if 
C_TIME:C306(CNV_Doc_tm)
C_TEXT:C284($DocName_txt; $MyDocumentsFolder_txt; $MydocSpec_txt)


$DocName_txt:="ExportPictures_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)
//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7

//$MyDocumentsFolder_txt:=Replace string($MyDocumentsFolder_txt;$PL_DirectorySep_s+"Desktop"+$PL_DirectorySep_s;$PL_DirectorySep_s+$MydocSpec_txt+$PL_DirectorySep_s)
//$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ExportPicture"
If (Test path name:C476($NewFolderPath_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($NewFolderPath_txt)
	
End if 
$MyDocumentsFolder_txt:=$NewFolderPath_txt+$PL_DirectorySep_s
CNV_Doc_tm:=Create document:C266($NewFolderPath_txt+$DocName_txt)
SEND PACKET:C103(CNV_Doc_tm; "Start process"+Char:C90(Carriage return:K15:38))
C_TEXT:C284($Line_txt)

C_BLOB:C604(Report_blb)
SET BLOB SIZE:C606(Report_blb; 0)
C_BOOLEAN:C305($IsDepracated_B; $IsPDF_B)
If (False:C215)
	TEXT TO BLOB:C554("BIN"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Insp ID"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Insp Date"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Insp Type"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Std Ph ID"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Photo Type"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Original Size"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Width"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Height"+Char:C90(Tab:K15:37); Report_blb; *)
	//TEXT TO BLOB("Scale"+Char(Tab );Report_blb;*)
	//TEXT TO BLOB("New Size"+Char(Tab );Report_blb;*)
	
	//TEXT TO BLOB("Size Difference [New - original]"+Char(Tab );Report_blb;*)
	//TEXT TO BLOB("Percentage Change"+Char(Tab );Report_blb;*)
	
	TEXT TO BLOB:C554("Deprecated"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Pict Sequence"+Char:C90(Tab:K15:37); Report_blb; *)
	TEXT TO BLOB:C554("Picture types"+Char:C90(Carriage return:K15:38); Report_blb; *)
	
Else 
	$Line_txt:="BIN"+Char:C90(Tab:K15:37)+"Insp ID"+Char:C90(Tab:K15:37)+"Insp Date"+Char:C90(Tab:K15:37)+"Insp Type"+Char:C90(Tab:K15:37)+"Std Ph ID"+Char:C90(Tab:K15:37)+"Photo Type"+Char:C90(Tab:K15:37)+"Original Size"+Char:C90(Tab:K15:37)+"Width"+Char:C90(Tab:K15:37)+"Height"+Char:C90(Tab:K15:37)
	$Line_txt:=$Line_txt+"Deprecated"+Char:C90(Tab:K15:37)+"Pict Sequence"+Char:C90(Tab:K15:37)+"Picture types"+Char:C90(Carriage return:K15:38)
	SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
	$Line_txt:=""
End if 



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
C_LONGINT:C283($SaveCount_L)
If (Test path name:C476($OriginalFolderPath_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($OriginalFolderPath_txt)
End if 
C_BOOLEAN:C305($TreatAsPhoto_B)
If ($PDFFolderPath_txt="")
	$PDFFolderPath_txt:=$OriginalFolderPath_txt+"PDF_FilesToConvert"
	If (Test path name:C476($PDFFolderPath_txt)=Is a folder:K24:2)
		$PDFFolderPath_txt:=$PDFFolderPath_txt+$PL_DirectorySep_s
	Else 
		CREATE FOLDER:C475($PDFFolderPath_txt)
		$PDFFolderPath_txt:=$PDFFolderPath_txt+$PL_DirectorySep_s
	End if 
End if 
//For (CurrentLoop_L;1;$RecordCount_L)
If (Size of array:C274(CNV_RecordNumber_aL)>0)
	Repeat 
		
		$IsDepracated_B:=False:C215
		$IsPDF_B:=False:C215
		
		
		//SEND PACKET(CNV_Doc_tm;String(CNV_RecordNumber_aL{CurrentLoop_L})+Char(Carriage return ))
		
		GOTO RECORD:C242([Standard Photos:36]; CNV_RecordNumber_aL{CurrentLoop_L})
		
		ARRAY TEXT:C222($TypesFound_atxt; 0)
		If (Picture size:C356([Standard Photos:36]Std Photo:3)>0)
			
			RELATE ONE:C42([Standard Photos:36]InspID:1)
			
			//If ([Inspections]BIN="0X8")
			C_TEXT:C284($InspectionYear_txt; $InspectionMonth_txt; $InpsectionID_txt)
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
				If (False:C215)
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
				Else 
					$Line_txt:=[Inspections:27]BIN:1+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+String:C10([Inspections:27]Insp Date:78)+Char:C90(Tab:K15:37)+[Inspections:27]Insp Type:6+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]StdPhotoID:7)+Char:C90(Tab:K15:37)
					$Line_txt:=$Line_txt+[Standard Photos:36]PictType:5+Char:C90(Tab:K15:37)+String:C10($OriginalSize_L)+Char:C90(Tab:K15:37)+String:C10($Width_L)+Char:C90(Tab:K15:37)+String:C10($Height_L)+Char:C90(Tab:K15:37)
				End if 
			End if 
			C_REAL:C285($Scale_r)
			//we are exporting all originals
			C_TEXT:C284($NewPath_txt)
			$NewPath_txt:=CNV_CreateNewPath(String:C10([Standard Photos:36]InspID:1); $OriginalFolderPath_txt)
			//CNV_CreatePath ($PL_DirectorySep_s;$OriginalFolderPath_txt)
			
			
			//C_TIME($Doc_tm)
			//$Doc_tm:=Create document($NewPath_txt+String([Standard Photos]StdPhotoID)+".txt")
			//CLOSE DOCUMENT($Doc_tm)
			$Converted_pic:=[Standard Photos:36]Std Photo:3
			SET BLOB SIZE:C606($Picture_blb; 0)
			VARIABLE TO BLOB:C532($Converted_pic; $Picture_blb; *)
			BLOB TO DOCUMENT:C526($NewPath_txt+String:C10([Standard Photos:36]StdPhotoID:7)+".txt"; $Picture_blb)
			//end export of original pictures
			
			If ($IsDepracated_B)
				If (Not:C34($IsPDF_B))
					If ($SaveCount_L=100)
						SET BLOB SIZE:C606($Exported_blb; 0)
						
						VARIABLE TO BLOB:C532($Paths_atxt; $Exported_blb; *)
						VARIABLE TO BLOB:C532($InspectionIDs_aL; $Exported_blb; *)
						VARIABLE TO BLOB:C532($PhotoIDs_aL; $Exported_blb; *)
						VARIABLE TO BLOB:C532($PictureExtension_atxt; $Exported_blb; *)
						BLOB TO DOCUMENT:C526($ExportFileWithBlob_txt; $Exported_blb)
						
						$SaveCount_L:=0
						
					End if 
					$SaveCount_L:=$SaveCount_L+1
					$Path_txt:=CNV_CreateNewPath(String:C10([Standard Photos:36]InspID:1); $NewFolderPath_txt)
					//CNV_CreatePath ($PL_DirectorySep_s;$NewFolderPath_txt)
					
					APPEND TO ARRAY:C911($Paths_atxt; $Path_txt)
					APPEND TO ARRAY:C911($InspectionIDs_aL; [Standard Photos:36]InspID:1)
					APPEND TO ARRAY:C911($PhotoIDs_aL; [Standard Photos:36]StdPhotoID:7)
					$TreatAsPhoto_B:=(Find in array:C230($TreatAsJPGs_aL; [Standard Photos:36]StdPhotoID:7)>0)
					
					$ProcessCount_L:=$ProcessCount_L+1
					Case of 
						: ([Standard Photos:36]PictType:5=BMS Photo) | ($TreatAsPhoto_B)
							
							CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; "image/jpeg")
							SET BLOB SIZE:C606($JPEGPicture_blb; 0)
							PICTURE TO BLOB:C692([Standard Photos:36]Std Photo:3; $JPEGPicture_blb; ".jpg")
							BLOB TO DOCUMENT:C526($Path_txt+String:C10([Standard Photos:36]StdPhotoID:7)+".txt"; $JPEGPicture_blb)
							//
							//WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".jpg";[Standard Photos]Std Photo;".jpg")
							//TEXT TO BLOB("NO THUMBNAIL"+Char(Tab );Report_blb;Mac text without length ;*)
							
							
							APPEND TO ARRAY:C911($PictureExtension_atxt; "jpg")
							
							
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
								$Convertedpng_pic:=[Standard Photos:36]Std Photo:3
								$Convertedjpg_pic:=[Standard Photos:36]Std Photo:3
								CONVERT PICTURE:C1002($Convertedpng_pic; "image/png")
								CONVERT PICTURE:C1002($Convertedjpg_pic; "image/png")
								SET BLOB SIZE:C606($JPEGPicture_blb; 0)
								
								If (Picture size:C356($Convertedpng_pic)>Picture size:C356($Convertedjpg_pic))
									PICTURE TO BLOB:C692($Convertedjpg_pic; $JPEGPicture_blb; ".jpg")
									APPEND TO ARRAY:C911($PictureExtension_atxt; "jpg")
								Else 
									PICTURE TO BLOB:C692($Convertedpng_pic; $JPEGPicture_blb; ".png")
									APPEND TO ARRAY:C911($PictureExtension_atxt; "png")
								End if 
								
								BLOB TO DOCUMENT:C526($Path_txt+String:C10([Standard Photos:36]StdPhotoID:7)+".txt"; $JPEGPicture_blb)
								
								
								//TEXT TO BLOB("NO THUMBNAIL"+Char(Tab );Report_blb;Mac text without length ;*)
							Else 
								//
								//Else 
								//$ScW_r:=Round($TargetW_L/$Width_L;4)
								//$ScH_r:=Round($TargetH_L/$Height_L;4)
								//$Scale_r:=MinNum ($ScW_r;$ScH_r)
								//  `If ($Scale_r>2)
								//  `$Scale_r:=2
								//  `End if 
								//TEXT TO BLOB(String($Scale_r)+Char(Tab );Report_blb;Mac text without length ;*)
								//$Converted_pic:=[Standard Photos]Std Photo
								//TRANSFORM PICTURE($Converted_pic;Scale ;$Scale_r;$Scale_r)
								//C_LONGINT($Width_L;$Height_L)
								//PICTURE PROPERTIES($Converted_pic;$Width_L;$Height_L)
								//
								//CREATE THUMBNAIL($Converted_pic;$ThumbConverted_pic;$Width_L;$Height_L)
								//
								//CONVERT PICTURE($ThumbConverted_pic;"image/png")
								//WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".png";$ThumbConverted_pic;".png")
								//[Standard Photos]Std Photo:=$ThumbConverted_pic
								//$ThumbConverted_pic:=$ThumbConverted_pic*0
								//$Converted_pic:=$Converted_pic*0
								//End if 
								
								
								
								CNV_PrintToPDF($PDFFolderPath_txt)
								APPEND TO ARRAY:C911($PictureExtension_atxt; "png")
							End if 
							//If ([Standard Photos]Portrait)
							//$TargetW_L:=1472
							//$TargetH_L:=1967
							//Else 
							//$TargetW_L:=1992
							//$TargetH_L:=1242
							//End if 
							//PICTURE PROPERTIES([Standard Photos]Std Photo;$Width_L;$Height_L)
							//
							//If ($Width_L>=$TargetW_L) | ($Height_L>$TargetH_L)
							//CONVERT PICTURE([Standard Photos]Std Photo;"image/png")
							//WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".png";[Standard Photos]Std Photo;".png")
							//TEXT TO BLOB("NO THUMBNAIL"+Char(Tab );Report_blb;Mac text without length ;*)
							//
							//Else 
							//$ScW_r:=Round($TargetW_L/$Width_L;4)
							//$ScH_r:=Round($TargetH_L/$Height_L;4)
							//$Scale_r:=MinNum ($ScW_r;$ScH_r)
							//  `If ($Scale_r>2)
							//  `$Scale_r:=2
							//  `End if 
							//TEXT TO BLOB(String($Scale_r)+Char(Tab );Report_blb;Mac text without length ;*)
							//$Converted_pic:=[Standard Photos]Std Photo
							//TRANSFORM PICTURE($Converted_pic;Scale ;$Scale_r;$Scale_r)
							//C_LONGINT($Width_L;$Height_L)
							//PICTURE PROPERTIES($Converted_pic;$Width_L;$Height_L)
							//
							//CREATE THUMBNAIL($Converted_pic;$ThumbConverted_pic;$Width_L;$Height_L)
							//
							//CONVERT PICTURE($ThumbConverted_pic;"image/png")
							//WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".png";$ThumbConverted_pic;".png")
							//[Standard Photos]Std Photo:=$ThumbConverted_pic
							//$ThumbConverted_pic:=$ThumbConverted_pic*0
							//$Converted_pic:=$Converted_pic*0
							//End if 
							
							
					End case 
					//$NewSize_L:=Picture size([Standard Photos]Std Photo)
					
					//TEXT TO BLOB(String($NewSize_L)+Char(Tab );Report_blb;Mac text without length ;*)
					//TEXT TO BLOB(String($NewSize_L-$OriginalSize_L)+Char(Tab );Report_blb;Mac text without length ;*)
					//C_REAL($Result_r)
					//$Result_r:=Round(($NewSize_L-$OriginalSize_L)/$OriginalSize_L;4)
					
					//TEXT TO BLOB(String(($Result_r*100);"######.00%")+Char(Tab );Report_blb;Mac text without length ;*)
					If (False:C215)
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
					Else 
						$Line_txt:=$Line_txt+String:C10($IsDepracated_B)+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]SeqNum:6)+Char:C90(Tab:K15:37)
						
						
						If (Size of array:C274($TypesFound_atxt)=0)
							//TEXT TO BLOB("No Types found "+Char(Carriage return );Report_blb;Mac text without length ;*)
							$Line_txt:=$Line_txt+"No Types found "+Char:C90(Carriage return:K15:38)
						Else 
							For ($TypeLoop_L; 1; Size of array:C274($TypesFound_atxt))
								If ($TypeLoop_L=Size of array:C274($TypesFound_atxt))
									If ($TreatAsPhoto_B)
										$Line_txt:=$Line_txt+$TypesFound_atxt{$TypeLoop_L}+" Treated as jpg"+Char:C90(Carriage return:K15:38)
									Else 
										$Line_txt:=$Line_txt+$TypesFound_atxt{$TypeLoop_L}+Char:C90(Carriage return:K15:38)
									End if 
								Else 
									
									$Line_txt:=$Line_txt+$TypesFound_atxt{$TypeLoop_L}+Char:C90(Tab:K15:37)
								End if 
								
							End for 
						End if 
					End if 
					
					//If (Not($ReportOnly_B))
					//SAVE RECORD([Standard Photos])
					//UNLOAD RECORD([Standard Photos])
					//End if 
				Else 
					CNV_PrintToPDF($PDFFolderPath_txt)
					If (False:C215)
						TEXT TO BLOB:C554("PDF Document"+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
					Else 
						$Line_txt:=$Line_txt+"PDF Document "+Char:C90(Carriage return:K15:38)
					End if 
				End if 
				
			End if 
			//Else 
			//If (Not($IsPDF_B))
			//$EXPORTME_B:=True
			//Case of 
			//: ([Standard Photos]ModTimeStamp_s="20160528@")
			//: ([Standard Photos]ModTimeStamp_s="20160529@")
			//: ([Standard Photos]ModTimeStamp_s="20160530@")
			//
			//Else 
			//$EXPORTME_B:=False
			//End case 
			//If ($EXPORTME_B)
			//
			//If ($SaveCount_L=100)
			//
			//SET BLOB SIZE($Exported_blb;0)
			//VARIABLE TO BLOB($Paths_atxt;$Exported_blb;*)
			//VARIABLE TO BLOB($InspectionIDs_aL;$Exported_blb;*)
			//VARIABLE TO BLOB($PhotoIDs_aL;$Exported_blb;*)
			//VARIABLE TO BLOB($PictureExtension_atxt;$Exported_blb;*)
			//
			//
			//BLOB TO DOCUMENT($ExportFileWithBlob_txt;$Exported_blb)
			//
			//$SaveCount_L:=0
			//
			//End if 
			//$SaveCount_L:=$SaveCount_L+1
			//$Path_txt:=CNV_CreatePath ($PL_DirectorySep_s;$NewFolderPath_txt)
			//
			//APPEND TO ARRAY($Paths_atxt;$Path_txt)
			//APPEND TO ARRAY($InspectionIDs_aL;[Standard Photos]InspID)
			//APPEND TO ARRAY($PhotoIDs_aL;[Standard Photos]StdPhotoID)
			//If (Position("JPG";$TypesFound_atxt{1})>0)
			//APPEND TO ARRAY($PictureExtension_atxt;"JPG")
			//SET BLOB SIZE($JPEGPicture_blb;0)
			//PICTURE TO BLOB([Standard Photos]Std Photo;$JPEGPicture_blb;".jpg")
			//BLOB TO DOCUMENT($Path_txt+String([Standard Photos]StdPhotoID)+".txt";$JPEGPicture_blb)
			//
			//  `WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".jpg";[Standard Photos]Std Photo;".jpg")
			//End if 
			//If (Position("PNG";$TypesFound_atxt{1})>0)
			//APPEND TO ARRAY($PictureExtension_atxt;".PNG")
			//SET BLOB SIZE($JPEGPicture_blb;0)
			//PICTURE TO BLOB([Standard Photos]Std Photo;$JPEGPicture_blb;".PNG")
			//BLOB TO DOCUMENT($Path_txt+String([Standard Photos]StdPhotoID)+".txt";$JPEGPicture_blb)
			//
			//  `WRITE PICTURE FILE($Path_txt+String([Standard Photos]StdPhotoID)+".png";[Standard Photos]Std Photo;".PNG")
			//End if 
			//End if 
			//
			//Else 
			//CNV_PrintToPDF ($PDFFolderPath_txt)
			//  `TEXT TO BLOB("PDF Document"+Char(Carriage return );Report_blb;Mac text without length ;*)
			//End if 
		End if 
		//End if 
		SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
		$Line_txt:=""
		
		
		//IDLE
		//DELAY PROCESS(Current process;15)  `let's give every else a few ticks before going to next record
		If (CNV_StopMe_B)
			CurrentLoop_L:=$RecordCount_L+10
		End if 
		CurrentLoop_L:=CurrentLoop_L+1
	Until ((CNV_StopMe_B) | (CurrentLoop_L>$RecordCount_L))
	//end for
End if 

C_TIME:C306($End_tm)
$End_tm:=Current time:C178

$EndTick_L:=Tickcount:C458



If (False:C215)
	TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($StartTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($EndTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554("Elapsed Tick count"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($EndTick_L-$StartTick_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
	
	TEXT TO BLOB:C554("Elapsed time"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(Time string:C180($End_tm-$Start_tm)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
	
	TEXT TO BLOB:C554("Number processed"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($ProcessCount_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
Else 
	$Line_txt:=Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	$Line_txt:=$Line_txt+String:C10($StartTick_L)+Char:C90(Tab:K15:37)+String:C10($EndTick_L)+Char:C90(Tab:K15:37)+"Elapsed Tick count"+Char:C90(Tab:K15:37)+String:C10($EndTick_L-$StartTick_L)+Char:C90(Tab:K15:37)
	$Line_txt:=$Line_txt+"Elapsed time"+Char:C90(Tab:K15:37)+String:C10($End_tm-$Start_tm)+Char:C90(Tab:K15:37)
	$Line_txt:=$Line_txt+"Number processed"+Char:C90(Tab:K15:37)+String:C10($ProcessCount_L)+Char:C90(Carriage return:K15:38)
	
	SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
	
End if 
SET BLOB SIZE:C606($Exported_blb; 0)
VARIABLE TO BLOB:C532($Paths_atxt; $Exported_blb; *)
VARIABLE TO BLOB:C532($InspectionIDs_aL; $Exported_blb; *)
VARIABLE TO BLOB:C532($PhotoIDs_aL; $Exported_blb; *)
VARIABLE TO BLOB:C532($PictureExtension_atxt; $Exported_blb; *)
BLOB TO DOCUMENT:C526($ExportFileWithBlob_txt; $Exported_blb)

If (Not:C34($RunAttended_B))
	
	//C_TEXT($DocName_txt;$MyDocumentsFolder_txt;$MydocSpec_txt)
	//C_LONGINT($Platform_L)
	//
	//$DocName_txt:="ResetPicture_"+String(Current process)+"_"+Substring(ut_ReturnTimeStampFromDate (Current date;Current time);1;12)+".txt"
	//$MyDocumentsFolder_txt:=System folder(Desktop )
	//PLATFORM PROPERTIES($Platform_L)
	//C_TEXT($PL_DirectorySep_s)
	//
	//If ($Platform_L=Windows )
	//$MydocSpec_txt:="My Documents"
	//$PL_DirectorySep_s:="\\"
	//Else 
	//$MydocSpec_txt:="Documents"
	//$PL_DirectorySep_s:=":"
	//End if 
	//
	//$MyDocumentsFolder_txt:=Replace string($MyDocumentsFolder_txt;$PL_DirectorySep_s+"Desktop"+$PL_DirectorySep_s;$PL_DirectorySep_s+$MydocSpec_txt+$PL_DirectorySep_s)
	//
	//If (Test path name($MyDocumentsFolder_txt)=Is a directory )
	//Else 
	//$MyDocumentsFolder_txt:=System folder(Desktop )  `set to desktop if something not correct
	//End if 
	//$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ResetPictureLogs"
	//If (Test path name($MyDocumentsFolder_txt)=Is a directory )
	//Else 
	//CREATE FOLDER($MyDocumentsFolder_txt)
	//
	//End if 
	//$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+$PL_DirectorySep_s
	//CNV_Doc_tm:=Create document($MyDocumentsFolder_txt+$DocName_txt)
	//CLOSE DOCUMENT(CNV_Doc_tm)
	//BLOB TO DOCUMENT(Document;Report_blb)
End if 
CurrentLoop_L:=-99999
Repeat 
	
	DELAY PROCESS:C323(Current process:C322; 120)
	
Until (CurrentLoop_L=-8888)
//Progress QUIT($ProgressID_L)
CLOSE DOCUMENT:C267(CNV_Doc_tm)
// End ut_CNV_CheckPictures