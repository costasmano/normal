//%attributes = {"invisible":true}
//Method: NTI_ImageInput_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/16, 11:40:28
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 10:12:22)
	Mods_2016_08_bug
	//  `added C_PICTURE(Photo_pct)
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_PICTURE:C286(Photo_pct)
		Photo_pct:=Photo_pct*0
		If (Is new record:C668(Current form table:C627->))
			Inc_Sequence("TIN_Insp_Images"; ->[TIN_Insp_Images:186]ImageID:2)
			[TIN_Insp_Images:186]InspectionID:1:=[TIN_Inspections:184]InspectionID:2
			If (aPictType>0)
				[TIN_Insp_Images:186]ImageType:5:=aPictCode{aPictType}
				Case of 
					: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
						[TIN_Insp_Images:186]SequenceNum:6:=vNextPhotoSeq
					: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
						[TIN_Insp_Images:186]SequenceNum:6:=vNextSketchSeq
					: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
						[TIN_Insp_Images:186]SequenceNum:6:=vNextChartSeq
				End case 
			Else 
				[TIN_Insp_Images:186]ImageType:5:=BMS Photo  //Photo default
				[TIN_Insp_Images:186]SequenceNum:6:=vNextPhotoSeq
			End if 
			[TIN_Insp_Images:186]Portrait:7:=True:C214
			
		Else 
			Photo_pct:=[TIN_Insp_Images:186]ImagePic:3
			
		End if 
		NTI_ImageType_OM
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		PICTURE PROPERTIES:C457([TIN_Insp_Images:186]ImagePic:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356([TIN_Insp_Images:186]ImagePic:3); "##,###,### Bytes")+")"
		vbPictureChanged:=False:C215
		
		If (Read only state:C362([TIN_Insp_Images:186]))
			//disable entry if inspection is locked
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			//otherwise make sure they are enterable    
			OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End NTI_ImageInput_FM