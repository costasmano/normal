//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/13/16, 12:15:33
//----------------------------------------------------
//Method: compiler_CNV
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_05  // 
	//Modified by: administrator (5/13/16 12:15:36)
	Mods_2020_03  //Fix compiler syntax issues.3
End if 
If (False:C215)
	C_BOOLEAN:C305(ut_CNV_CheckPictures; $1)
	C_BLOB:C604(ut_CNV_CheckPictures; $2)
	C_LONGINT:C283(CNV_returnProcessState; $0)
	C_LONGINT:C283(CNV_returnProcessState; $1)
	C_TEXT:C284(CNV_returnProcessState; $2)
	C_TEXT:C284(CNV_CreatePath; $0)
	C_TEXT:C284(CNV_CreatePath; $1)
	C_TEXT:C284(CNV_CreatePath; $2)
	
	C_BOOLEAN:C305(ut_CNV_ExportPictures; $1)
	C_BLOB:C604(ut_CNV_ExportPictures; $2)
	
	C_TEXT:C284(CNV_PrintToPDF; $1)
	
	C_BLOB:C604(CNV_ImportPictures; $1)
	
	C_TEXT:C284(CNV_CreatePathNoInspection; $0; $1; $2)
	C_DATE:C307(CNV_CreatePathNoInspection; $3)
	C_TEXT:C284(CNV_CreatePathNoInspection; $4)
	
	
	C_TEXT:C284(CNV_CreateNewPath; $0)
	C_TEXT:C284(CNV_CreateNewPath; $1)
	C_TEXT:C284(CNV_CreateNewPath; $2)
	
End if 
ARRAY LONGINT:C221(CNV_RecordNumber_aL; 0)
C_DATE:C307(CNV_Start_d; CNV_End_d)
C_LONGINT:C283(CNV_All_L; CNV_Photos_L; CNV_Sketches_L; CNV_Charts_L; CNV_StandardPhotos_L; CurrentLoop_L; CNV_RunningProcess_L; CNV_ProcessCount_L)
C_BLOB:C604(Report_blb)
C_BOOLEAN:C305(CNV_StopMe_B)
C_TIME:C306(CNV_Doc_tm)
ARRAY BOOLEAN:C223(CNV_RunningProcess_aB; 0)

C_LONGINT:C283(<>CNV_StopProcessID_L; TryAgain_L)

C_LONGINT:C283(<>CNV_TraceRecordNumber_L)

C_LONGINT:C283(CNV_Row_L)
C_LONGINT:C283(LastID_L)
C_TEXT:C284(CNV_Path_txt)
C_TEXT:C284(CNV_ProcessDocument_txt)
If (Type:C295(<>CNV_UpdatePictProcessIDs_aL)=Is undefined:K8:13)
	ARRAY LONGINT:C221(<>CNV_UpdatePictProcessIDs_aL; 0)
	ARRAY TEXT:C222(<>CNV_ProcessName_atxt; 0)
End if 

//End compiler_CNV