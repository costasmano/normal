If (False:C215)
	//[PERS_Groups];"PG_Output_LB".bReport
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 18:30:12)
	Mods_2022_06
	//  `change button type to 3D button with separated menu - made button wider
	//  // enabled long click and alternate click in events
	//  // code to enable sending a quick report to excel
	//  // added help tip "Quick Report editor; click on arrow for more options."
	
End if 
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_BOOLEAN:C305($one; $many)
GET AUTOMATIC RELATIONS:C899($one; $many)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)

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

SET AUTOMATIC RELATIONS:C310($one; $many)
