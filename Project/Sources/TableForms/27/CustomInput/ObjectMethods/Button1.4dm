//Method: Object Method: [Inspections].CustomInput.Button1
//Description
//  ` enable editing of inspection type
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/29/13, 09:42:24
	// ----------------------------------------------------
	//Created : 
	Mods_2013_07
End if 
//
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET RGB COLORS:C628([Inspections:27]Insp Type:6; Col_paletteToRGB(Abs:C99(-(Black:K11:16+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR([Inspections]Insp Type; -(Black+(256*White)))
		OBJECT SET ENTERABLE:C238([Inspections:27]Insp Type:6; True:C214)
		GOTO OBJECT:C206([Inspections:27]Insp Type:6)
End case 

//End Object Method: [Inspections].CustomInput.Button1