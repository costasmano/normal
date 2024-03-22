If (False:C215)
	//On Server Startup 
	Mods_2004_CJM02
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(1/25/08 11:57:25)
	Mods_2007_CM_5401
	//call method ut_WarmUpDatabase before we continue
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 11:50:43   `Add check to make sure triggers run only on inside data base
	// Modified by: costasmanousakis-(Designer)-(11/16/10 15:18:32)
	Mods_2010_11
	//Added call to Startup_PL to initialize the dir separator needed in GetPath
	Mods_2011_05  //r002 CJ Miller`05/10/11, 17:25:28      `Add code ◊NextNumberArray_al to set up for v11
	Mods_2013_10  //r001 ` Set up for maximo updates
	//Modified by: Charles Miller (10/8/13 13:11:48)
	// Modified by: Charles Miller-(Designer)-(5/19/16 )
	Mods_2016_05
	//  `Do not Launch StartControlSrvProc unless compiled in boston or external server
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	Mods_2017_01  //Add code to auto save and load  [ServerProcesses] records
	//Modified by: administrator (1/12/17 16:44:31)
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 11:37:21)
	Mods_2018_04
	//  `added call to NTI_UpdateDBonStartup
	Mods_2020_09  //Add search picker to personnel output list box
	//Modified by: CJ (9/17/20 13:44:01)
	Mods_2020_09  //Add search picker to [PERS_Groups] output list box
	//Modified by: CJ (9/17/20 13:44:01)
	Mods_2021_04  //Added code to automatically load newest U and G file
	//Modified by: CJ (4/13/21 15:57:01)
	// Modified by: Costas Manousakis-(Designer)-(2022-01-20T00:00:00 17:22:19)
	Mods_2022_01
	//  `make sure we have a preferences record, even if blank
	Mods_2022_02  //Create new interprocess variable <>BackUpStarted_B used during transfers to know when backup is occurring
	//Modified by: Chuck Miller (2/22/22 12:28:01)
	
End if 

<>BackUpStarted_B:=False:C215

TRACE:C157
ut_SetTimeOuts
ARRAY LONGINT:C221(<>NextNumberArray_al; 100)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; 100)
	<>NextNumberArray_al{$Loop_l}:=-9
End for 
SET DATABASE PARAMETER:C642(SQL engine case sensitivity:K37:43; 0)  //turn off case sensitive sql queries

If (Records in table:C83([Preferences:57])>0)
Else 
	CREATE RECORD:C68([Preferences:57])
	SAVE RECORD:C53([Preferences:57])
End if 

C_TEXT:C284(<>DatabaseStructureName_txt)
<>DatabaseStructureName_txt:=""
Startup_PL
If (Application type:C494=4D Server:K5:6)
	<>DatabaseStructureName_txt:=Structure file:C489
	<>DatabaseStructureName_txt:=Replace string:C233(<>DatabaseStructureName_txt; GetPath(<>DatabaseStructureName_txt); "")
	<>DatabaseStructureName_txt:=Substring:C12(<>DatabaseStructureName_txt; 1; Position:C15("."; <>DatabaseStructureName_txt)-1)
End if 
C_TEXT:C284($msg)
C_TEXT:C284($DataFile)  // Command Replaced was o_C_STRING length was 255
//TRACE
$DataFile:=Data file:C490
//check for locked data file on the server startup
If (bDataFileLocked)
	$msg:="Data file "+$DataFile+" is in use by another application, possibly MHD Bridges."+Char:C90(13)
	$msg:=$msg+"4D Server will exit..."
	ALERT:C41($msg)
	QUIT 4D:C291
End if 
C_DATE:C307($DateToPass_d)
C_LONGINT:C283($NumbertoPass_l)

$DateToPass_d:=Add to date:C393(Current date:C33; 0; -2; 0)
$NumbertoPass_l:=15
//C_BLOB($Users_blb)
//SET BLOB SIZE($Users_blb;0)
//$Users_blb:=UG_LoadUsersAndGroups (->$DateToPass_d;->$NumbertoPass_l)
//If (BLOB size($Users_blb)>0)
//BLOB TO USERS($Users_blb)
//End if 
C_BLOB:C604($Users_blb)
SET BLOB SIZE:C606($Users_blb; 0)

$Users_blb:=UG_LoadUsersandGroupsFromFile  // this will load newest one
If (BLOB size:C605($Users_blb)>0)
	BLOB TO USERS:C850($Users_blb)
End if 
//UG_DeleteOlderFiles(10)
ut_LoadPrefRecord
ut_LoadServerProcessRecords
ut_WarmUpDatabase
ut_SetUpBridgeInfoLinkTable

NTI_UpdateDBonStartup

//maximo_SetUpMaximoUpdate 
Bridge_FileBridgeSearchArray
Personnel_FillSearchArrray
PersGroup_FillSearchArrray
If (True:C214)  //old control server stuuf
	If (Is compiled mode:C492)
		C_BOOLEAN:C305($Launch_b)
		$Launch_b:=True:C214
		Case of 
			: (Position:C15("MHD BMS External Server"; <>DatabaseStructureName_txt)>0)
			: (<>DatabaseStructureName_txt="MHD BMS")
				
			Else 
				$Launch_b:=False:C215
		End case 
		If ($Launch_b)
			C_LONGINT:C283($ControlServerProcessesID)
			$ControlServerProcessesID:=New process:C317("StartControlSrvProc"; 0; "Start Control Server Proc")  //Mods_2002_02_18
		End if 
	End if 
Else 
	Server_SetUpCronJob
End if 
