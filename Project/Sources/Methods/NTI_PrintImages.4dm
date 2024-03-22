//%attributes = {"invisible":true}
//Method: NTI_PrintImages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/16, 15:34:59
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/30/16 10:17:02)
	Mods_2016_08
	//  `use method Print_SetPDFDest to change name of output; remove G_PrintOptions
End if 
//
C_LONGINT:C283($vNumPhotos; $i; $picW_L; $picH_L; $PrintPicW_L; $PrintPicH_L)
C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)
C_BOOLEAN:C305($bPortrait)
C_TEXT:C284($Name_txt)
// save selection of photos/sketches
COPY NAMED SELECTION:C331([TIN_Insp_Images:186]; "AllPicts")

$bPortrait:=True:C214  //we are printing portrait currently

// get the Sketches 
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Sketch)
ORDER BY:C49([TIN_Insp_Images:186]; [TIN_Insp_Images:186]SequenceNum:6; >)
$vNumPhotos:=Records in selection:C76([TIN_Insp_Images:186])
If (($vNumPhotos>0) & (viInspPreviewErr=0))
	bSketchFlag:=True:C214
	$bPortrait:=NTI_PrintSketchChart($bPortrait; vPrintSketches)
End if 

USE NAMED SELECTION:C332("AllPicts")

// get the Charts 
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Chart)
ORDER BY:C49([TIN_Insp_Images:186]; [TIN_Insp_Images:186]SequenceNum:6; >)
// Print the photos
$vNumPhotos:=Records in selection:C76([TIN_Insp_Images:186])
If (($vNumPhotos>0) & (viInspPreviewErr=0))
	bChartFlag:=True:C214
	$bPortrait:=NTI_PrintSketchChart($bPortrait; vPrintCharts)
End if 

USE NAMED SELECTION:C332("AllPicts")

// get the 4x6 photos 
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Photo)
ORDER BY:C49([TIN_Insp_Images:186]; [TIN_Insp_Images:186]SequenceNum:6; >)
// Print the photos
$vNumPhotos:=Records in selection:C76([TIN_Insp_Images:186])
If (($vNumPhotos>0) & (viInspPreviewErr=0))
	//make sure we set to Portrait mode  
	If (Not:C34($bPortrait))
		PAGE BREAK:C6
		DELAY PROCESS:C323(Current process:C322; 20)
		//G_PrintOptions 
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)
		Print_SetPDFDest
		
		$bPortrait:=True:C214
	End if 
	
	ARRAY BOOLEAN:C223($abPictOr; 0)
	SELECTION TO ARRAY:C260([TIN_Insp_Images:186]Portrait:7; $abPictOr)
	bPhotoFlag:=True:C214
	FIRST RECORD:C50([TIN_Insp_Images:186])
	vPage2Title:="PHOTOS"
	For ($i; 1; $vNumPhotos)
		vTitle2:=""
		vPhotoNum2:=""
		vPicture2:=$MyEmptyPicture*0
		
		vPicture1:=[TIN_Insp_Images:186]ImagePic:3
		vTitle1:=[TIN_Insp_Images:186]ImageDescr:4
		vPhotoNum1:="Photo "+String:C10([TIN_Insp_Images:186]SequenceNum:6)+":"
		If ([TIN_Insp_Images:186]Portrait:7)
			If ($i<$vNumPhotos)
				If ($abPictOr{($i+1)})
					NEXT RECORD:C51([TIN_Insp_Images:186])
					vPicture2:=[TIN_Insp_Images:186]ImagePic:3
					vTitle2:=[TIN_Insp_Images:186]ImageDescr:4
					$i:=$i+1
					vPhotoNum2:="Photo "+String:C10([TIN_Insp_Images:186]SequenceNum:6)+":"
				End if 
			End if 
			vPageNo:=vPageNo+1
			If ((PrintFlag) & (vPrintPhotos=1))
				PAGE BREAK:C6(>)
				If (viInspPreviewErr=0)
					Print form:C5([TIN_Insp_Images:186]; "PrintPhoto")
				Else 
					$i:=$vNumPhotos+1  //exit loop
				End if 
			End if 
		Else 
			//one page per photo
			vPageNo:=vPageNo+1
			If ((PrintFlag) & (vPrintPhotos=1))
				PAGE BREAK:C6(>)
				If (viInspPreviewErr=0)
					Print form:C5([TIN_Insp_Images:186]; "PrintPhotoSingle")
				End if 
			End if 
		End if 
		If ($i<$vNumPhotos)
			NEXT RECORD:C51([TIN_Insp_Images:186])
		End if 
	End for 
	
End if 
//Blank the picture variables  
vPicture2:=$MyEmptyPicture*0
vPicture1:=$MyEmptyPicture*0

USE NAMED SELECTION:C332("AllPicts")
CLEAR NAMED SELECTION:C333("AllPicts")
//End NTI_PrintImages