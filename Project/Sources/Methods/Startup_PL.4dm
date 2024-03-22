//%attributes = {"invisible":true}
If (False:C215)
	// Procedure:Startup_PL
	// Module: Platform Management
	// By:   Jeff Browning
	// Date:  11/12/95  
	// Purpose: Initializes platform management module
	
	// Modified by: costasmanousakis-(Designer)-(4/10/2007 09:07:50)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(11/5/2007 11:25:10)
	Mods_2007_CM12_5302  //added code to define the current 4DX folder
	// Modified by: costasmanousakis-(Designer)-(11/20/07 16:23:02)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis (4/22/09)
	Mods_2009_04
	//Use the new Get 4D folder(4D Client Database Folder) in v 2004 to get the set the 4DX folder in Client mode
	// Modified by: Costas Manousakis-(Designer)-(5/22/12 16:12:23)
	Mods_2012_05
	//  `Add ◊MyDocumentsFolder_txt variable
	// Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00 18:38:21)
	Mods_2022_01
	//  `set <>MyDocumentsFolder_txt to the data file folder if running as a server.
End if 

// Declare local variables
C_LONGINT:C283($vlSystem)
// Declare interprocess variables
C_LONGINT:C283(<>PL_LPlatfrm)  //1 = 68K Mac; 2 = PPC Mac; 3 = Wintel
C_LONGINT:C283(<>PL_LSysVers)  //OS number (depends upon the platform)
C_TEXT:C284(<>My4DXFolder_txt; <>MyDocumentsFolder_txt; $MydocSpec_txt)

// Use the new command to test the 4th Dimension version
_O_PLATFORM PROPERTIES:C365(<>PL_LPlatfrm; <>PL_LSysVers)

C_TEXT:C284(<>PL_DirectorySep_s)  // Command Replaced was o_C_STRING length was 1
C_BOOLEAN:C305(<>WindowsPL_b; <>MacPL_b)
<>WindowsPL_b:=Is Windows:C1573  //(<>PL_LPlatfrm=Windows)
<>MacPL_b:=Not:C34(<>WindowsPL_b)  //Not((<>PL_LPlatfrm=Windows))
Case of 
	: (<>WindowsPL_b)  //(<>PL_LPlatfrm=Windows)
		<>PL_DirectorySep_s:="\\"
	Else 
		<>PL_DirectorySep_s:=":"
End case 

Case of 
	: (Application type:C494=4D Remote mode:K5:5)
		<>My4DXFolder_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
		
		
		Case of 
			: (<>WindowsPL_b)  //(<>PL_LPlatfrm=Windows)
				<>My4DXFolder_txt:=<>My4DXFolder_txt+"Win4DX"+<>PL_DirectorySep_s
			Else 
				$PathToEngineLink_txt:=Application file:C491+<>PL_DirectorySep_s+"Contents"+<>PL_DirectorySep_s+"Database"+<>PL_DirectorySep_s+"EnginedServer.4Dlink"
				<>My4DXFolder_txt:=<>My4DXFolder_txt+"Mac4DX"+<>PL_DirectorySep_s
		End case 
		C_TEXT:C284($PathToEngineLink_txt)
		
	: (Application type:C494=4D Volume desktop:K5:2)
		Case of 
			: (<>WindowsPL_b)  //(<>PL_LPlatfrm=Windows)
				<>My4DXFolder_txt:=<>My4DXFolder_txt+"Win4DX"+<>PL_DirectorySep_s
			Else 
				//$vlSystem:=<>PL_LSysVers\256
				$vlSystem:=15
				//ALERT(String($vlSystem))
				If ($vlSystem=16)  //OSX
					<>My4DXFolder_txt:=Substring:C12(Structure file:C489; 1; Position:C15(":Contents:"; Structure file:C489))
					<>My4DXFolder_txt:=<>My4DXFolder_txt+"Contents:Mac4DX:"
				Else   //OS 8 or 9
					<>My4DXFolder_txt:=GetPath(Structure file:C489)+"Mac4DX"+<>PL_DirectorySep_s
				End if 
		End case 
	Else 
		<>My4DXFolder_txt:=GetPath(Structure file:C489)
		Case of 
			: (<>WindowsPL_b)  // (<>PL_LPlatfrm=Windows)
				<>My4DXFolder_txt:=<>My4DXFolder_txt+"Win4DX"+<>PL_DirectorySep_s
			Else 
				<>My4DXFolder_txt:=<>My4DXFolder_txt+"Mac4DX"+<>PL_DirectorySep_s
		End case 
End case 

If (Application type:C494=4D Server:K5:6)
	<>MyDocumentsFolder_txt:=Get 4D folder:C485(Data folder:K5:33)
Else 
	<>MyDocumentsFolder_txt:=System folder:C487(Documents folder:K41:18)
End if 

//If (<>WindowsPL_b)
//$MydocSpec_txt:="My Documents"
//Else 
//$MydocSpec_txt:="Documents"
//End if 

//<>MyDocumentsFolder_txt:=Replace string(<>MyDocumentsFolder_txt;<>PL_DirectorySep_s+"Desktop"+<>PL_DirectorySep_s;<>PL_DirectorySep_s+$MydocSpec_txt+<>PL_DirectorySep_s)

//If (Test path name(<>MyDocumentsFolder_txt)=Is a folder)
//Else 
//<>MyDocumentsFolder_txt:=System folder(Desktop)  //set to desktop if something not correct
//End if 

// end