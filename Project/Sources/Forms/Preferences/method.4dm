If (False:C215)
	//Form Method: "Preferences" 
	// Modified by: Costas Manousakis-(Designer)-(5/14/12 15:44:22)
	Mods_2012_05
	//  `Added User_SMTP_Server box; enabled mouse enter mouse leave; Added Apply and Save button
	// Modified by: Costas Manousakis-(Designer)-(8/31/15 15:53:53)
	Mods_2015_09
	//  `Added CBHideLabel for ◊pref_TruckPost_NOL - visible only for designer or if above v11 version
	//  `Moved form to Project Forms
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 14:59:55)
	Mods_2016_10
	//  `Added CBUseOriginalWR for ◊pref_New4DWR
	// Modified by: Costas Manousakis-(Designer)-(1/08/20 12:54:30)
	Mods_2020_01_bug
	//  `added EmailMethod object and obj method
End if 

//LO:[Dialogs];"Preferences"
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (<>ShowPrint=True:C214)
			CBShowPrint:=1
		Else 
			CBShowPrint:=0
		End if 
		If (<>pref_TruckPost_NOL)
			CBHideLabel:=1
		Else 
			CBHideLabel:=0
		End if 
		
		If (<>pref_New4DWR)
			CBUseOriginalWR:=0
		Else 
			CBUseOriginalWR:=1
		End if 
		
		If ((Application version:C493>"1199") | User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(*; "SVG_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "SVG_@"; False:C215)
		End if 
		
End case 