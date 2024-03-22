//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJCtrlRetrieveProjectData
// User name (OS): cjmiller
// Date and time: 03/02/06, 10:53:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //05/05/06, 15:24:08`Add in retreive of ad date for project file
	Mods_2006_CJMv2  //10/19/06, 15:56:10`Add messages
	Mods_2007_CJMv2  //05/09/07, 12:41:14`Create report of events
	Mods_2007_CJMv2  //05/18/07 `Add new stored procedure for updating project file
	//CJM added retrieved for ut_PRJRetrieveAttributes, ut_PRJRetrievePRJxrefs, and ut_  `PRJRetrievePRJ_Bridge
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 15:53:06
	Mods_2009_07  //r001 `07/23/09, 10:41:33   `Add call to AE to retrieve additional [PRJ_ConstructionProject] data
	// Modified by: costasmanousakis-(Designer)-(8/31/10 16:02:29)
	Mods_2010_08
	//Added call to retrieve project types ut_PRJRetrieveProjTypes
	// Modified by: costasmanousakis-(Designer)-(12/16/10 16:56:31)
	Mods_2010_12
	//Added call to ut_PRJRetrieveCPAmounts to update the Construction contract Cost data (Encumbered, spent, remaining)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2012_02  //r003`Make adjustment so long running methods to get MMARS amounts onlyy run if time is after 8:00 PM or before 6:00 AM
	//Modified by: Charles Miller (2/16/12 13:21:25)
	Mods_2012_04  //r001 Add call to sp_RetrieveVendorID to retrieve vendor id
	//Modified by: Charles Miller (4/26/12 15:06:29)
	// Modified by: Costas Manousakis-(Designer)-(5/22/12 16:59:50)
	Mods_2012_05
	//  `Use ◊MyDocumentsFolder_txt
	// Modified by: Costas Manousakis-(Designer)-(6/19/12 16:54:19)
	Mods_2012_06
	//  ` Addition of ut_PRJRetrieveProjectEvents
	Mods_2017_05  //Mover calls to CIS 2000 under tish as we are getting data from tish now
	//Modified by: Chuck Miller (5/30/17 13:26:36)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_10_bug  //Modified Poject retrieve to create CSV files for all returned data
	//Modified by: Chuck Miller (10/24/19 11:07:37)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	Mods_2022_03  //Delete obsolete code that related to ODBC Pro
	//Commented out <>ODBC_DEBUG_WINDOW
	//Modified by: Chuck Miller (3/25/22 12:44:43)
	
End if 
//TRACE

