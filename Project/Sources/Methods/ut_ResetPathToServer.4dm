//%attributes = {"invisible":true}
//Method: ut_ResetPathToServer
//Description
// Reset the path to Server "server_path" in "EnginedServer.4Dlink"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/28/19, 11:28:24
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03_bug
End if 
//
If (Not:C34(Is compiled mode:C492))
Else 
	If (Application type:C494=4D Remote mode:K5:5)
		C_TEXT:C284($PathToEngineLink_txt; $Attribute_txt; $xml_txt; $elemref_txt)
		If (Folder separator:K24:12=":")  //on a mac
			ARRAY TEXT:C222($Selected_atxt; 0)
			If (Not:C34(Is compiled mode:C492))
				$PathToEngineLink_txt:=Select document:C905(""; ""; "Select 4DLink File to test"; Package selection:K24:9; $Selected_atxt)
				$PathToEngineLink_txt:=$Selected_atxt{1}+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12
			Else 
				//need folder separator for Application file
				$PathToEngineLink_txt:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Database"+Folder separator:K24:12
			End if 
		Else 
			ARRAY TEXT:C222($Selected_atxt; 0)
			If (Not:C34(Is compiled mode:C492))
				$PathToEngineLink_txt:=Select document:C905(""; ""; "Select .EXE"; Multiple files:K24:7; $Selected_atxt)
				$PathToEngineLink_txt:=$Selected_atxt{1}
				$PathToEngineLink_txt:=GetPath($PathToEngineLink_txt)+"DataBase"+Folder separator:K24:12
			Else 
				$PathToEngineLink_txt:=GetPath(Application file:C491)+"DataBase"+Folder separator:K24:12
			End if 
		End if 
		//End if 
		
		$PathToEngineLink_txt:=$PathToEngineLink_txt+"EnginedServer.4Dlink"
		If (Test path name:C476($PathToEngineLink_txt)=Is a document:K24:1)
			
			$xml_txt:=DOM Parse XML source:C719($PathToEngineLink_txt)
			$elemref_txt:=DOM Find XML element:C864($xml_txt; "database_shortcut")
			DOM GET XML ATTRIBUTE BY NAME:C728($elemref_txt; "server_path"; $Attribute_txt)
			If (Position:C15("mhdbms.root.eot.gov"; $Attribute_txt)>0)  //prod only
				DOM SET XML ATTRIBUTE:C866($elemref_txt; "server_path"; "146.243.135.242")
				DOM EXPORT TO FILE:C862($xml_txt; $PathToEngineLink_txt)
				
			End if 
			
		End if 
	End if 
End if 
//End ut_ResetPathToServer