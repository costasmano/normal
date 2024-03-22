If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/09, 12:07:23
	// ----------------------------------------------------
	// Method: Object Method: vTabRoutingPages
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
End if 
If (False:C215)
	Case of 
		: (Form event code:C388=On Load:K2:1)
			ARRAY LONGINT:C221(INSPFRZ_TabPages_aL; 7)
			INSPFRZ_TabPages_aL{1}:=1
			INSPFRZ_TabPages_aL{2}:=2
			INSPFRZ_TabPages_aL{3}:=2
			INSPFRZ_TabPages_aL{4}:=2
			INSPFRZ_TabPages_aL{5}:=2
			INSPFRZ_TabPages_aL{6}:=3
			INSPFRZ_TabPages_aL{7}:=4
			Self:C308->:=1
			
		: (Form event code:C388=On Clicked:K2:4)
			C_LONGINT:C283($pgNo_L)
			$pgNo_L:=Self:C308->
			C_BOOLEAN:C305($gotoPageElmt_b; $CurrPgElmt_b)
			$gotoPageElmt_b:=(INSPFRZ_TabPages_aL{$pgNo_L}=2)
			$CurrPgElmt_b:=(FORM Get current page:C276=2)
			
			FORM GOTO PAGE:C247(INSPFRZ_TabPages_aL{$pgNo_L})
			If ($CurrPgElmt_b)
				If (True:C214)
					If (Modified record:C314([ElementsSafety:29]))
						SAVE RECORD:C53([ElementsSafety:29])
						FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
					End if 
				End if 
				
			End if 
			
			If ($gotoPageElmt_b)
				
				GOTO SELECTED RECORD:C245([ElementsSafety:29]; ($pgNo_L-1))
				If (ut_LoadRecordInteractive(->[ElementsSafety:29]))
					If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
						BLOB TO VARIABLE:C533([ElementsSafety:29]ElmComments:23; FRZFieldTests_txt)
					Else 
						FRZFieldTests_txt:=""
					End if 
					
					FRZNotAppl_L:=Num:C11(f_Boolean2String([ElementsSafety:29]Crack:9; "10"))
					FRZNoProblem_L:=Num:C11([ElementsSafety:29]Rating:2)
					If (FRZNotAppl_L=1)
						OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; False:C215)
						OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_not_editable)
						OBJECT SET ENABLED:C1123(*; "DE FRZ@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					Else 
						OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; True:C214)
						OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_editable)
						OBJECT SET ENABLED:C1123(*; "DE FRZ@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
						If (FRZNoProblem_L=1)
							OBJECT SET ENTERABLE:C238(*; "DE FRZ Field@"; False:C215)
							OBJECT SET RGB COLORS:C628(*; "DE FRZ Field@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ Field@"; <>Color_not_editable)
							OBJECT SET ENABLED:C1123(*; "DE FRZ Field@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
							OBJECT SET ENABLED:C1123(*; "DE FRZ NoAct@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						Else 
							OBJECT SET ENTERABLE:C238(*; "DE FRZ Field@"; True:C214)
							OBJECT SET RGB COLORS:C628(*; "DE FRZ Field@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ Field@"; <>Color_editable)
							OBJECT SET ENABLED:C1123(*; "DE FRZ Field@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
							OBJECT SET ENABLED:C1123(*; "DE FRZ NoAct@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
						End if 
					End if 
					FRZNoAction_L:=Num:C11([ElementsSafety:29]Deficiency:3)
				Else 
					ALERT:C41("Read write error Loading part "+String:C10(($pgNo_L-1))+" of the inspection")
				End if 
			Else 
				UNLOAD RECORD:C212([ElementsSafety:29])
			End if 
			
	End case 
End if 
