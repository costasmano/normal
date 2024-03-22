If (False:C215)
	Mods_2005_CM03
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(11/1/09 08:48:24)
	Mods_2009_10("MASSDOT")
	// change the logo.
	// Modified by: Costas Manousakis-(Designer)-(5/15/18 17:18:34)
	Mods_2018_05
	//  `re-arranged objects; moved object code from SRCreatedBy_txt into here
	// Modified by: Costas Manousakis-(Designer)-(2022-10-03 17:35:32)
	Mods_2022_10_bug
	//  `adjusted column widths, headers, header ht and hor. resizing option of listbox
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ORDER BY:C49([Status Report:69]; [Status Report:69]Date_Created:1; <; [Status Report:69]Time_Created:134; <)
		If (Current user:C182="Designer")
			OBJECT SET ENABLED:C1123(bzAdd; True:C214)  // **replaced _ o _ENABLE BUTTON(bzAdd)
			OBJECT SET ENABLED:C1123(bzDelete; True:C214)  // **replaced _ o _ENABLE BUTTON(bzDelete)
		Else 
			OBJECT SET ENABLED:C1123(bzDelete; False:C215)  // **replaced _ o _DISABLE BUTTON(bzDelete)
			If (User in group:C338(Current user:C182; "ReadWrite"))
				OBJECT SET ENABLED:C1123(bzAdd; True:C214)  // **replaced _ o _ENABLE BUTTON(bzAdd)
			Else 
				OBJECT SET ENABLED:C1123(bzAdd; False:C215)  // **replaced _ o _DISABLE BUTTON(bzAdd)
			End if 
			
		End if 
		C_TEXT:C284(SRCreatedBy_txt)
		
	: (Form event code:C388=On Display Detail:K2:22)
		SRCreatedBy_txt:=STATREP_ReportType
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 