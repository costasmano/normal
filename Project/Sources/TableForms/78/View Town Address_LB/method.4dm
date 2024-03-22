If (False:C215)
	//Form Method: [Town Address]View Town Address 
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:41:38)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 11:22:10)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/23/10 12:02:48)
	Mods_2010_08
	//modified Dist Pulldown - Added Dist 6 to the list
	// Modified by: costasmanousakis-(Designer)-(2/22/11 11:55:46)
	Mods_2011_02
	//  `Deleted S2_field object that was not pointing to a valide field. Was found in check in v11.
	// Modified by: Costas Manousakis-(Designer)-(4/13/16 11:59:04)
	Mods_2016_04_bug
	//  `disable the add button except on the Boston server and with write access OR design user
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 14:29:06)
	Mods_2019_03
	//  `resized and moved ojects to make them larger  
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at Load ; enable on resize in form events; redraw LB on Resize
	
End if 
C_TEXT:C284(vContact)  // Command Replaced was o_C_STRING length was 150
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "AddTownAddress"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET ENABLED:C1123(*; "AddTownAddress"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			If (Application type:C494=4D Remote mode:K5:5)
				If (Structure file:C489="MHD BMS.4DC")
					If (Read only state:C362([Town Address:78]))
					Else 
						OBJECT SET ENABLED:C1123(*; "AddTownAddress"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					End if 
				End if 
			End if 
		End if 
		
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: (Form event code:C388=On Display Detail:K2:22)
		vContact:=[Town Address:78]ContactFName:8+" "+[Town Address:78]ContactMName:10+" "+[Town Address:78]ContactLName:9+", "+[Town Address:78]ContactTitle:11
		
	: (Form event code:C388=On Resize:K2:27)
		C_POINTER:C301($LB_ptr)
		$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "TownAddressLB")
		REDRAW:C174($LB_ptr->)
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
End case 