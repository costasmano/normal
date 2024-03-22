//%attributes = {"invisible":true}
//Method: NTI_SaveImage
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/16, 11:44:05
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_TEXT:C284(NTI_SaveImage; $1)
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 10:25:52)
	Mods_2016_08_bug
	//  `add f_TrimStr ([TIN_Insp_Images]ImageDescr;True;True)
	// Modified by: Costas Manousakis-(Designer)-(3/17/17 15:04:25)
	Mods_2017_03
	//  `make sure BMS Photos are JPEGS and compressed
End if 
//
ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InspectionID")
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "ImageID")

C_TEXT:C284($1; $param_txt)
$param_txt:=""
If (Count parameters:C259>0)
	$param_txt:=$1
End if 

C_LONGINT:C283($MaxImageSize_L)
$MaxImageSize_L:=1350  //in Kb
//Check for zero sequence
C_BOOLEAN:C305($DoTheSave_b)
$DoTheSave_b:=True:C214
If ([TIN_Insp_Images:186]SequenceNum:6=0)
	Case of 
		: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
			[TIN_Insp_Images:186]SequenceNum:6:=vNextPhotoSeq
		: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
			[TIN_Insp_Images:186]SequenceNum:6:=vNextSketchSeq
		: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
			[TIN_Insp_Images:186]SequenceNum:6:=vNextChartSeq
	End case 
	C_TEXT:C284($vsmsg)  // Command Replaced was o_C_STRING length was 255
	$vsmsg:="Cannot have Zero sequence! Sequence changed to "+String:C10([TIN_Insp_Images:186]SequenceNum:6)
	ALERT:C41($vsmsg)
	REJECT:C38
	$DoTheSave_b:=False:C215
	
Else 
	If (vbPictureChanged)
		C_PICTURE:C286($vPic1)
		C_LONGINT:C283($vlWidth; $vlHt; $vlThumbNlW)
		$vlThumbNlW:=900
		PICTURE PROPERTIES:C457([TIN_Insp_Images:186]ImagePic:3; $vlWidth; $vlHt)
		Case of 
			: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
				$vlThumbNlW:=900
			: (([TIN_Insp_Images:186]ImageType:5=BMS Sketch) | ([TIN_Insp_Images:186]ImageType:5=BMS Chart))
				$vlThumbNlW:=$vlWidth
		End case 
		
		If ($vlWidth>$vlThumbNlW)
			C_LONGINT:C283($colorDepth_I)  //Command Replaced was o_C_INTEGER
			Case of 
				: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
					$colorDepth_I:=32
				: (([TIN_Insp_Images:186]ImageType:5=BMS Sketch) | ([TIN_Insp_Images:186]ImageType:5=BMS Chart))
					$colorDepth_I:=8
			End case 
			CREATE THUMBNAIL:C679([TIN_Insp_Images:186]ImagePic:3; $vPic1; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colorDepth_I)
		Else 
			$vPic1:=[TIN_Insp_Images:186]ImagePic:3
		End if 
		
		If ([TIN_Insp_Images:186]ImageType:5#BMS Photo)
			CONVERT PICTURE:C1002([TIN_Insp_Images:186]ImagePic:3; "images/png")
			PushChange(2; ->[TIN_Insp_Images:186]ImagePic:3)
			Photo_pct:=[TIN_Insp_Images:186]ImagePic:3
		Else 
			PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
			$vPic1:=F_CompressPic($vPic1)
			If ((Picture size:C356($vPic1)<Picture size:C356([TIN_Insp_Images:186]ImagePic:3)) & ($vlWidth>0))
				[TIN_Insp_Images:186]ImagePic:3:=$vPic1
				//just in case
				PushChange(2; ->[TIN_Insp_Images:186]ImagePic:3)
			End if 
			Photo_pct:=[TIN_Insp_Images:186]ImagePic:3
		End if 
		$vPic1:=$vPic1*0
		
		C_LONGINT:C283($imgSize_L)
		$imgSize_L:=Picture size:C356([TIN_Insp_Images:186]ImagePic:3)
		If ($imgSize_L>($MaxImageSize_L*1024))
			C_TEXT:C284($vsmsg)  // Command Replaced was o_C_STRING length was 255
			$vsmsg:="Current image file size ("+String:C10(($imgSize_L/1024); "###,###,###")+"Kb) is excessive!"
			$vsmsg:=$vsmsg+" Image has been not been saved! "
			$vsmsg:=$vsmsg+" Please use an image less than "+String:C10($MaxImageSize_L; "###,### Kb")+" !"
			ALERT:C41($vsmsg)
			[TIN_Insp_Images:186]ImagePic:3:=$vPic1*0
			Photo_pct:=Photo_pct*0
			vPictStats:="0x0"+<>sCR+"(0 Bytes)"
			REJECT:C38
			$DoTheSave_b:=False:C215
		Else 
			PushChange(2; ->[TIN_Insp_Images:186]ImagePic:3)
		End if 
		
	End if 
	
	If ($DoTheSave_b)
		If (Is new record:C668([TIN_Insp_Images:186]))
			LogNewRecord(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Images:186]InspectionID:1; ->[TIN_Insp_Images:186]ImageID:2; 2; "TIN_Insp_Images")
			
			Case of 
				: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
					vNextPhotoSeq:=vNextPhotoSeq+1
				: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
					vNextSketchSeq:=vNextSketchSeq+1
				: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
					vNextChartSeq:=vNextChartSeq+1
			End case 
		End if 
		[TIN_Insp_Images:186]ImageDescr:4:=f_TrimStr([TIN_Insp_Images:186]ImageDescr:4; True:C214; True:C214)
		ACT_PushGroupChanges(Table:C252(->[TIN_Insp_Images:186]); 2; ->$FieldsToSkip_atxt)
		FlushGrpChgs(2; ->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Images:186]InspectionID:1; ->[TIN_Insp_Images:186]ImageID:2; 2)
		
		If ($param_txt="SAVE")
			ACCEPT:C269
		End if 
		
	End if 
	
End if 
//End NTI_SaveImage