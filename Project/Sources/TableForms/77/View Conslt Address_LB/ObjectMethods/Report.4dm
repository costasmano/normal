If (False:C215)
	//[Conslt Address];"View Conslt Address_LB".Report
	
	// Modified by: Costas Manousakis-(Designer)-(4/15/20 13:01:47)
	Mods_2020_04
	//  `added alt click option to bring up quick report editor
	Mods_2020_07  //Added use of current form name to set output form, so if we are in Listbox we should be all set
	//Modified by: CJ (7/16/20 16:29:50)
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 17:48:22)
	Mods_2022_06
	//  // enabled long click and alternate click in events
	//  // code to enable sending aquick report to excel
	//  // added help tip "Click to print address forms ; click on arrow for more options."
End if 


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		//_O_PAGE SETUP([Conslt Address]; "Conslt Address Print")
		FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		
		If (Ok=1)  //check to see if canceled from Print Settings
			FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
			PRINT SELECTION:C60([Conslt Address:77]; *)
			FORM SET OUTPUT:C54([Conslt Address:77]; Current form name:C1298)
		End if 
		
		
	: (Form event code:C388=On Alternative Click:K2:36)
		ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
		ARRAY TEXT:C222($MenuSelected_atxt; 0)
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Quick Report Editor")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "1")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Print stored Report")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "2")
		APPEND TO ARRAY:C911($MenuDiscriptor_atxt; "Generate a Quick report to Excel")
		APPEND TO ARRAY:C911($MenuSelected_atxt; "3")
		C_TEXT:C284($menuref_txt; $selected_txt)
		$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
		$selected_txt:=Dynamic pop up menu:C1006($menuref_txt)
		RELEASE MENU:C978($menuref_txt)
		
		Case of 
			: ($selected_txt="1")
				COPY NAMED SELECTION:C331(Current form table:C627->; "PREQR")
				QR REPORT:C197(Current form table:C627->; Char:C90(1))
				USE NAMED SELECTION:C332("PREQR")
				CLEAR NAMED SELECTION:C333("PREQR")
			: ($selected_txt="2")
				
				//_O_PAGE SETUP([Conslt Address]; "Conslt Address Print")
				FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
				If (<>ShowPrint)
					PRINT SETTINGS:C106
				End if 
				
				If (Ok=1)  //check to see if canceled from Print Settings
					FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
					PRINT SELECTION:C60([Conslt Address:77]; *)
					FORM SET OUTPUT:C54([Conslt Address:77]; Current form name:C1298)
				End if 
				
			: ($selected_txt="3")
				QR_RunReportToExcel(Current form table:C627)
				
		End case 
		
End case 
