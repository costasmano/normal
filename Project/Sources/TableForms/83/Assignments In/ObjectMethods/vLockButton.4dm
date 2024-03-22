If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/12/08, 11:58:00
	// ----------------------------------------------------
	// Method: Object Method: vLockButton_L
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: Costas Manousakis-(Designer)-(10/31/14 10:26:13)
	Mods_2014_10
	//  `made accessibility to this button based on user groups instead of individual user
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
		If (User in group:C338(Current user:C182; "Design Access Group") | User in group:C338(<>CurrentUser_Name; "AssignFeeRatesEdit"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=0)
				OBJECT SET ENTERABLE:C238(*; "ContrNetFee"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "ContrOver"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "ContrNetFee"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ContrNetFee"; <>Color_not_editable)
				OBJECT SET RGB COLORS:C628(*; "ContrOver"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ContrOver"; <>Color_not_editable)
			: (Self:C308->=1)
				CONFIRM:C162("Are you sure you want to modify the Overhead and Net Fee rates?")
				If (OK=1)
					OBJECT SET ENTERABLE:C238(*; "ContrNetFee"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "ContrOver"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "ContrNetFee"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ContrNetFee"; <>Color_editable)
					OBJECT SET RGB COLORS:C628(*; "ContrOver"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "ContrOver"; <>Color_editable)
					GOTO OBJECT:C206(*; "ContrOver")
				Else 
					Self:C308->:=0
				End if 
				
		End case 
		
End case 