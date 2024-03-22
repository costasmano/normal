If (False:C215)
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
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (SCPOA_INPUTMODE_L=2)
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
				If (Picture size:C356(SCPOA_Image)>0)
					SHORT_MESSAGE("Copying photo to clipboard..")
					SET PICTURE TO PASTEBOARD:C521(SCPOA_Image)
					CLOSE WINDOW:C154
				End if 
				
			: (Self:C308->{$Index_L}="@Descr@")
				If ([ScourPOA_Images:134]ImgDescr_txt:4#"")
					SHORT_MESSAGE("Copying Descr to clipboard..")
					SET TEXT TO PASTEBOARD:C523([ScourPOA_Images:134]ImgDescr_txt:4)
					CLOSE WINDOW:C154
				End if 
		End case 
		
End case 
