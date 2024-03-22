If (False:C215)
	//[Town Address];"View Town Address_LB".Variable8
	Mods_2020_07  //Added use of current form name to set output form, so if we are in Listbox we should be all set
	//Modified by: CJ (7/16/20 16:29:50)
	// Modified by: Costas Manousakis-(Designer)-(2022-04-06 17:10:26)
	Mods_2022_04
	//  `added option to open quick report or print addresses
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 17:54:45)
	Mods_2022_06
	//  `added option to send a quick report to excel
End if 

C_TEXT:C284($menu)
$menu:=".. Choose option;Open Quick Report;Print Town addresses;Generate a quick report to Excel"
C_LONGINT:C283($choice)
//$choice:=Pop up menu($menu;($l+$r)/2;($t+$b)/2)
$choice:=Pop up menu:C542($menu)

Case of 
	: ($choice=2)
		QR REPORT:C197(Current form table:C627->; Char:C90(1))
	: ($choice=3)
		
		//_O_PAGE SETUP([Town Address]; "Town Address Print")
		FORM SET OUTPUT:C54([Town Address:78]; "Town Address Print")
		
		If (<>ShowPrint)
			
			PRINT SETTINGS:C106
			
		End if 
		
		If (Ok=1)
			//check to see if canceled from Print Settings
			FORM SET OUTPUT:C54([Town Address:78]; "Town Address Print")
			PRINT SELECTION:C60([Town Address:78]; *)
			FORM SET OUTPUT:C54([Town Address:78]; Current form name:C1298)
			
		End if 
		
	: ($choice=3)
		QR_RunReportToExcel(Current form table:C627)
		
End case 