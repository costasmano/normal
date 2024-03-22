If (False:C215)
	//Script: bzPrint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
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
				FORM SET OUTPUT:C54([Activity Log:59]; "Output")
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
						FORM SET OUTPUT:C54([Activity Log:59]; "Output")
					End if 
					
				Else 
					ALERT:C41("Nothing to print!")
				End if 
				
			: ($menuSelection_txt="QR")
				QR REPORT:C197([Activity Log:59]; Char:C90(1))
		End case 
End case 
