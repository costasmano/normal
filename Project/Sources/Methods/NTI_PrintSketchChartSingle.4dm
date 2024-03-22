//%attributes = {"invisible":true}
//Method: NTI_PrintSketchChartSingle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/16, 16:07:23
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_BOOLEAN:C305(NTI_PrintSketchChartSingle; $0; $1; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(8/30/16 10:11:15)
	Mods_2016_08
	//  `added calls to Print_SetPDFDest and SET PRINT OPTION(Orientation option ; removed G_PrintOptions
	// Modified by: Costas Manousakis-(Designer)-(2/25/21 14:36:41)
	Mods_2021_02
	//  `modified to use the new PrintPhoto_rotate form for landscape images
End if 
//
C_BOOLEAN:C305($0; $1; $bPortrait; $2; $NewPage_b)
$bPortrait:=$1
If (Count parameters:C259>1)
	$NewPage_b:=$2
Else 
	$NewPage_b:=True:C214
End if 

vPicture1:=[TIN_Insp_Images:186]ImagePic:3
Case of 
	: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
		vPage2Title:="SKETCHES"
		vPhotoNum1:="Sketch "+String:C10([TIN_Insp_Images:186]SequenceNum:6)+":"
	: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
		vPage2Title:="CHARTS"
		vPhotoNum1:="Chart "+String:C10([TIN_Insp_Images:186]SequenceNum:6)+":"
End case 
INSP_ConvertSKCH([TIN_Insp_Images:186]Portrait:7)
If ([TIN_Insp_Images:186]Portrait:7)
	If ([TIN_Insp_Images:186]Portrait:7#$bPortrait)
		PAGE BREAK:C6
		//G_PrintOptions 
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)
		Print_SetPDFDest
		$bPortrait:=True:C214
	Else 
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
	End if 
	If (viInspPreviewErr=0)
		Print form:C5([TIN_Insp_Images:186]; "PrintPhotoPortrait")
	End if 
Else 
	If (False:C215)
		
		If ([TIN_Insp_Images:186]Portrait:7#$bPortrait)
			PAGE BREAK:C6
			//G_PrintOptions (2)
			SET PRINT OPTION:C733(Orientation option:K47:2; 2)
			Print_SetPDFDest
			$bPortrait:=False:C215
		Else 
			If ($NewPage_b)
				PAGE BREAK:C6(>)
			End if 
		End if 
		If (viInspPreviewErr=0)
			Print form:C5([TIN_Insp_Images:186]; "PrintPhotoLand")
		End if 
	Else 
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
		SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //make sure we are portrait
		$bPortrait:=True:C214  //indicate that we are printing portrait
		
		If (viInspPreviewErr=0)
			Print form:C5([TIN_Insp_Images:186]; "PrintPhoto_rotate")
		End if 
	End if 
	
End if 

$0:=$bPortrait
//End NTI_PrintSketchChartSingle