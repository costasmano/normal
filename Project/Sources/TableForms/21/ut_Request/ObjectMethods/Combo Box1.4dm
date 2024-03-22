If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:35:29)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(6/24/08 13:56:27)
	Mods_2008_CM_5404  //Allow adding of selected value to the request value.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Index_L)
		$Index_L:=Self:C308->
		If (Self:C308->=0)
			
		Else 
			C_TEXT:C284($Selected_txt)
			$Selected_txt:=Self:C308->{$Index_L}
			If (Position:C15($Selected_txt; ut_Request_Value_txt)>0)
				//Already there - do nothing
			Else 
				If (ut_Request_Value_txt#"")
					CONFIRM:C162("Add <"+$Selected_txt+"> to the current entry, or Replace with "+$Selected_txt+" ?"; "Add"; "Replace")
					If (OK=1)
						ut_Request_Value_txt:=ut_Request_Value_txt+","+Self:C308->{$Index_L}
					Else 
						ut_Request_Value_txt:=Self:C308->{$Index_L}
					End if 
				Else 
					ut_Request_Value_txt:=Self:C308->{$Index_L}
				End if 
				
			End if 
			
		End if 
		
End case 
