//%attributes = {"invisible":true}
//Method: Test_CheckonActIDsfromServer
//Description
// check on what activity ref ids are coming back from a server from a user. For debugging purposes.
// calls via SQL function ut_CTRLReturnActKeys
// will save data to a csv file.
// data is [Activity Type],[FileID Local],[RefID],[dDate],[tTime]
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 6, 2023, 17:14:56
	Mods_2023_01_bug
	
	// ----------------------------------------------------
	//  `
End if 
//
Compiler_FieldVariables
ut_InitFieldArray
Compiler_forSQL
Compiler_TransfLog
Compiler_MailUtils
MissingParent_B:=False:C215
tMailNote:=""
SQLError_b:=False:C215
4D_Error_b:=False:C215
InWHKRUpdate_b:=False:C215
DataRefernceError_b:=False:C215

X_NumActLogToBeRecd_L:=0
X_ActLogToBeRecdStart_L:=0
X_ActLogToBeRecdEnd_L:=0
X_ActLogLastRecd_L:=0
X_StartRec_txt:=""
X_EndRec_txt:=""
X_RecdError_txt:=""

C_DATE:C307($Start_d; $End_d)
C_TIME:C306($Start_tm; $Finish_tm; $Elapsed_tm)
$Start_d:=Current date:C33(*)
$Start_tm:=Current time:C178(*)
C_TEXT:C284($CurrentUser_txt)
C_LONGINT:C283($InternalNumber_l; $RemoteRefID_L)
$CurrentUser_txt:=Current user:C182
C_BOOLEAN:C305($AbortDueToDuplicateNRC_B)
$AbortDueToDuplicateNRC_B:=False:C215
//Get the profile of the Owers of Data file
ActFileID_l:=Table:C252(->[Activity Log:59])
OwnerFileID_l:=Table:C252(->[Owners of Data:62])
//Get the profile of the Owers of Data file
OwnerRef_l:=Field:C253(->[Owners of Data:62]RefID:1)
OwnerName_l:=Field:C253(->[Owners of Data:62]Owner Name:2)
ARRAY LONGINT:C221(ActivityKeys_al; 0)
C_TEXT:C284($CurrentUser_txt; $destIP; $Forward_txt; $password)
$CurrentUser_txt:=Request:C163("Enter user name to check")
$password:=Request:C163("Enter password for "+$CurrentUser_txt)
$destIP:=Request:C163("Enter destination address"; <>DestIP)
$Forward_txt:=Request:C163("Enter Forward "; <>Forward)
C_LONGINT:C283($Error_l)
$Error_l:=ut_SQLMakeConnnection($CurrentUser_txt; $password; $destIP; $CurrentUser_txt+", you are about to download data from the central database.")
If ($Error_l=1)
	ut_SQLReturnALRecordKeys($Forward_txt; $CurrentUser_txt; 0)  // set 0 for the next act ref id (param 3)
	ALERT:C41("Set to retrieve "+String:C10(Size of array:C274(ActivityKeys_al))+" remote ref IDs")
	C_TEXT:C284($in_txt)
	
	//retrieve info about the actlog records
	//build the in_txt
	$in_txt:=ut_ArrayToText(->ActivityKeys_al; " , ")
	
	C_TEXT:C284(sql_select)
	sql_select:="select [Activity Log].[Activity Type],"+\
		"[Activity Log].[FileID Local],"+\
		"[Activity Log].[RefID], "+\
		"[Activity Log].[dDate], "+\
		"[Activity Log].[tTime] "+\
		"from [Activity Log] where [Activity Log].[RefID] IN ("+$in_txt+") ;"
	
	ON ERR CALL:C155("SQL_ERROR")
	SQL EXECUTE:C820(SQL_Select; v_59_003_atxt; v_59_024_aL; v_59_028_aL; v_59_005_ad; v_59_006_atm)
	While (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822(SQL all records:K49:10)
	End while 
	SQL CANCEL LOAD:C824
	ON ERR CALL:C155("")
	If (Not:C34(SQLError_b))
		C_TEXT:C284($data; $file_)
		ARRAY TEXT:C222($tablenames; Size of array:C274(v_59_024_aL))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(v_59_024_aL))
			$tablenames{$loop_L}:=Table name:C256(v_59_024_aL{$loop_L})
		End for 
		$data:=ut_ArraysToText(","; ->v_59_028_aL; ->v_59_024_aL; ->$tablenames; ->v_59_003_atxt; ->v_59_005_ad; ->v_59_006_atm)
		
		$data:="RefID"+","+"FileID local"+","+"table name"+","+"Act Type"+","+"Date"+","+"Time\n"+$data
		C_BLOB:C604($fBlob)
		TEXT TO BLOB:C554($data; $fBlob; UTF8 text without length:K22:17)
		$file_:=Select document:C905(""; ".csv"; "select csv file to save"; File name entry:K24:17)
		
		If (Ok=1)
			BLOB TO DOCUMENT:C526(Document; $fBlob)
			SHOW ON DISK:C922(Document)
			OPEN URL:C673(Document)
		End if 
	Else 
		ALERT:C41("SQL Error! first descr msg :\n"+SQL_InternalDescriptions_atxt{1})
	End if 
	
	SQL LOGOUT:C872
	
End if 

//End Test_CheckonActIDsfromServer   