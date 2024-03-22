C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
		
	: ($FormEvent_L=On Alternative Click:K2:36)
		C_TEXT:C284($menu)
		$menu:="Quick report editor;Run a Quick report to excel"
		C_LONGINT:C283($choice)
		$choice:=Pop up menu:C542($menu)
		
		Case of 
			: ($choice=1)
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
				
			: ($choice=2)
				QR_RunReportToExcel
		End case 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		QR REPORT:C197(Current form table:C627->; Char:C90(1))
		
End case 