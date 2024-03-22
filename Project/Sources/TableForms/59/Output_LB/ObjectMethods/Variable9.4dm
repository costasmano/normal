If (False:C215)
	//[Activity Log];"Output_LB".Variable9
	
	Mods_2020_07  //Added use of current form name to set output form, so if we are in Listbox we should be all set
	//Modified by: CJ (7/16/20 16:29:50)
	// Modified by: Costas Manousakis-(Designer)-(2022-06-17 11:13:30)
	Mods_2022_06
	//  `added option to convert a Quick report to Excel
End if 

OK:=1

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Records in selection:C76([Activity Log:59])>0)
			
			If (Records in selection:C76([Activity Log:59])>70)
				CONFIRM:C162("Do you want to print "+String:C10(Records in selection:C76([Activity Log:59]))+" records of Activity Log table?"; "Print")
			End if 
			If (OK=1)
				G_PrintOptions(2)  //landscape
				FORM SET OUTPUT:C54([Activity Log:59]; "Print")
				PRINT SELECTION:C60([Activity Log:59])
				FORM SET OUTPUT:C54([Activity Log:59]; Current form name:C1298)
			End if 
			
		Else 
			ALERT:C41("Nothing to print!")
		End if 
		
	: (Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37)
		C_TEXT:C284($menu_ref_txt; $menuSelection_txt)
		ARRAY TEXT:C222($optionCodes_atxt; 0)
		ARRAY TEXT:C222($Options_atxt; 0)
		APPEND TO ARRAY:C911($optionCodes_atxt; "Print")
		APPEND TO ARRAY:C911($Options_atxt; "Print Report")
		APPEND TO ARRAY:C911($optionCodes_atxt; "QR")
		APPEND TO ARRAY:C911($Options_atxt; "Quick Report")
		APPEND TO ARRAY:C911($optionCodes_atxt; "QR to Excel")
		APPEND TO ARRAY:C911($Options_atxt; "Quick Report to Excel")
		
		$menu_ref_txt:=MENU_BuildMenuFromArrays(->$Options_atxt; ->$optionCodes_atxt; "\\")
		
		$menuSelection_txt:=Dynamic pop up menu:C1006($menu_ref_txt)
		RELEASE MENU:C978($menu_ref_txt)
		
		Case of 
			: ($menuSelection_txt="Print")
				
				If (Records in selection:C76([Activity Log:59])>0)
					
					If (Records in selection:C76([Activity Log:59])>70)
						CONFIRM:C162("Do you want to print "+String:C10(Records in selection:C76([Activity Log:59]))+" records of Activity Log table?"; "Print")
					End if 
					If (OK=1)
						G_PrintOptions(2)  //landscape
						FORM SET OUTPUT:C54([Activity Log:59]; "Print")
						PRINT SELECTION:C60([Activity Log:59])
						FORM SET OUTPUT:C54([Activity Log:59]; Current form name:C1298)
					End if 
					
				Else 
					ALERT:C41("Nothing to print!")
				End if 
				
			: ($menuSelection_txt="QR")
				QR REPORT:C197([Activity Log:59]; Char:C90(1))
				
			: ($menuSelection_txt="QR to Excel")
				QR_RunReportToExcel(Current form table:C627)
		End case 
End case 
