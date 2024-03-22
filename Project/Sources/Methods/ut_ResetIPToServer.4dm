//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/15/17, 11:08:17
//----------------------------------------------------
//Method: ut_ResetIPToServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  //
	
	
	//Modified by: Chuck Miller (6/15/17 11:08:18)
	// Modified by: Costas Manousakis-(Designer)-(4/8/19 11:55:51)
	Mods_2019_04
	//  `use system parameter MADOT_BostonServer for the server address
End if 
C_BOOLEAN:C305($DoUpdate_B)
$DoUpdate_B:=False:C215
C_TEXT:C284($1; $PathToEngineLink_txt; $Attribute_txt; $xml_txt; $elemref_txt; $BostonServer_txt)
$PathToEngineLink_txt:=$1
C_TEXT:C284($ServerIP_txt)
$ServerIP_txt:=G_GetServerTCP

Case of 
	: (Application type:C494=4D Volume desktop:K5:2)
	: (Application type:C494=4D Server:K5:6)
	: ($ServerIP_txt="146.243.135.242")  //boston
	: ($ServerIP_txt="74.8.145.3")  //external
	: ($ServerIP_txt="146.243.138.15")  //d1
	: ($ServerIP_txt="146.243.138.151")  //d2
	: ($ServerIP_txt="146.243.137.235")  //d3
	: ($ServerIP_txt="146.243.141.10")  //d4
	: ($ServerIP_txt="146.243.142.25")  //d5
	: ($ServerIP_txt="147.121.109.14")  //d6
		
	: (Shift down:C543)
		$DoUpdate_B:=True:C214
	: (Current user:C182="Designer")
	: (Current user:C182="Administrator")
	: (User in group:C338(Current user:C182; "Test_Group"))
	Else 
		$DoUpdate_B:=True:C214
End case 

If ($DoUpdate_B)
	If (Folder separator:K24:12=":")
		$PathToEngineLink_txt:=$PathToEngineLink_txt+Folder separator:K24:12+"Contents:DataBase"+Folder separator:K24:12+"EnginedServer.4Dlink"
		
	Else 
		$PathToEngineLink_txt:=GetPath(Application file:C491)+"DataBase"+Folder separator:K24:12+"EnginedServer.4Dlink"
	End if 
	If (Test path name:C476($PathToEngineLink_txt)=Is a document:K24:1)
		
		$xml_txt:=DOM Parse XML source:C719($PathToEngineLink_txt)
		$elemref_txt:=DOM Find XML element:C864($xml_txt; "database_shortcut")
		$BostonServer_txt:=ut_GetSysParameter("MADOT_BostonServer"; "mhdbms.root.eot.gov")
		
		DOM SET XML ATTRIBUTE:C866($elemref_txt; "server_path"; "")
		DOM SET XML ATTRIBUTE:C866($elemref_txt; "server_path"; $BostonServer_txt)
		DOM EXPORT TO FILE:C862($xml_txt; $PathToEngineLink_txt)
		ALERT:C41("You are connected to a test database.\rThe connection settings have been reset for the production database and the Application will now quit.\rPlease re-start the application.")
		QUIT 4D:C291
	Else 
		ALERT:C41("Path to .4dlink "+$PathToEngineLink_txt+" is wrong.")
		QUIT 4D:C291
	End if 
	
End if 

//End ut_ResetIPToServer