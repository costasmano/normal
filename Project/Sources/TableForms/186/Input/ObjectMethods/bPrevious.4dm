//Method: [TIN_Insp_Images];"Input".bPrevious
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(9/26/17 14:11:57)
	Mods_2017_09
	//  `added NTI_SaveImage on Clicked event
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Previous Image (PgUp)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page up:K75:25; 0)
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		NTI_SaveImage
End case 

//

//End [TIN_Insp_Images];"Input".bPrevious