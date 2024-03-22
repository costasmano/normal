If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/17/07, 14:19:45
	// ----------------------------------------------------
	// Method: Form Method: [Parameters];"Input"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/6/2007 08:35:50)
	Mods_2007_CM10a
	// Modified by: Costas Manousakis-(Designer)-(5/15/18 10:13:22)
	Mods_2018_05
	//  `enabled context menu for the description
	// Modified by: Costas Manousakis-(Designer)-(5/14/20 )
	Mods_2020_05
	//  `adjusted size location of objects, made Value field grow horiz.
	//  `removed obj method from ParamCode - added code to lock it for existing records
	// Modified by: Costas Manousakis-(Designer)-(6/10/20 13:34:26)
	Mods_2020_06
	//  `Added button to edit json and code to disable it when RO mode
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		SET MENU BAR:C67(3)
		InitChangeStack(1)
		utl_SetSpellandContextMenu
		
		If (Is new record:C668([Parameters:107]))
			OBJECT SET ENTERABLE:C238([Parameters:107]ParamCode:1; True:C214)
			OBJECT SET RGB COLORS:C628([Parameters:107]ParamCode:1; Col_paletteToRGB(Abs:C99(<>COLOR_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR([Parameters]ParamCode; <>COLOR_EDITABLE)
			
		Else 
			OBJECT SET ENTERABLE:C238([Parameters:107]ParamCode:1; False:C215)
			OBJECT SET RGB COLORS:C628([Parameters:107]ParamCode:1; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR([Parameters]ParamCode; <>COLOR_NOT_EDITABLE)
		End if 
		
		If (Read only state:C362(Current form table:C627->) & Not:C34(Is new record:C668(Current form table:C627->)))
			OBJECT SET ENABLED:C1123(*; "EditJson"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (Length:C16([Parameters:107]ParamCode:1)<=20)  //limitation on ActivityLog table
			FlushGrpChgs(1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		End if 
End case 