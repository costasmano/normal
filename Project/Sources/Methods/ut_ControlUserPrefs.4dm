//%attributes = {"invisible":true}
//Method: ut_ControlUserPrefs
//Description
//
// Parameters
// $1 : $Task_txt ("LOAD" | "SAVE")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/14/12, 15:32:32
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
	// Modified by: Costas Manousakis-(Designer)-(09/02/15, 11:25:13)
	Mods_2015_09
	//  `added pref prefTruckPostNOL-  ◊pref_TruckPost_NOL
	// Modified by: Costas Manousakis-(Designer)-(11/30/15 10:55:57)
	Mods_2015_11
	//  `added pref EmailMethod only in INIT; added task "INIT" to set up arrays with prefnames and pointer to pref variables.
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:38:37)
	Mods_2016_10
	//  `added  boolean ◊pref_New4DWR to use  new method of printing 4D Write comments in inspeciton reports
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 12:08:51)
	Mods_2016_10
	//  `default ◊pref_New4DWR to True on INIT
	// Modified by: Costas Manousakis-(Designer)-(10/17/17 14:21:49)
	Mods_2017_10_bug
	//  `added debug log options
	// Modified by: Costas Manousakis-(Designer)-(11/17/17 13:54:20)
	Mods_2017_11_bug
	//  ` in the Load task set the debug values to true and 6 only for volume desktop apps
	// Modified by: Costas Manousakis-(Designer)-(2/23/21 10:48:05)
	Mods_2021_02
	//  `removed alert for design group when setting debug log in standalone app
	// Modified by: Costas Manousakis-(Designer)-(2022-04-06 09:48:13)
	Mods_2022_04
	//  `added C_TEXT(<>PDFTKLocation_txt)
	
End if 
//
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1

C_TEXT:C284($userPrefFile_txt; $userPrefXML_txt; $PrefElmt_txt; $usePrefValue_txt)
$userPrefFile_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"MADOTBMS_UserPrefs.xml"

Case of 
		
	: ($Task_txt="LOAD")
		
		If (Test path name:C476($userPrefFile_txt)=Is a document:K24:1)
			$userPrefXML_txt:=DOM Parse XML source:C719($userPrefFile_txt)
			If (OK=1)
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
					$PrefElmt_txt:=DOM Find XML element:C864($userPrefXML_txt; <>pref_Root_txt+"/"+<>PrefNames_atxt{$loop_L})
					If (Ok=1)
						DOM GET XML ELEMENT VALUE:C731($PrefElmt_txt; <>PrefVariables_aptr{$loop_L}->)
					End if 
				End for 
				
				DOM CLOSE XML:C722($userPrefXML_txt)
			End if 
		End if 
		//temporarily enable Startdebuglog - only for standalone app
		If (Application type:C494=4D Volume desktop:K5:2)
			If (User in group:C338(Current user:C182; "Design Access Group"))
				//ALERT("Setting StartDebug to true and Dbg value to 6")
			End if 
			<>pref_StartDbgLog:=True:C214
			<>pref_DbgLogValue:=6  // enables file with v14 format, with parameters and runtimes
		End if 
		
	: ($Task_txt="SAVE")
		$userPrefXML_txt:=DOM Create XML Ref:C861(<>pref_Root_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(<>PrefNames_atxt))
			$PrefElmt_txt:=DOM Create XML element:C865($userPrefXML_txt; <>PrefNames_atxt{$loop_L})
			DOM SET XML ELEMENT VALUE:C868($PrefElmt_txt; <>PrefVariables_aptr{$loop_L}->)
		End for 
		
		DOM EXPORT TO FILE:C862($userPrefXML_txt; $userPrefFile_txt)
		DOM CLOSE XML:C722($userPrefXML_txt)
		
	: ($Task_txt="INIT")
		ARRAY TEXT:C222(<>PrefNames_atxt; 0)
		ARRAY POINTER:C280(<>PrefVariables_aptr; 0)
		C_TEXT:C284(<>pref_Root_txt)
		<>pref_Root_txt:="BMSUserPrefs"
		C_BOOLEAN:C305(<>ShowPrint)
		C_TEXT:C284(<>pref_SMTP)
		C_TEXT:C284(<>EmailMethod)
		C_TEXT:C284(<>PDFTKLocation_txt)
		C_BOOLEAN:C305(<>pref_TruckPost_NOL)
		C_BOOLEAN:C305(<>pref_New4DWR)
		C_BOOLEAN:C305(<>pref_StartDbgLog)
		C_LONGINT:C283(<>pref_DbgLogValue)
		<>pref_New4DWR:=True:C214
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "ShowPrint")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>ShowPrint)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "prefSMPT")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>pref_SMTP)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "prefTruckPostNOL")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>pref_TruckPost_NOL)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "EmailMethod")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>EmailMethod)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "New4DWrite")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>pref_New4DWR)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "StartDebugLog")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>pref_StartDbgLog)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "DebugLogValue")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>pref_DbgLogValue)
		
		APPEND TO ARRAY:C911(<>PrefNames_atxt; "Locationofpdftkexe")
		APPEND TO ARRAY:C911(<>PrefVariables_aptr; -><>PDFTKLocation_txt)
		
End case 

//End ut_ControlUserPrefs