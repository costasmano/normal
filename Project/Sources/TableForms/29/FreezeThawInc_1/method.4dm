If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/27/09, 15:57:45
	// ----------------------------------------------------
	// Method: Form Method: FreezeThawInc_1
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: Costas Manousakis-(Designer)-(5/6/19 10:04:58)
	Mods_2019_05
	//  `made elem desc non-transparent and grey background
End if 

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(FRZ_ELEMENTDESC_TXT)
		FRZ_ELEMENTDESC_TXT:=INSP_FRZElmtDesc
		If (False:C215)
			Case of 
				: ([ElementsSafety:29]ElementNo:1=41)
					FRZ_ELEMENTDESC_TXT:="Deck (Underside) / Arch Ring"
				: ([ElementsSafety:29]ElementNo:1=42)
					FRZ_ELEMENTDESC_TXT:="Beams and Diaphragms"
				: ([ElementsSafety:29]ElementNo:1=43)
					FRZ_ELEMENTDESC_TXT:="Concrete Piers / Pier Caps / Columns / Abutments"
				: ([ElementsSafety:29]ElementNo:1=44)
					FRZ_ELEMENTDESC_TXT:="Others (i.e. Parapets, Haunches, Spandrel Walls, etc.)"
				Else 
					FRZ_ELEMENTDESC_TXT:=""
			End case 
			
		End if 
	: (Form event code:C388=On Validate:K2:3)
		
End case 