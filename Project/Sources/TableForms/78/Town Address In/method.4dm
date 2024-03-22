If (False:C215)
	//Form Method: [Town Address];"Town Address In" 
	// Modified by: costasmanousakis-(Designer)-(4/13/2006 12:15:59)
	Mods_2006_CM04
	//C_STRING(80;vCName)
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 11:22:25)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(10/22/14 15:44:18)
	Mods_2014_10
	//  `Added ability to have multiple lines for Addressed to and Street address.
	//  `can show up to 3 lines each. however not clear if there are more - also cannot enter a 
	//  `line feed in alpha fields.
	// Modified by: Costas Manousakis-(Designer)-(5/13/20 11:26:07)
	Mods_2020_05
	//  `added drop down for field [Town Address]TownBDEPTPrefix - adjusted location of objects and form size limits
	//  `removed the template form and copied all buttons - adjusted appearance, object properties....
	//  `added two buttons to add lines to the Addressed to and Street fields
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Read only state:C362([Town Address:78]))
			If (Is new record:C668([Town Address:78]))
				CANCEL:C270
			End if 
			OBJECT SET RGB COLORS:C628(*; "Field@"; Col_paletteToRGB(Abs:C99(<>Color_not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Field@"; <>Color_not_Editable)
		Else 
			InitChangeStack(1)
			If (Is new record:C668([Town Address:78]))
				Inc_Sequence("TownAddress"; ->[Town Address:78]TownAddressID:1)
			End if 
		End if 
		ARRAY TEXT:C222(v_2_001_atxt; 0)
		ARRAY TEXT:C222(v_2_002_atxt; 0)
		Begin SQL
			select 
			[Town Data].[BDEPT Prefix]
			,concat([Town Data].[Town Name], concat(' - ',[Town Data].[BDEPT Prefix]))
			from [Town Data]
			order by [Town Data].[Town Name]
			into :v_2_002_atxt, : v_2_001_atxt ;
		End SQL
		POPUPMENUC(->v_2_001_atxt; ->v_2_002_atxt; ->[Town Address:78]TownBDEPTPrefix:17)
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 1)
End case 