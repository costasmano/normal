If (False:C215)
	//
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/09/07, 09:32:03
	// ----------------------------------------------------
	// Method: Object Method: CopyOptiondropDwn
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:35:29)
	Mods_2007_CM06
	// Modified by: Costas Manousakis-(Designer)-(10/7/15 17:14:50)
	Mods_2015_10_bug
	//  `When copying the image convert it to JPEG, unless the shift key is pressed where the original stored image will be put on the clipboard
	//  `This done to address a OSX 10.10.5 problem where the original image was not recognized by the Preview app or the Pages app
	// Modified by: Costas Manousakis-(Designer)-(5/9/16 12:10:56)
	Mods_2016_05_bug
	//  `instead  of picture to blob - blob to picture, use covnert picture to change the picture to .jpg
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbInspectionLocked)
		If (vbInspectionLocked)
			If (User in group:C338(Current user:C182; "CopyImageGroup"))
				OBJECT SET ENABLED:C1123(Self:C308->; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(Self:C308->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			End if 
		Else 
			OBJECT SET ENABLED:C1123(Self:C308->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Index_L)
		$Index_L:=Self:C308->
		Case of 
				
			: (Self:C308->{$Index_L}="@Image@")
				If (Picture size:C356([Standard Photos:36]Std Photo:3)>0)
					If (Shift down:C543)
						SHORT_MESSAGE("Copying original image to clipboard..")
						SET PICTURE TO PASTEBOARD:C521([Standard Photos:36]Std Photo:3)
					Else 
						SHORT_MESSAGE("Copying image as JPEG to clipboard..")
						//C_BLOB($cliBlob_x)
						C_PICTURE:C286($temp_pic)
						$temp_pic:=[Standard Photos:36]Std Photo:3
						CONVERT PICTURE:C1002($temp_pic; ".jpg")
						//PICTURE TO BLOB([Standard Photos]Std Photo;$cliBlob_x;"JPEG")
						//BLOB TO PICTURE($cliBlob_x;$temp_pic;"JPEG")
						SET PICTURE TO PASTEBOARD:C521($temp_pic)
						//SET BLOB SIZE($cliBlob_x;0)
						$temp_pic:=$temp_pic*0
					End if 
					CLOSE WINDOW:C154
					If (False:C215)
						
						ARRAY TEXT:C222($sigs_atxt; 0)
						ARRAY TEXT:C222($Native_atxt; 0)
						ARRAY TEXT:C222($formats_atxt; 0)
						GET PASTEBOARD DATA TYPE:C958($sigs_atxt; $Native_atxt; $formats_atxt)
						C_LONGINT:C283($loop_L)
						ARRAY LONGINT:C221($datasizes_aL; Size of array:C274($sigs_atxt))
						For ($loop_L; 1; Size of array:C274($sigs_atxt))
							GET PASTEBOARD DATA:C401($sigs_atxt{$loop_L}; $cliBlob_x)
							$datasizes_aL{$loop_L}:=BLOB size:C605($cliBlob_x)
						End for 
						SET BLOB SIZE:C606($cliBlob_x; 0)
						For ($loop_L; 1; Size of array:C274($sigs_atxt))
							$sigs_atxt{$loop_L}:=$sigs_atxt{$loop_L}+"  "+$Native_atxt{$loop_L}+"  "+String:C10($datasizes_aL{$loop_L}; "###,###,###,###,###")
						End for 
						
					End if 
					
				End if 
				
			: (Self:C308->{$Index_L}="@Descr@")
				If ([Standard Photos:36]Description:2#"")
					SHORT_MESSAGE("Copying Description to clipboard..")
					SET TEXT TO PASTEBOARD:C523([Standard Photos:36]Description:2)
					CLOSE WINDOW:C154
				End if 
		End case 
		
End case 