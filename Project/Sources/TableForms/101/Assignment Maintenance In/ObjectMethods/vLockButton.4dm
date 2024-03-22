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
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
		OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Overhead:5; False:C215)
		OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Fee:6; False:C215)
		OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Overhead:5; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Overhead; <>Color_not_editable)
		OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Fee:6; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Fee; <>Color_not_editable)
		C_LONGINT:C283(CM_ADDENCALBASE)
		CM_ADDENCALBASE:=0
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=0)
				OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Overhead:5; False:C215)
				OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Fee:6; False:C215)
				OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Overhead:5; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Overhead; <>Color_not_editable)
				OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Fee:6; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Fee; <>Color_not_editable)
				CM_ADDENCALBASE:=0
			: (Self:C308->=1)
				CONFIRM:C162("Are you sure you want to modify the Overhead and Net Fee rates?")
				If (OK=1)
					OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Overhead:5; True:C214)
					OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]Fee:6; True:C214)
					OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Overhead:5; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Overhead; <>Color_editable)
					OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]Fee:6; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]Fee; <>Color_editable)
					GOTO OBJECT:C206([Contract_Assignment_Maintenance:101]Overhead:5)
				Else 
					Self:C308->:=0
					CM_ADDENCALBASE:=0
				End if 
				
		End case 
		
End case 