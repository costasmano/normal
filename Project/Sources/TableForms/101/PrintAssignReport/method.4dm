If (False:C215)
	//Form Method: [Contract_Assignment_Maintenance];"PrintAssignReport"
	// Modified by: costasmanousakis-(Designer)-(5/20/10 16:43:24)
	Mods_2010_05
	//  `Adjusted form dimensions, markers, and form object sizes to better fit the Project description 
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		If (vAssgnBalTLFDes<0)
			OBJECT SET RGB COLORS:C628(vAssgnBalTLFDes; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(vAssgnBalTLFDes; -(Red))
			OBJECT SET FONT STYLE:C166(vAssgnBalTLFDes; Bold:K14:2+Italic:K14:3)
		End if 
		If (vAssgnBalTLFConstr<0)
			OBJECT SET RGB COLORS:C628(vAssgnBalTLFConstr; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(vAssgnBalTLFConstr; -(Red))
			OBJECT SET FONT STYLE:C166(vAssgnBalTLFConstr; Bold:K14:2+Italic:K14:3)
		End if 
		If (vAssgnBalTLFTot<0)
			OBJECT SET RGB COLORS:C628(vAssgnBalTLFTot; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(vAssgnBalTLFTot; -(Red))
			OBJECT SET FONT STYLE:C166(vAssgnBalTLFTot; Bold:K14:2+Italic:K14:3)
		End if 
		If (vAssgnBalDE<0)
			OBJECT SET RGB COLORS:C628(vAssgnBalDE; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(vAssgnBalDE; -(Red))
			OBJECT SET FONT STYLE:C166(vAssgnBalDE; Bold:K14:2+Italic:K14:3)
		End if 
		If (vAssgnBalTotal<0)
			OBJECT SET RGB COLORS:C628(vAssgnBalTotal; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(vAssgnBalTotal; -(Red))
			OBJECT SET FONT STYLE:C166(vAssgnBalTotal; Bold:K14:2+Italic:K14:3)
		End if 
End case 