If (False:C215)
	//Object Method: [Conslt Address].Conslt Address In.Button1 
	// Modified by: costasmanousakis-(Designer)-(11/9/07 16:51:30)
	Mods_2007_CM12_5302
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 14:26:44)
	Mods_2013_10
	//  `Allow also users in "BMS Admin" group to edit the company name
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group") | User in group:C338(<>CurrentUser_Name; "BMS Admin"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET ENTERABLE:C238([Conslt Address:77]ConsltName:2; True:C214)
		OBJECT SET RGB COLORS:C628([Conslt Address:77]ConsltName:2; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Conslt Address]ConsltName; <>Color_Editable)
		GOTO OBJECT:C206([Conslt Address:77]ConsltName:2)
		POST KEY:C465(Tab key:K12:28)
		POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
End case 