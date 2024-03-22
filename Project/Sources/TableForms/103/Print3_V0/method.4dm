If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/02/05, 15:17:36
	// ----------------------------------------------------
	// Method: Form Method: Print3
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 15:17:41)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:19:25)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(12/5/07 09:58:35)
	Mods_2007_CM_5401  //Fixed the italicizing by naming correcttly the Item and CatSum@ objects
	//  `Fixed the format of Item_s* vars
	//  `To address the display of sub-items:
	//  `  `adjust font size for neg values in item_s*
	// Modified by: costasmanousakis-(Designer)-(7/31/08 19:10:53)
	Mods_2008_CM_5404  //Copied to Server on : 08/01/08, 15:53:48
	//adjusted form objects size,location, and some markers added code
	//to color lines according to content...
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:05:46)
	Mods_2009_CM_5404  // ("WKHRMODS")
	//Created this as a copy of the original print3 form for work estimates 
	//with version=0
End if 

Case of 
	: (Form event code:C388=On Header:K2:17)
		If ([Work_Estimate:103]AddendumNo:29=0)
			OBJECT SET VISIBLE:C603(*; "Addend@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Addend@"; True:C214)
		End if 
	: (Form event code:C388=On Printing Break:K2:19)
		If (Position:C15("--->"; vWKHR_Add_SubReview)>0)
			OBJECT SET FONT STYLE:C166(*; "CatSum@"; Italic:K14:3)
		Else 
			OBJECT SET FONT STYLE:C166(*; "CatSum@"; Plain:K14:1)
		End if 
	: (Form event code:C388=On Printing Detail:K2:18)
		If ([Work_Estimate:103]AddendumNo:29=0)
			OBJECT SET VISIBLE:C603(*; "Addend@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Addend@"; True:C214)
		End if 
		If (Position:C15("--->"; Item_Title)>0)
			OBJECT SET FONT STYLE:C166(*; "Item_@"; Italic:K14:3)
		Else 
			OBJECT SET FONT STYLE:C166(*; "Item_@"; Plain:K14:1)
		End if 
		C_LONGINT:C283($offEstbColor_L; $ReviewColor_L; $subItmColor_L; $DefColor_L)
		$offEstbColor_L:=-(Black:K11:16+(256*(5+(15*16))))
		$ReviewColor_L:=-(Black:K11:16+(256*(1+(14*16))))
		$subItmColor_L:=-(Black:K11:16+(256*(3+(10*16))))
		$DefColor_L:=-(Black:K11:16+(256*White:K11:1))
		Case of 
			: (Position:C15("--->Office Estimate"; Item_Title)>0)
				OBJECT SET RGB COLORS:C628(*; "Item_@"; Col_paletteToRGB(Abs:C99($offEstbColor_L)%256); Col_paletteToRGB(Abs:C99($offEstbColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "Item_@"; $offEstbColor_L)
			: (Position:C15("--->Reviewer"; Item_Title)>0)
				OBJECT SET RGB COLORS:C628(*; "Item_@"; Col_paletteToRGB(Abs:C99($ReviewColor_L)%256); Col_paletteToRGB(Abs:C99($ReviewColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "Item_@"; $ReviewColor_L)
			: (Item_s6<0)
				OBJECT SET RGB COLORS:C628(*; "Item_@"; Col_paletteToRGB(Abs:C99($subItmColor_L)%256); Col_paletteToRGB(Abs:C99($subItmColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "Item_@"; $subItmColor_L)
			Else 
				OBJECT SET RGB COLORS:C628(*; "Item_@"; Col_paletteToRGB(Abs:C99($DefColor_L)%256); Col_paletteToRGB(Abs:C99($DefColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "Item_@"; $DefColor_L)
		End case 
		
		If (Position:C15("--->"; vWKHR_Add_SubReview)>0)
			OBJECT SET FONT STYLE:C166(*; "CatSum@"; Italic:K14:3)
		Else 
			OBJECT SET FONT STYLE:C166(*; "CatSum@"; Plain:K14:1)
		End if 
		Case of 
			: (Position:C15("--->Office Estimate"; vWKHR_Add_SubReview)>0)
				OBJECT SET RGB COLORS:C628(*; "CatSum@"; Col_paletteToRGB(Abs:C99($offEstbColor_L)%256); Col_paletteToRGB(Abs:C99($offEstbColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "CatSum@"; $offEstbColor_L)
			: (Position:C15("--->Reviewer"; vWKHR_Add_SubReview)>0)
				OBJECT SET RGB COLORS:C628(*; "CatSum@"; Col_paletteToRGB(Abs:C99($ReviewColor_L)%256); Col_paletteToRGB(Abs:C99($ReviewColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "CatSum@"; $ReviewColor_L)
			Else 
				OBJECT SET RGB COLORS:C628(*; "CatSum@"; Col_paletteToRGB(Abs:C99($DefColor_L)%256); Col_paletteToRGB(Abs:C99($DefColor_L)\256))  // **Replaced o OBJECT SET COLOR(*; "CatSum@"; $DefColor_L)
		End case 
		
		If (Item_s6<0)
			OBJECT SET FONT SIZE:C165(*; "Item_@"; 8)
			OBJECT MOVE:C664(*; "Item_@"; 0; 2; 0; -2)
			OBJECT MOVE:C664(*; "Item_Title@"; 6; 0; -6; 0)
			
		Else 
			OBJECT SET FONT SIZE:C165(*; "Item_@"; 9)
		End if 
		
End case 