//Object method to call quickreport
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2022-05-27 18:56:49)
	Mods_2022_05
	//  `
	//changed button to 3D Button custom with a submenu; adjusted widht and rearranged other buttons to fit
	// added code to popup a menu with choices to open QR editor or execute a quick report file to excel
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 15:57:39)
	Mods_2022_06
	//  `added On Alternative Click and enabled On Alternative Click in the object events
	//  `added help tip "Quick Report editor ; click on arrow for more options."
	
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