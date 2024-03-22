//%attributes = {"invisible":true}
//Method: BMSExternal_test2
//Description
// test nethod only for use with controlClientProcess method
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/12/20, 11:32:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	// Modified by: Costas Manousakis-(Designer)-(8/17/20 13:42:34)
	Mods_2020_08_bug
	//  `changed semaphore to BMSEXTERNALTEST
End if 
//
C_TEXT:C284($CTRLCLIENTLOGS_txt; $CurrLOGFile_txt)
$CTRLCLIENTLOGS_txt:=<>MyDocumentsFolder_txt+"CTRLCLIENTLOGS"+<>PL_DirectorySep_s
If (Test path name:C476($CTRLCLIENTLOGS_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($CTRLCLIENTLOGS_txt)
End if 
$CurrLOGFile_txt:=$CTRLCLIENTLOGS_txt+Current method name:C684+"_"+ut_CreateTimeStamp+".log"
C_TIME:C306($CurrLOGFileRef_t)
$CurrLOGFileRef_t:=Create document:C266($CurrLOGFile_txt; "TEXT")
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Checking Semaphore BMSEXTERNALTEST...."+Char:C90(13))

While (Semaphore:C143("BMSEXTERNALTEST"))
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Waiting 2 min for Semaphore BMSEXTERNALTEST...."+Char:C90(13))
	DELAY PROCESS:C323(Current process:C322; (2*60*60))  //wait 2 minutes
	IDLE:C311
End while 
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Reserved Semaphore BMSEXTERNALTEST...."+Char:C90(13))

C_TEXT:C284($CurrProcName_txt)
C_TEXT:C284($StartTimeStamp_txt; $ProcName_txt)
C_LONGINT:C283($ProcState_L; $ProdTime_L; $ProcUniqID_L; $ProcOrig_L; $ProcessID)
C_BOOLEAN:C305($procViz_b)
PROCESS PROPERTIES:C336(Current process:C322; $ProcName_txt; $ProcState_L; $ProdTime_L; $procViz_b; $ProcUniqID_L; $ProcOrig_L)

$StartTimeStamp_txt:=ut_CreateTimeStamp
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Starting Test_Memory ...."+Char:C90(13))

Test_Memory

SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Clearing Semaphore...."+Char:C90(13))
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Setting next run time stamp...."+Char:C90(13))
$ProcessID:=Execute on server:C373("ut_SetNextRunTimeStamp"; 0; "Set Next stamp"; $ProcName_txt)
CLEAR SEMAPHORE:C144("BMSEXTERNALTEST")

SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Ending...."+Char:C90(13))
CLOSE DOCUMENT:C267($CurrLOGFileRef_t)
//End BMSExternal_test2