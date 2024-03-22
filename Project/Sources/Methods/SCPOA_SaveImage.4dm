//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/09, 16:50:59
	// ----------------------------------------------------
	// Method: SCPOA_SaveImage
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: Costas Manousakis-(Designer)-(3/20/17 13:09:52)
	Mods_2017_03
	//  `make sure photos are compressed
End if 
C_BOOLEAN:C305($1; $Prompt_b; $SavePhoto_b; $Modified_b)
C_LONGINT:C283($MaxImageSize_L)
$MaxImageSize_L:=2048  //in Kb

If (Count parameters:C259=1)
	$Prompt_b:=$1
Else 
	$Prompt_b:=False:C215
End if 
$Modified_b:=(Modified record:C314([ScourPOA_Images:134]) | vbPictureChanged)
If (($Prompt_b) & ($Modified_b))
	CONFIRM:C162("Save any changes made to this "+[ScourPOA_Images:134]ImageType:5+"?"; "Save"; "Don't Save")
	$SavePhoto_b:=(OK=1)
Else 
	$SavePhoto_b:=True:C214
End if 
If ($SavePhoto_b)
	If (Is new record:C668([ScourPOA_Images:134]))
		If (SCPOA_LogChanges_b)
			LogNewRecord(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2; "ScourPOA_Images")
		End if 
	End if 
	C_BOOLEAN:C305(vbPictureChanged)
	//TRACE
	If (vbPictureChanged)
		//TRACE
		C_PICTURE:C286($vPic1)
		C_LONGINT:C283($vlWidth; $vlHt; $vlThumbNlW; $colordepth)
		PICTURE PROPERTIES:C457(SCPOA_Image; $vlWidth; $vlHt)
		If ([ScourPOA_Images:134]ImageType:5="PHOTO")
			$vlThumbNlW:=1024
			$colordepth:=32  //full color for pictures
		Else 
			$vlThumbNlW:=2.75*1024
			$colordepth:=8  //lower color depth for locus and detours
		End if 
		
		If ($vlWidth>$vlThumbNlW)
			SHORT_MESSAGE("Adjusting Image size...")
			CREATE THUMBNAIL:C679(SCPOA_Image; $vPic1; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colordepth)
			CLOSE WINDOW:C154
		Else 
			$vPic1:=SCPOA_Image
		End if 
		If ([ScourPOA_Images:134]ImageType:5="PHOTO")
			PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
			$vPic1:=F_CompressPic($vPic1)
			If ((Picture size:C356($vPic1)<Picture size:C356(SCPOA_Image)) & ($vlWidth>0))
				SCPOA_Image:=$vPic1
			End if 
			
		End if 
		$vPic1:=$vPic1*0
		
		C_LONGINT:C283($imgSize_L)
		$imgSize_L:=Picture size:C356(SCPOA_Image)
		If ($imgSize_L>($MaxImageSize_L*1024))
			C_TEXT:C284($vsmsg)  // Command Replaced was o_C_STRING length was 255
			$vsmsg:="Current "+[ScourPOA_Images:134]ImageType:5+" file size ("+String:C10(($imgSize_L/1024); "###,###,###")+"Kb) is excessive!"
			$vsmsg:=$vsmsg+" Image has been not been saved! "
			$vsmsg:=$vsmsg+" Please use an image less than "+String:C10($MaxImageSize_L; "###,### Kb")+" !"
			ALERT:C41($vsmsg)
			SCPOA_Image:=SCPOA_Image*0
			vPictStats:="0x0"+<>sCR+"(0 Bytes)"
			REJECT:C38
		Else 
			PICTURE TO BLOB:C692(SCPOA_Image; [ScourPOA_Images:134]Image_x:3; "jpeg")
			PushChange(2; ->[ScourPOA_Images:134]Image_x:3)
		End if 
		
	End if 
	If (SCPOA_LogChanges_b)
		FlushGrpChgs(2; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
	End if 
	SAVE RECORD:C53([ScourPOA_Images:134])
	
End if 

UNLOAD RECORD:C212([ScourPOA_Images:134])
READ ONLY:C145([ScourPOA_Images:134])
LOAD RECORD:C52([ScourPOA_Images:134])
READ WRITE:C146([ScourPOA_Images:134])