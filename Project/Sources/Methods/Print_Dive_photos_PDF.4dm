//%attributes = {"invisible":true}
//Print_Dive_photos_PDF
//Jun-2001
//Print the photos associated with the current report.
If (False:C215)
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:06:29
	Mods_2005_CJM02  //03/29/05, 16:06:24`
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 11:44:13)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:21:24)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 13:07:38)
	Mods_2016_08
	//  `use method Print_SetPDFDest to change name of output
End if 

C_LONGINT:C283($vNumPhotos; $i; $picW_L; $picH_L; $PrintPicW_L; $PrintPicH_L)
C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)
C_BOOLEAN:C305($bPortrait)

//RELATE MANY([Inspections])
G_SortInspImages
// save selection of photos/sketches
COPY NAMED SELECTION:C331([Standard Photos:36]; "AllPicts")

$bPortrait:=True:C214  //we are printing portrait currently

// get the Sketches 
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch)
ORDER BY:C49([Standard Photos:36]; [Standard Photos:36]SeqNum:6; >)
$vNumPhotos:=Records in selection:C76([Standard Photos:36])
If (($vNumPhotos>0) & (viInspPreviewErr=0))
	bSketchFlag:=True:C214
	$bPortrait:=INSP_PrintSketchChart($bPortrait; vPrintSketches)
End if 

USE NAMED SELECTION:C332("AllPicts")

// get the Charts 
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Chart)
ORDER BY:C49([Standard Photos:36]; [Standard Photos:36]SeqNum:6; >)
// Print the photos
$vNumPhotos:=Records in selection:C76([Standard Photos:36])
If (($vNumPhotos>0) & (viInspPreviewErr=0))
	bChartFlag:=True:C214
	$bPortrait:=INSP_PrintSketchChart($bPortrait; vPrintCharts)
End if 

USE NAMED SELECTION:C332("AllPicts")

// get the 4x6 photos 
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
ORDER BY:C49([Standard Photos:36]; [Standard Photos:36]SeqNum:6; >)
// Print the photos
$vNumPhotos:=Records in selection:C76([Standard Photos:36])
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
	SELECTION TO ARRAY:C260([Standard Photos:36]Portrait:4; $abPictOr)
	bPhotoFlag:=True:C214
	FIRST RECORD:C50([Standard Photos:36])
	vPage2Title:="PHOTOS"
	For ($i; 1; $vNumPhotos)
		vTitle2:=""
		vPhotoNum2:=""
		vPicture2:=$MyEmptyPicture*0
		
		vPicture1:=[Standard Photos:36]Std Photo:3
		vTitle1:=[Standard Photos:36]Description:2
		vPhotoNum1:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
		If ([Standard Photos:36]Portrait:4)
			If ($i<$vNumPhotos)
				If ($abPictOr{($i+1)})
					NEXT RECORD:C51([Standard Photos:36])
					vPicture2:=[Standard Photos:36]Std Photo:3
					vTitle2:=[Standard Photos:36]Description:2
					$i:=$i+1
					vPhotoNum2:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
				End if 
			End if 
			vPageNo:=vPageNo+1
			If ((PrintFlag) & (vPrintPhotos=1))
				PAGE BREAK:C6(>)
				If (viInspPreviewErr=0)
					Print form:C5([Standard Photos:36]; "PrintPhoto")
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
					Print form:C5([Standard Photos:36]; "PrintPhotoSingle")
				End if 
			End if 
		End if 
		If ($i<$vNumPhotos)
			NEXT RECORD:C51([Standard Photos:36])
		End if 
	End for 
	
End if 
//Blank the picture variables  
vPicture2:=$MyEmptyPicture*0
vPicture1:=$MyEmptyPicture*0

USE NAMED SELECTION:C332("AllPicts")
CLEAR NAMED SELECTION:C333("AllPicts")
//End Print_Dive_photos