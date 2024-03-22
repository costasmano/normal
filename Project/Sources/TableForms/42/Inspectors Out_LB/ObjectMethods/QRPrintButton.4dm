//Object method to call quickreport
If (False:C215)
	//[Personnel];"Inspectors Out_LB".QRPrintButton
	Mods_2007_CM06
	
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 18:22:39)
	Mods_2022_06
	//  `change button type to 3D button with separated menu - made button wider
	//  // enabled long click and alternate click in events
	//  // code to enable sending a quick report to excel
	//  // added help tip "Quick Report editor; click on arrow for more options."
	// Modified by: Costas Manousakis-(Designer)-(2023-04-06 19:29:05)
	Mods_2023_04
	//  `set table to Read only - running a Quick report left the last record locked
End if 
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_BOOLEAN:C305($one; $many)
GET AUTOMATIC RELATIONS:C899($one; $many)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
C_BOOLEAN:C305($readStatus_b)
$readStatus_b:=Read only state:C362(Current form table:C627->)
READ ONLY:C145(Current form table:C627->)

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


If (Not:C34($readStatus_b))
	READ WRITE:C146(Current form table:C627->)
End if 

SET AUTOMATIC RELATIONS:C310($one; $many)
