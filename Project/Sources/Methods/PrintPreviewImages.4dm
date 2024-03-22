//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// PrintPreviewImages
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:13:51
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	
	//PrintPreviewImages
	//Print preview the current image associated with the inspection
	//Created December 2004
	
	Mods_2004_VN04
	Mods_2005_CJM02  //03/29/05, 16:13:45
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 11:44:13)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:25:15)
	Mods_2007_CM12_5301
End if 

C_LONGINT:C283($vNumPhotos; $i; $vCurrentPhotoIndex)
C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)
C_BOOLEAN:C305($Portrait_b)
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0

Case of 
		//Sketch or Chart Print Preview    
	: (([Standard Photos:36]PictType:5=BMS Sketch) | ([Standard Photos:36]PictType:5=BMS Chart))
		If ([Standard Photos:36]PictType:5=BMS Sketch)
			vPageNo:=aiSketchPage{Find in array:C230(aiSketchSeqNo; [Standard Photos:36]SeqNum:6)}
		Else 
			vPageNo:=aiChartPage{Find in array:C230(aiChartSeqNo; [Standard Photos:36]SeqNum:6)}
		End if 
		//set the page orientation
		If ([Standard Photos:36]Portrait:4)
			G_PrintOptions
		Else 
			G_PrintOptions(2)
		End if 
		
		$Portrait_b:=INSP_PrintSketchChartSingle([Standard Photos:36]Portrait:4; False:C215)  //don't start a new page
		
	: ([Standard Photos:36]PictType:5=BMS Sketch)
		
		//Chart Print Preview    
	: ([Standard Photos:36]PictType:5=BMS Chart)
		
		//Photo Print Preview    
	: ([Standard Photos:36]PictType:5=BMS Photo)
		vPage2Title:="PHOTOS"
		$vNumPhotos:=Size of array:C274(aiPhotoPage)
		
		//get page number for the current photo
		$vCurrentPhotoIndex:=Find in array:C230(aiPhotoSeqNo; [Standard Photos:36]SeqNum:6)
		vPageNo:=aiPhotoPage{$vCurrentPhotoIndex}
		//The current photo is in 2 per page mode
		If ([Standard Photos:36]Portrait:4)
			//Only one photo
			If ($vNumPhotos=1)
				PreviewCurrentPhoto
				//More than one photos
			Else 
				Case of 
						//Current photo is the first one
					: ($vCurrentPhotoIndex=1)
						//The next one & the current one are in the same page
						If (vPageNo=aiPhotoPage{$vCurrentPhotoIndex+1})
							//PreviewCurrentAndNextPhotos 
							PreviewCurrentPhoto("NEXT")
							//They are not in the same page
						Else 
							PreviewCurrentPhoto
						End if 
						
						//Current photo is the last one
					: ($vCurrentPhotoIndex=$vNumPhotos)
						//The previous one & the current one are in the same page            
						If (vPageNo=aiPhotoPage{$vCurrentPhotoIndex-1})
							//PreviewPreviousAndCurrentPhotos 
							PreviewCurrentPhoto("PREVIOUS")
							//They are not in the same page
						Else 
							PreviewCurrentPhoto
						End if 
						
						//The current photo is in between the first and last ones            
					Else 
						Case of 
								//The next one & the current one are in the same page                
							: (vPageNo=aiPhotoPage{$vCurrentPhotoIndex+1})
								//PreviewCurrentAndNextPhotos 
								PreviewCurrentPhoto("NEXT")
								
								//The previous one & the current one are the same page
							: (vPageNo=aiPhotoPage{$vCurrentPhotoIndex-1})
								//PreviewPreviousAndCurrentPhotos 
								PreviewCurrentPhoto("PREVIOUS")
								
							Else 
								PreviewCurrentPhoto
						End case 
				End case 
			End if 
			
			//The current photo is not in the 2 per page mode      
		Else 
			PreviewCurrentPhoto
		End if 
End case 