//Method: SelectResources.Button3
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 11:56:38
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
If (Resource_FolderStructure("Check"; v_1_150_txt))
	
Else 
	CONFIRM:C162("Part of the folder structure "+v_1_150_txt+" does not exist."; "Create"; "Do NOT create")
	If (OK=1)
		If (Resource_FolderStructure("Create"; v_1_150_txt))
		Else 
			ALERT:C41("An Error occurred folder structure couild not be created")
			
		End if 
		
		
		
	End if 
End if 
//End SelectResources.Button3