If (<>PL_LPlatfrm=Windows:K25:3)
	
	Compiler_MailUtils
	//C_TEXT(<>ODBC_DEBUG_WINDOW)  //Mods_PRJSELECTION
	//<>ODBC_DEBUG_WINDOW:="NONE"
	C_TEXT:C284($Path_txt)
	READ ONLY:C145(*)
	C_BOOLEAN:C305($OkToProceed_b)
	C_TIME:C306($SQLDocument_tm)
	C_TEXT:C284($ResultForCompare_txt)
	
	$Path_txt:=ut_PRJ_CreateFolderPath("SQL_PRJData"; "Retrieve_Status")
	
	
	//$Path_txt:=<>MyDocumentsFolder_txt+"SQL_PRJData"+<>PL_DirectorySep_s
	//If (Test path name($Path_txt)=0)
	//Else 
	//CREATE FOLDER($Path_txt)
	//End if 
	C_TEXT:C284($FileName_txt)
	$FileName_txt:="PRJSQLImport-"+Substring:C12(ut_CreateTimeStamp; 1; 12)+".txt"
	$SQLDocument_tm:=Create document:C266($Path_txt+$FileName_txt)
	C_TEXT:C284(RTRV_DocmentPath_txt)
	RTRV_DocmentPath_txt:=Document
	C_TEXT:C284(CTR_LastUpdateYYYYMMDD_txt; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:="Retrieve process starting on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	Repeat 
		$OkToProceed_b:=ut_LoadSQLConnectionInfo("Tish")
		If (Not:C34($OkToProceed_b))
			ut_CreateOrUpdateSQLConnectionD("Tish")
		End if 
		
	Until ($OkToProceed_b)
	ut_PRJSetRetrieveDate
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"last update on "+CTR_LastUpdateYYYYMMDD_txt+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	$OkToProceed_b:=True:C214
	READ WRITE:C146([PRJ_ConstructionProject:116])
	READ WRITE:C146([PRJ_Contractor:114])
	READ WRITE:C146([PRJ_DesignContracts:123])
	READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
	READ WRITE:C146([PRJ_ProjectDetails:115])
	READ WRITE:C146([PRJ_ProjectFile:117])
	READ WRITE:C146([PRJ_StructuralReview:119])
	C_TIME:C306($StartRunTime_tm; $EndRunTime_tm; $Current_tm)
	$StartRunTime_tm:=?20:00:00?
	$EndRunTime_tm:=?06:00:00?
	
	If (SQL_Connect_New)
		$OkToProceed_b:=ut_PRJRetrieveModifiedProjects
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:=""
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrieveDesignContracts
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		$Current_tm:=Current time:C178
		
		If ($Current_tm>$StartRunTime_tm) | ($Current_tm<$EndRunTime_tm)
			
			If ($OkToProceed_b)
				$OkToProceed_b:=ut_PRJRetrieveDCAmounts
				$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
				SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
				CLOSE DOCUMENT:C267($SQLDocument_tm)
				PRJ_SQLRetrieveStats_txt:=""
			End if 
		End if 
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrieveProjectFileData
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrieveProjectEvents
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrieveProjTypes
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrieveAttributes
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrievePRJxrefs
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		If ($OkToProceed_b)
			$OkToProceed_b:=ut_PRJRetrievePRJ_Bridge
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		
		ut_PRJSetRetrieveDate
		
		$OkToProceed_b:=True:C214
		
		ut_PRJRetrieveConstructionCont
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:=""
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CTR_ContractorID_l:2=0)
		QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5#"")
		
		FIRST RECORD:C50([PRJ_ConstructionProject:116])
		C_LONGINT:C283($Loop_l)
		C_TIME:C306($StartTime_tm; $RemainingTime_tm)
		C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l; $win)
		$SizeOfArray_l:=Records in selection:C76([PRJ_ConstructionProject:116])
		$StartTime_tm:=Current time:C178
		C_OBJECT:C1216($progressObj_o)
		$progressObj_o:=ProgressNew("Updating Construction Contractors"; Records in selection:C76([PRJ_ConstructionProject:116]); False:C215; ""; 3)
		
		//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving construction contractors")
		C_LONGINT:C283($NewCounter_l; $UpdateCounter_l)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve construction company name on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:=""
		ARRAY LONGINT:C221($PRJ_CPCompanyNameID_al; 0)
		ARRAY TEXT:C222($PRJ_CPCompanyName_atxt; 0)
		
		For ($Loop_l; 1; Records in selection:C76([PRJ_ConstructionProject:116]))
			UpdateProgressNew($progressObj_o; $Loop_l)
			//GOTO XY(5;2)
			//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
			//GOTO XY(5;5)
			//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time-$StartTime_tm)
			//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
			//GOTO XY(5;7)
			//MESSAGE("Elapsed time is "+Time string(Current time-$StartTime_tm))
			
			If (ut_LoadRecord(->[PRJ_ConstructionProject:116]; 10))
				
				$ResultForCompare_txt:=String:C10((Num:C11([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)))
				If ([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5="") | ($ResultForCompare_txt#[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)
				Else 
					If (ut_PRJRetrieveCPName)
						
						If (Size of array:C274(PRJ_CPCompanyName_atxt)>0)
							APPEND TO ARRAY:C911($PRJ_CPCompanyNameID_al; PRJ_CPCompanyNameID_al{1})
							APPEND TO ARRAY:C911($PRJ_CPCompanyName_atxt; PRJ_CPCompanyName_atxt{1})
							If (PRJ_CPCompanyName_atxt{1}#"")
								
								QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_ContractorID_l:1=PRJ_CPCompanyNameID_al{1})
								If (Records in selection:C76([PRJ_Contractor:114])=0)
									CREATE RECORD:C68([PRJ_Contractor:114])
									[PRJ_Contractor:114]CTR_ContractorID_l:1:=PRJ_CPCompanyNameID_al{1}
									[PRJ_Contractor:114]CTR_CompanyName_s:2:=PRJ_CPCompanyName_atxt{1}
									
									SAVE RECORD:C53([PRJ_Contractor:114])
									$NewCounter_l:=$NewCounter_l+1
								Else 
									If (ut_LoadRecord(->[PRJ_Contractor:114]; 10))
										[PRJ_Contractor:114]CTR_CompanyName_s:2:=PRJ_CPCompanyName_atxt{1}
										$UpdateCounter_l:=$UpdateCounter_l+1
										SAVE RECORD:C53([PRJ_Contractor:114])
									End if 
									
								End if 
								[PRJ_ConstructionProject:116]CTR_ContractorID_l:2:=[PRJ_Contractor:114]CTR_ContractorID_l:1
								
								SAVE RECORD:C53([PRJ_ConstructionProject:116])
								UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
								UNLOAD RECORD:C212([PRJ_Contractor:114])
							End if 
						End if 
					End if 
				End if 
			End if 
			NEXT RECORD:C51([PRJ_ConstructionProject:116])
		End for 
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($NewCounter_l)+" New Construction company names processed "+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($UpdateCounter_l)+" Updated Construction company names processed "+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve construction company name on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
		C_TEXT:C284($FolderName_txt)
		C_TEXT:C284($result_txt)
		
		COPY ARRAY:C226($PRJ_CPCompanyNameID_al; PRJ_CPCompanyNameID_al)
		COPY ARRAY:C226($PRJ_CPCompanyName_atxt; PRJ_CPCompanyName_atxt)
		
		
		$Result_txt:=ut_ArraysToText(","; \
			->PRJ_CPCompanyNameID_al; \
			->PRJ_CPCompanyName_atxt)
		ARRAY LONGINT:C221(PRJ_CPCompanyNameID_al; 0)
		ARRAY TEXT:C222(PRJ_CPCompanyName_atxt; 0)
		$Path_txt:=ut_PRJ_CreateFolderPath("CSV_OutPut")
		
		C_TEXT:C284($FileName_txt)
		$FileName_txt:="sp_RTRVConstCompany-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "a")+".csv"
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
		CLOSE DOCUMENT:C267($Doc_tm)
		TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)
		
		//CLOSE WINDOW
		PRJ_SQLRetrieveStats_txt:=""
		
		QUERY:C277([PRJ_Contractor:114]; [PRJ_Contractor:114]CTR_VendorCode_s:3="")
		FIRST RECORD:C50([PRJ_Contractor:114])
		
		
		//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Vendor Code")
		C_LONGINT:C283($NewCounter_l; $UpdateCounter_l)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Vendor Code on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		PRJ_SQLRetrieveStats_txt:=""
		$SizeOfArray_l:=Records in selection:C76([PRJ_Contractor:114])
		$progressObj_o:=ProgressNew("Updating Vendor Codes"; $SizeOfArray_l; False:C215; ""; 3)
		
		$UpdateCounter_l:=0
		$StartTime_tm:=Current time:C178
		
		For ($Loop_l; 1; $SizeOfArray_l)
			UpdateProgressNew($progressObj_o; $Loop_l)
			//GOTO XY(5;2)
			//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
			//GOTO XY(5;5)
			//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time-$StartTime_tm)
			//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
			//GOTO XY(5;7)
			//MESSAGE("Elapsed time is "+Time string(Current time-$StartTime_tm))
			
			If (ut_LoadRecord(->[PRJ_Contractor:114]; 10))
				
				If (ut_PRJRetrieveVendorID)
					If (Size of array:C274(PRJ_CPVendorCode_atxt)=1)
						If (PRJ_CPVendorCode_atxt{1}#"")
							$UpdateCounter_l:=$UpdateCounter_l+1
							[PRJ_Contractor:114]CTR_VendorCode_s:3:=PRJ_CPVendorCode_atxt{1}
							SAVE RECORD:C53([PRJ_Contractor:114])
						End if 
					End if 
				End if 
			End if 
			NEXT RECORD:C51([PRJ_Contractor:114])
		End for 
		//CLOSE WINDOW
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
		
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($UpdateCounter_l)+" Updated Vendor Code processed "+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Vendor Code on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
		SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
		CLOSE DOCUMENT:C267($SQLDocument_tm)
		
		PRJ_SQLRetrieveStats_txt:=""
		
		UNLOAD RECORD:C212([PRJ_Contractor:114])
		
		ut_PRJRetrieveAEData
		$Current_tm:=Current time:C178
		
		If ($Current_tm>$StartRunTime_tm) | ($Current_tm<$EndRunTime_tm)
			ut_PRJRetrieveCPAmounts
		End if 
	End if 
	
	If ($OkToProceed_b)
		ut_ResetSQLLastUpdateDate("tish")
	End if 
	SQL LOGOUT:C872
	PRJ_SQLRetrieveStats_txt:="Retrieve  process ended on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	
	
Else 
	ALERT:C41("This can only be run from a windows machine")
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

//End ut_PRJCtrlRetrieveProjectData