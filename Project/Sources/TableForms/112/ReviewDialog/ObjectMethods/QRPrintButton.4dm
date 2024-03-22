If (False:C215)
	//[InventoryPhotoInsp];"ReviewDialog".QRPrintButton
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 16:36:37)
	Mods_2022_06
	//  `change button type to 3D button with separated menu - made button wider
	//  // enabled long click and alternate click in events
	//  // code to enable sending aquick report to excel
	//  // added help tip
	
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
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
			: ($choice=2)
				QR_RunReportToExcel(Current form table:C627)
				
		End case 
	: ($FormEvent_L=On Clicked:K2:4)
		QR REPORT:C197(Current form table:C627->; Char:C90(1))
End case 
