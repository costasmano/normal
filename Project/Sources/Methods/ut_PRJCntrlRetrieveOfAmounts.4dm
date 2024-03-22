//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJCntrlRetrieveOfAmounts
// User name (OS): charlesmiller
// Date and time: 01/14/11, 11:28:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
//$1 DC for [PRJ_DesignContracts]
//$1 CP for [PRJ_ConstructionProject]

If (False:C215)
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:28:21     
	//Add code to allow for retrieve of [PRJ_DesignContracts] amounts and
	//[PRJ_ConstructionProject] seperately
	Mods_2011_06  // CJ Miller`06/20/11, 10:31:02      ` Type all local variables for v11
	Mods_2012_02  //r001 `r003`Make adjustment so long running methods to get MMARS amounts onlyy run if time is after 8:00 PM or before 6:00 AM
	//Ad confirm to make sure operator really want to run this during the day.
	//Modified by: Charles Miller (2/16/12 13:30:29)
	// Modified by: Costas Manousakis-(Designer)-(5/23/12 16:17:23)
	Mods_2012_05
	//  `Use ◊MyDocumentsFolder_txt
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	Mods_2022_03  //Delete obsolete code that related to ODBC Pro
	//Commented out <>ODBC_DEBUG_WINDOW
	//Modified by: Chuck Miller (3/25/22 12:44:43)
End if 
C_TEXT:C284($1; $WhichToRetrieve_txt; $Path_txt)
$WhichToRetrieve_txt:=$1
C_TIME:C306($StartRunTime_tm; $EndRunTime_tm; $Current_tm)
$Current_tm:=Current time:C178
$StartRunTime_tm:=?20:00:00?
$EndRunTime_tm:=?06:00:00?
C_BOOLEAN:C305($Runit_b)
$Runit_b:=True:C214
If ($Current_tm<$StartRunTime_tm) | ($Current_tm>$EndRunTime_tm)
	$Runit_b:=False:C215
	CONFIRM:C162("Are you sure you want to run this at "+String:C10($Current_tm))
	If (OK=1)
		$Runit_b:=True:C214
	End if 
End if 
If ($Runit_b)
	If (<>PL_LPlatfrm=Windows:K25:3)
		//C_TEXT(<>ODBC_DEBUG_WINDOW)  //Mods_PRJSELECTION
		//<>ODBC_DEBUG_WINDOW:="NONE"
		C_BOOLEAN:C305($OkToProceed_b)
		READ ONLY:C145(*)
		C_BOOLEAN:C305($OkToProceed_b)
		C_TIME:C306($SQLDocument_tm)
		$Path_txt:=ut_PRJ_CreateFolderPath("SQL_PRJData"; "Retrieve_Status")
		
		C_TEXT:C284($FileName_txt)
		
		$FileName_txt:="PRJSQLImport_"+$WhichToRetrieve_txt+"-"+Substring:C12(ut_CreateTimeStamp; 1; 12)+".txt"
		$SQLDocument_tm:=Create document:C266($Path_txt+$FileName_txt)
		C_TEXT:C284(RTRV_DocmentPath_txt)
		RTRV_DocmentPath_txt:=Document
		
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:="Retrieve process for "+$WhichToRetrieve_txt+" starting on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		Repeat 
			$OkToProceed_b:=ut_LoadSQLConnectionInfo("Tish")
			If (Not:C34($OkToProceed_b))
				ut_CreateOrUpdateSQLConnectionD("Tish")
			End if 
			
		Until ($OkToProceed_b)
		$OkToProceed_b:=True:C214
		READ WRITE:C146([PRJ_ConstructionProject:116])
		READ WRITE:C146([PRJ_Contractor:114])
		READ WRITE:C146([PRJ_DesignContracts:123])
		READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
		READ WRITE:C146([PRJ_ProjectDetails:115])
		READ WRITE:C146([PRJ_ProjectFile:117])
		READ WRITE:C146([PRJ_StructuralReview:119])
		
		Case of 
			: ($WhichToRetrieve_txt="DC")
				If (SQL_Connect_New)
					$OkToProceed_b:=ut_PRJRetrieveDCAmounts
					$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
					SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
					CLOSE DOCUMENT:C267($SQLDocument_tm)
					PRJ_SQLRetrieveStats_txt:=""
					SQL LOGOUT:C872
				End if 
			: ($WhichToRetrieve_txt="CP")
				If (SQL_Connect_New)
					ut_PRJRetrieveCPAmounts
					SQL LOGOUT:C872
				End if 
			Else 
		End case 
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+Char:C90(13)+"Retrieve  process ended on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		
	Else 
		ALERT:C41("This can only be run from a windows machine")
	End if 
End if 
UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
UNLOAD RECORD:C212([PRJ_Contractor:114])
UNLOAD RECORD:C212([PRJ_DesignContracts:123])
UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
UNLOAD RECORD:C212([PRJ_ProjectFile:117])
UNLOAD RECORD:C212([PRJ_StructuralReview:119])
READ ONLY:C145([PRJ_ConstructionProject:116])
READ ONLY:C145([PRJ_Contractor:114])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
READ ONLY:C145([PRJ_ProjectDetails:115])
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_StructuralReview:119])

//End ut_PRJCntrlRetrieveOfAmounts