If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/27/09, 15:57:19
	// ----------------------------------------------------
	// Method: Form Method: FreezeThawInp_1
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: Costas Manousakis-(Designer)-(5/23/12 16:13:04)
	Mods_2012_05
	//  `Adjusted size and location of objects
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Is new record:C668([ElementsSafety:29]))
			ALERT:C41("Cannot open a Blank Freeze thaw item")
			CANCEL:C270
		Else 
			InitChangeStack(2)
			C_TEXT:C284(FRZ_ELEMENTDESC_TXT)
			FRZ_ELEMENTDESC_TXT:=INSP_FRZElmtDesc
			
			If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
				BLOB TO VARIABLE:C533([ElementsSafety:29]ElmComments:23; FRZFieldTests_txt)
			Else 
				FRZFieldTests_txt:=""
			End if 
			C_LONGINT:C283(FRZ_Problem_Yes; FRZ_Problem_No)
			FRZ_Problem_Yes:=0
			FRZ_Problem_No:=0
			
			FRZNotAppl_L:=Num:C11(f_Boolean2String([ElementsSafety:29]Crack:9; "10"))
			If (FRZNotAppl_L=0)
				Case of 
					: ([ElementsSafety:29]Rating:2="2")
						FRZ_Problem_Yes:=1
					: ([ElementsSafety:29]Rating:2="1")
						FRZ_Problem_No:=1
				End case 
			End if 
			
			FRZNoProblem_L:=Num:C11([ElementsSafety:29]Rating:2)
			FRZNoAction_L:=Num:C11([ElementsSafety:29]Deficiency:3)
			If (vbInspectionLocked)
				OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_not_editable)
				OBJECT SET ENABLED:C1123(*; "DE FRZ@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				
			Else 
				If (FRZNotAppl_L=1)
					OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_not_editable)
					OBJECT SET ENABLED:C1123(*; "DE FRZ@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				Else 
					OBJECT SET ENTERABLE:C238(*; "DE FRZ Field@"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_editable)
					OBJECT SET ENABLED:C1123(*; "DE FRZ@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					If (FRZ_Problem_No=1)
						OBJECT SET ENTERABLE:C238(*; "DE FRZ FieldAction@"; False:C215)
						OBJECT SET RGB COLORS:C628(*; "DE FRZ FieldAction@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ FieldAction@"; <>Color_not_editable)
					End if 
				End if 
			End if 
			
		End if 
		
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
		
End case 