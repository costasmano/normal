If (False:C215)
	//[Cons Inspection];"ViewCslt Insp_LB".Variable8
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 17:00:10)
	Mods_2022_06
	//  `change button type to 3D button with separated menu - made button wider
	//  // enabled long click and alternate click in events
	//  // code to enable sending aquick report to excel
	//  // added help tip "Click for Quick Report editor ; click on arrow for more options."
End if 

C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388

Case of 
		
	: ($FormEvent_L=On Long Click:K2:37) | ($FormEvent_L=On Alternative Click:K2:36)
		C_TEXT:C284($menu_txt)
		$menu_txt:="Open Quick report editor;Run a Quick report file to Excel"
		C_LONGINT:C283($choice)
		$choice:=Pop up menu:C542($menu_txt)
		Case of 
			: ($choice=1)
				M_QuickReport
			: ($choice=2)
				C_BOOLEAN:C305($one; $many)
				GET AUTOMATIC RELATIONS:C899($one; $many)
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				
				QR_RunReportToExcel(Current form table:C627)
				C_TEXT:C284(GEN_SORTLISTCMD_txt)
				
				If (GEN_SORTLISTCMD_txt#"")
					EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
				End if 
				SET AUTOMATIC RELATIONS:C310($one; $many)
				
		End case 
	: ($FormEvent_L=On Clicked:K2:4)
		M_QuickReport
End case 

//End of script