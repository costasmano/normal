If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(3/23/15 14:00:43)
	Mods_2015_03
	//  `Added
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If ((Application type:C494=4D Volume desktop:K5:2) & Not:C34(User in group:C338(Current user:C182; "Design Access Group")))
			OBJECT SET VISIBLE:C603(*; "bAncillary@"; False:C215)
		Else 
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		m_ListInventory
		
End case 

//End of script