
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/15/17, 12:08:21
//----------------------------------------------------
//Method: [InventoryPhotoInsp].Input.DE Orientation
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2017_08_bug  //  //add redraw  to [InventoryPhotoInsp];"input" for l;ist box
	// Modified by: Costas Manousakis-(Designer)-(11/5/18 15:52:39)
	Mods_2018_11
	//  `added progress bar while photos are being renamed
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		PushChange(1; Self:C308)
		//start the bar
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Renaming Photos"; Records in selection:C76([InventoryPhotos:113]); False:C215; " photo"; 3)
		
		FIRST RECORD:C50([InventoryPhotos:113])
		C_BOOLEAN:C305($ChangedDescr_b)
		While (Not:C34(End selection:C36([InventoryPhotos:113])))
			//update progress
			UpdateProgressNew($progress_o; Selected record number:C246([InventoryPhotos:113]))
			
			$ChangedDescr_b:=True:C214
			If ([InventoryPhotoInsp:112]OrientationNS_b:4)
				Case of 
					: ([InventoryPhotos:113]PhotoDescr_txt:3="EAST APPROACH")
						[InventoryPhotos:113]PhotoDescr_txt:3:="NORTH APPROACH"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="WEST APPROACH")
						[InventoryPhotos:113]PhotoDescr_txt:3:="SOUTH APPROACH"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="NORTH ELEVATION")
						[InventoryPhotos:113]PhotoDescr_txt:3:="EAST ELEVATION"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="SOUTH ELEVATION")
						[InventoryPhotos:113]PhotoDescr_txt:3:="WEST ELEVATION"
					Else 
						$ChangedDescr_b:=False:C215
				End case 
				
			Else 
				Case of 
					: ([InventoryPhotos:113]PhotoDescr_txt:3="NORTH APPROACH")
						[InventoryPhotos:113]PhotoDescr_txt:3:="EAST APPROACH"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="SOUTH APPROACH")
						[InventoryPhotos:113]PhotoDescr_txt:3:="WEST APPROACH"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="EAST ELEVATION")
						[InventoryPhotos:113]PhotoDescr_txt:3:="NORTH ELEVATION"
					: ([InventoryPhotos:113]PhotoDescr_txt:3="WEST ELEVATION")
						[InventoryPhotos:113]PhotoDescr_txt:3:="SOUTH ELEVATION"
					Else 
						$ChangedDescr_b:=False:C215
				End case 
				
			End if 
			If ($ChangedDescr_b)
				//C_LONGINT($K)
				//$K:=Find in array(InventPhotoID_aL;[InventoryPhotos]InvPhoto_ID)
				//InventPhotoDesc_atxt{$K}:=[InventoryPhotos]PhotoDescr_txt
				SAVE RECORD:C53([InventoryPhotos:113])
				LogChanges(->[InventoryPhotos:113]PhotoDescr_txt:3; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
			End if 
			NEXT RECORD:C51([InventoryPhotos:113])
		End while 
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		
		REDRAW WINDOW:C456
		REDRAW:C174(SelectListBox)
		
End case 
//End [InventoryPhotoInsp].Input.DE Orientation