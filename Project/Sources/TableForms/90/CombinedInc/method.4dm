If (False:C215)
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 11:11:11)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/22/2006 14:14:44)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ORDER BY:C49([Combined Inspections:90]InspDate:4; >)
		C_TEXT:C284(vsListInspTitle)
		C_TEXT:C284(vsInc_Insp_I58; vsInc_Insp_I59; vsInc_Insp_I60; vsInc_Insp_I61; vsInc_Insp_I62)  // Command Replaced was o_C_STRING length was 1
		
	: (Form event code:C388=On Display Detail:K2:22)
		vsListInspTitle:=[Inspection Type:31]Description:2
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
		If (INSP_IsInspRoutine_b)
			C_BOOLEAN:C305($vbCombined)
			If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
				$vbCombined:=[Inspections:27]InspRtnSpcMemFlag:209
			Else 
				$vbCombined:=(G_Insp_CountSpMs>0)
			End if 
			If ($vbCombined)
				vsListInspTitle:=vsListInspTitle+" & Spec.Mem."
			End if 
			
		End if 
		
		vPicButtonReview:=[Inspections:27]InspReviewed:12
		vPicButtonAppr:=[Inspections:27]InspApproved:167
		
		vsInc_Insp_I58:=[Inspections:27]Item 58:79
		vsInc_Insp_I59:=[Inspections:27]Item 59:80
		
		If ([Inspections:27]Insp Type:6="DV@")
			vsInc_Insp_I60:=[Inspections:27]Item 60 UW:66
			vsInc_Insp_I61:=[Inspections:27]Item 61 UW:72
			vsInc_Insp_I62:=[Inspections:27]Item 62 UW:165
		Else 
			vsInc_Insp_I60:=[Inspections:27]Item 60:81
			vsInc_Insp_I61:=[Inspections:27]Item 61:82
			vsInc_Insp_I62:=[Inspections:27]Item 62:113
		End if 
		Case of 
			: ([Inspections:27]Insp Type:6="FCR")
				vsInc_Insp_I58:=""
				vsInc_Insp_I61:=""
				vsInc_Insp_I62:=""
			: ([Inspections:27]Insp Type:6="CMI")
				vsInc_Insp_I61:=""
		End case 
		
End case 