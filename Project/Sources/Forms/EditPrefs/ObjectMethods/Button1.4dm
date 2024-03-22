//Method: EditPrefs.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/18/16, 12:59:05
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
End if 
//
//save mod prefs in a dom 
C_TEXT:C284($userPrefXML_txt; $PrefElmt_txt)
$userPrefXML_txt:=DOM Create XML Ref:C861(<>pref_Root_txt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
	$PrefElmt_txt:=DOM Create XML element:C865($userPrefXML_txt; <>PrefNames_atxt{$loop_L})
	DOM SET XML ELEMENT VALUE:C868($PrefElmt_txt; v_57_001_atxt{$loop_L})
End for 

//now parse the dom and save into the pref variables
For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
	$PrefElmt_txt:=DOM Find XML element:C864($userPrefXML_txt; <>pref_Root_txt+"/"+<>PrefNames_atxt{$loop_L})
	If (Ok=1)
		DOM GET XML ELEMENT VALUE:C731($PrefElmt_txt; <>PrefVariables_aptr{$loop_L}->)
		//these two steps convert from the var back to text
		DOM SET XML ELEMENT VALUE:C868($PrefElmt_txt; <>PrefVariables_aptr{$loop_L}->)
		DOM GET XML ELEMENT VALUE:C731($PrefElmt_txt; v_57_001_atxt{$loop_L})
		
	End if 
End for 
COPY ARRAY:C226(v_57_001_atxt; v_57_003_atxt)

DOM CLOSE XML:C722($userPrefXML_txt)


//End EditPrefs.Button1