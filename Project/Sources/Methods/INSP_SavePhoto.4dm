//%attributes = {"invisible":true}
If (False:C215)
	//Method: INSP_SavePhoto 
	//Renamed from G_Method_SavePhoto 
	
	Mods_2004_CM06
	Mods_2004_CM10
	// Modified by: costasmanousakis-(Designer)-(5/22/2006 08:53:13)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(10/10/2006 08:31:51)
	Mods_2006_CM06A
	// Modified by: costasmanousakis-(Designer)-(2/5/09 09:07:19)
	Mods_2009_CM_5404
	//Modified logic of saving pictures, so that no large photos are saved. does not change anything for
	//sketches / charts
	// Modified by: costasmanousakis-(Designer)-(2/12/09 14:51:22)
	Mods_2009_CM_5404
	//Also restricted all images to 1250Kb size.
	// Modified by: costasmanousakis-(Designer)-(2/17/09 08:51:34)
	Mods_2009_CM_5404
	//Increased restriction to 1350Kb size.
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 14:55:26)
	Mods_2013_11
	//  `added missing ACCEPT statement  called only from the  save button.
	// Modified by: Costas Manousakis-(Designer)-(10/14/16 12:16:35)
	Mods_2016_10
	//  `Added code to make sure we do not miss changes in type, or if the photo has been changed by looking in ptr_Changes{2}
	//  ` also check for image type - if a pict and a photo - convert immediately to jpg; prevent any pdfs; prevent picts in sketches/charts
	// Modified by: Costas Manousakis-(Designer)-(3/17/17 14:48:58)
	Mods_2017_03
	//  `clean up code - compression and conversion to jpg is done only for BMS Photos.; 
	//  `make sure photo is compressed even if it does not need to be reduced in size
	// Modified by: Costas Manousakis-(Designer)-(3/20/19 11:43:23)
	Mods_2019_03_bug
	//  `added Jp2 and emf images types to be prohibited
	// Modified by: Costas Manousakis-(Designer)-(9/15/20 12:44:40)
	Mods_2020_09
	//  `replaced calls to hmfree with call to GetPictureTypes
	//  `use parameter INSP_BADIMAGETYPES to determine which images to prohibit
End if 
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
If ([Standard Photos:36]SeqNum:6=0)
	Case of 
		: ([Standard Photos:36]PictType:5=BMS Photo)
			[Standard Photos:36]SeqNum:6:=vNextPhotoSeq
		: ([Standard Photos:36]PictType:5=BMS Sketch)
			[Standard Photos:36]SeqNum:6:=vNextSketchSeq
		: ([Standard Photos:36]PictType:5=BMS Chart)
			[Standard Photos:36]SeqNum:6:=vNextChartSeq
	End case 
	C_TEXT:C284($vsmsg)  // **Replaced old C_STRING length 255
	$vsmsg:="Cannot have Zero sequence! Sequence changed to "+String:C10([Standard Photos:36]SeqNum:6)
	ALERT:C41($vsmsg)
	REJECT:C38
	$DoTheSave_b:=False:C215
	
