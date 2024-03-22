//%attributes = {"invisible":true}
//Method: FM_StandardPhotosInput
//Form method for standardPhotos input form
// Parameters
// $1 : $FormEvent (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/23/19, 15:15:05
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04  //Moved from form method to project method as part of change to Listboxes on inspection forms
	
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 10:11:38)
	Mods_2021_04
	//  `added call to LSS_SetPrevNextButtons when editing existing image
	//  `disable navigation buttons when a new record
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 17:55:00)
	Mods_2021_09
	//  `call INSP_StdPhotoType_OM with On Load parameter
End if 
//
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		C_BOOLEAN:C305(bNewPhoto; vbPictureChanged; vbPhotoSeqChg)
		bNewPhoto:=False:C215
		vbPictureChanged:=False:C215
		vbPhotoSeqChg:=False:C215
		
		InitChangeStack(2)
		
		If (Is new record:C668([Standard Photos:36]))
			//if new record
			//Initialize to photo, portrait, next local sequence
			[Standard Photos:36]InspID:1:=[Inspections:27]InspID:2
			If (aPictType>0)
				[Standard Photos:36]PictType:5:=aPictCode{aPictType}
				Case of 
					: ([Standard Photos:36]PictType:5=BMS Photo)
						[Standard Photos:36]SeqNum:6:=vNextPhotoSeq
					: ([Standard Photos:36]PictType:5=BMS Sketch)
						[Standard Photos:36]SeqNum:6:=vNextSketchSeq
					: ([Standard Photos:36]PictType:5=BMS Chart)
						[Standard Photos:36]SeqNum:6:=vNextChartSeq
				End case 
			Else 
				[Standard Photos:36]PictType:5:=BMS Photo  //Photo default
				[Standard Photos:36]SeqNum:6:=vNextPhotoSeq
			End if 
			[Standard Photos:36]Portrait:4:=True:C214
			bNewPhoto:=True:C214
			// also create/increment StdPhotoSequnce
			Inc_Sequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)
			//log the stuff
			PushChange(2; ->[Standard Photos:36]PictType:5)
			PushChange(2; ->[Standard Photos:36]Portrait:4)
			PushChange(2; ->[Standard Photos:36]SeqNum:6)
			
			//disable navigation buttons when new record
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)
		Else 
			//setup navigation buttons
			LSS_SetPrevNextButtons(Selected record number:C246(Current form table:C627->); Records in selection:C76(Current form table:C627->))
		End if 
		
		INSP_StdPhotoType_OM(On Load:K2:1)
		//initialize Title    
		C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
		If (vInspTitle="")
			vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		End if 
		
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
		
		If (vbInspectionLocked)
			
			//disable entry if inspection is locked
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			
		Else 
			//otherwise make sure they are enterable    
			OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		SET CURSOR:C469  //set cursor back to normal
		
	: ($FormEvent_L=On Validate:K2:3)
		
		If (bNewPhoto)
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
		
	: ($FormEvent_L=On Unload:K2:2)
		//make sure buttons are left enabled
		OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		//Re-order the image selection only if we are exiting the form
		If (Record number:C243([Standard Photos:36])=-1)  //the record no. gets set to-1 when the form is exited
			G_InitInspImages
		End if 
		SET CURSOR:C469(0)  //    Mods_2004_CM06 
		
End case 
//End FM_StandardPhotosInput