//FORM Method: EditPrefs
//Description
// Edit Preferences
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/19/16, 10:51:53
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
	// Modified by: Costas Manousakis-(Designer)-(2022-04-06 13:10:11)
	Mods_2022_04
	//  `listbox not sortable
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(v_57_001_atxt; 0)  //array to edit
		ARRAY TEXT:C222(v_57_003_atxt; 0)  //array to display as current active values
		ARRAY TEXT:C222(v_57_001_atxt; Size of array:C274(<>PrefNames_atxt))
		ARRAY TEXT:C222(v_57_003_atxt; Size of array:C274(<>PrefNames_atxt))
		
		C_TEXT:C284($userPrefXML_txt; $PrefElmt_txt)
		//save current prefs in a dom 
		$userPrefXML_txt:=DOM Create XML Ref:C861(<>pref_Root_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
			$PrefElmt_txt:=DOM Create XML element:C865($userPrefXML_txt; <>PrefNames_atxt{$loop_L})
			DOM SET XML ELEMENT VALUE:C868($PrefElmt_txt; <>PrefVariables_aptr{$loop_L}->)
		End for 
		
		//now parse the dom and save into text
		For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
			$PrefElmt_txt:=DOM Find XML element:C864($userPrefXML_txt; <>pref_Root_txt+"/"+<>PrefNames_atxt{$loop_L})
			If (Ok=1)
				DOM GET XML ELEMENT VALUE:C731($PrefElmt_txt; v_57_001_atxt{$loop_L})
			End if 
		End for 
		COPY ARRAY:C226(v_57_001_atxt; v_57_003_atxt)
		
		DOM CLOSE XML:C722($userPrefXML_txt)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End EditPrefs