Else 
	C_LONGINT:C283($PhotoInStack_L; $TypeInStack_L)
	$PhotoInStack_L:=Find in array:C230(ptr_Changes{2}; ->[Standard Photos:36]Std Photo:3)
	$TypeInStack_L:=Find in array:C230(ptr_Changes{2}; ->[Standard Photos:36]PictType:5)
	C_BOOLEAN:C305($needCheckImage_b)
	$needCheckImage_b:=($PhotoInStack_L>0)
	If ($TypeInStack_L>0)
		//changed type - need to check if it went from a sketch or chart to a photo)
		If ([Standard Photos:36]PictType:5=BMS Photo)
			If (Old:C35([Standard Photos:36]PictType:5)#BMS Photo)
				$needCheckImage_b:=True:C214
			End if 
			
		End if 
	End if 
	If (vbPictureChanged | $needCheckImage_b)
		C_PICTURE:C286($vPic1)
		C_LONGINT:C283($vlWidth; $vlHt; $vlThumbNlW)
		
		//Image type check
		ARRAY TEXT:C222($BadTypes_atxt; 0)
		C_TEXT:C284($ListofBadTypes_txt; $RequireImageCheck_txt)
		$ListofBadTypes_txt:="PICT;PDF"
		$ListofBadTypes_txt:=ut_GetSysParameter("INSP_BADIMAGETYPES"; $ListofBadTypes_txt)
		ut_TextToArray($ListofBadTypes_txt; ->$BadTypes_atxt; ";")
		
		ARRAY TEXT:C222($TypesFound_atxt; 0)
		GetPictureTypes([Standard Photos:36]Std Photo:3; ->$TypesFound_atxt)
		
		C_BOOLEAN:C305($IsDepracated_B)
		If (Size of array:C274($TypesFound_atxt)>0)
			C_LONGINT:C283($typeloop_L)
			For ($typeloop_L; 1; Size of array:C274($BadTypes_atxt))
				If (Position:C15($BadTypes_atxt{$typeloop_L}; $TypesFound_atxt{1})>0)
					
					If (($BadTypes_atxt{$typeloop_L}="PICT") & ([Standard Photos:36]PictType:5=BMS Photo))  // a pict photo can be converted to jpg 
						CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; ".jpg")  //v11 version - compression is done after any thumbnail is generated
					Else 
						ALERT:C41("Cannot Save "+$BadTypes_atxt{$typeloop_L}+" images! Please use either PNG, JPEG or TIFF!")
						[Standard Photos:36]Std Photo:3:=$vPic1*0
						$IsDepracated_B:=True:C214
						vPictStats:="0x0"+<>sCR+"(0 Bytes)"
						REJECT:C38
						$DoTheSave_b:=False:C215
					End if 
					
				End if 
				
			End for 
			
		End if 
		
		If ($DoTheSave_b)
			PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vlWidth; $vlHt)
			If ([Standard Photos:36]PictType:5=BMS Photo)
				$vlThumbNlW:=900
				If ($vlWidth>$vlThumbNlW)
					C_LONGINT:C283($colorDepth_I)  // **replaced _ o _C_INTEGER()
					$colorDepth_I:=32
					
					CREATE THUMBNAIL:C679([Standard Photos:36]Std Photo:3; $vPic1; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colorDepth_I)
				Else 
					$vPic1:=[Standard Photos:36]Std Photo:3
				End if 
				
				PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
				$vPic1:=F_CompressPic($vPic1)  // make sure picture is compressed to reduce size
				If ((Picture size:C356($vPic1)<Picture size:C356([Standard Photos:36]Std Photo:3)) & ($vlWidth>0))
					[Standard Photos:36]Std Photo:3:=$vPic1
					//just in case
					PushChange(2; ->[Standard Photos:36]Std Photo:3)
				End if 
				
				$vPic1:=$vPic1*0
				
			End if 
			
			C_LONGINT:C283($imgSize_L)
			
			$imgSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
			If ($imgSize_L>($MaxImageSize_L*1024))
				C_TEXT:C284($vsmsg)  // **Replaced old C_STRING length 255
				$vsmsg:="Current image file size ("+String:C10(($imgSize_L/1024); "###,###,###")+"Kb) is excessive!"
				$vsmsg:=$vsmsg+" Image has been not been saved! "
				$vsmsg:=$vsmsg+" Please use an image less than "+String:C10($MaxImageSize_L; "###,### Kb")+" !"
				ALERT:C41($vsmsg)
				[Standard Photos:36]Std Photo:3:=$vPic1*0
				vPictStats:="0x0"+<>sCR+"(0 Bytes)"
				REJECT:C38
				$DoTheSave_b:=False:C215
			Else 
				PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vlWidth; $vlHt)
				vPictStats:=String:C10($vlWidth)+"x"+String:C10($vlHt)+<>sCR+"("+String:C10($imgSize_L; "###,###,###,###")+" Bytes)"
			End if 
			
		End if 
		
	End if 
	SET CURSOR:C469(4)
	
	If ($DoTheSave_b)
		If (bNewPhoto)
			LogNewRecord(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2; "StandardPhotos")
			bNewPhoto:=False:C215
			Case of 
				: ([Standard Photos:36]PictType:5=BMS Photo)
					vNextPhotoSeq:=vNextPhotoSeq+1
				: ([Standard Photos:36]PictType:5=BMS Sketch)
					vNextSketchSeq:=vNextSketchSeq+1
				: ([Standard Photos:36]PictType:5=BMS Chart)
					vNextChartSeq:=vNextChartSeq+1
			End case 
		End if 
		FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
		//SAVE RECORD([Standard Photos])
		
		If ($param_txt="SAVE")
			ACCEPT:C269
		End if 
		
	End if 
	
	C_BOOLEAN:C305(vbPhotoSeqChg)
	If (vbPhotoSeqChg)
		vbPhotoSeqChg:=False:C215
		C_LONGINT:C283($newv; $currID)
		C_TEXT:C284($CurrType)  // **Replaced old C_STRING length 2
		
		$newv:=[Standard Photos:36]SeqNum:6
		$currID:=[Standard Photos:36]StdPhotoID:7
		$CurrType:=[Standard Photos:36]PictType:5
		PUSH RECORD:C176([Standard Photos:36])
		G_ResortImages($newv; $currID; $CurrType)
		POP RECORD:C177([Standard Photos:36])
		
	End if 
	SET CURSOR:C469(0)
	
End if 