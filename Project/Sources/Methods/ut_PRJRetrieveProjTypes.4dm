//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ut_PRJRetrieveProjTypes
// copied from ut_PRJRetrieveAttributes
// User name (OS): charlesmiller
// Date and time: 11/12/08, 12:56:29
// ----------------------------------------------------
// Description
// This method will retrieve and update Project TYpe records.
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Created by: costasmanousakis-(Designer)-(8/31/10 14:21:10)
	Mods_2010_08
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($Eol)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm; $SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Project Types "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//C_LONGINT($win)
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Project Types")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Project Types"; 0; False:C215; ""; 3)

If (SQL_Direct("sp_RTRVProjTypes"))
	
	READ WRITE:C146([PRJ_ProjectTypes:141])
	UNLOAD RECORD:C212([PRJ_ProjectTypes:141])
	ALL RECORDS:C47([PRJ_ProjectTypes:141])
	CREATE SET:C116([PRJ_ProjectTypes:141]; "BeginProjTypesSet")
	CREATE EMPTY SET:C140([PRJ_ProjectTypes:141]; "DeletedProjTypesSet")
	C_TIME:C306($StartTime_tm; $RemainingTime_tm)
	
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l; $Deletedrecords_l)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	$SizeOfArray_l:=Size of array:C274(PRJ_AttributeName_atxt)
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Retrieved "+String:C10($SizeOfArray_l)+" potential [PRJ_ProjType] records"+$EOL
	OB SET:C1220($progressObj_o; "total"; $SizeOfArray_l)
	For ($Loop_l; 1; $SizeOfArray_l)
		UpdateProgressNew($progressObj_o; $Loop_l)  //GOTO XY(5;2)
		//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		
		QUERY:C277([PRJ_ProjectTypes:141]; [PRJ_ProjectTypes:141]PRTP_TypeCode_s:1=PRJ_AttributeName_atxt{$Loop_l})
		
		If (Records in selection:C76([PRJ_ProjectTypes:141])=0)
			CREATE RECORD:C68([PRJ_ProjectTypes:141])
			[PRJ_ProjectTypes:141]PRTP_TypeCode_s:1:=PRJ_AttributeName_atxt{$Loop_l}
			SAVE RECORD:C53([PRJ_ProjectTypes:141])
			$NewRecords_l:=$NewRecords_l+1
		Else 
			$UpdatedRecords_l:=$UpdatedRecords_l+1
		End if 
		If (ut_LoadRecord(->[PRJ_ProjectTypes:141]))
			If ([PRJ_ProjectTypes:141]PRTP_Description_txt:2#PRJ_AttributeDesc_atxt{$Loop_l})
				[PRJ_ProjectTypes:141]PRTP_Created_d:3:=Date:C102(PRJ_CreatedDate_atxt{$Loop_l})
				[PRJ_ProjectTypes:141]PRTP_Description_txt:2:=PRJ_AttributeDesc_atxt{$Loop_l}
				[PRJ_ProjectTypes:141]PRTP_Modified_d:4:=Date:C102(PRJ_ModifiedDate_atxt{$Loop_l})
				
			End if 
			SAVE RECORD:C53([PRJ_ProjectTypes:141])
			UNLOAD RECORD:C212([PRJ_ProjectTypes:141])
		End if 
	End for 
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"created "+String:C10($NewRecords_l)+" [PRJ_ProjType] records"+$EOL
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"modified "+String:C10($UpdatedRecords_l)+" [PRJ_ProjType] records"+$EOL
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "CurrentProjTypesSet")
	QUERY WITH ARRAY:C644([PRJ_ProjectTypes:141]PRTP_TypeCode_s:1; PRJ_AttributeName_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIFFERENCE:C122("BeginProjTypesSet"; "CurrentProjTypesSet"; "DeletedProjTypesSet")
	If (Records in set:C195("DeletedProjTypesSet")>0)
		USE SET:C118("DeletedProjTypesSet")
		$Deletedrecords_l:=Records in selection:C76([PRJ_ProjectTypes:141])
		
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"deleted "+String:C10($Deletedrecords_l)+" [PRJ_Attributes] records"+$EOL
		
		Repeat 
			DELETE SELECTION:C66([PRJ_ProjectTypes:141])
			
			If (Records in set:C195("LockedSet")>0)
				USE SET:C118("LockedSet")
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322; 60)
			End if 
		Until (Records in set:C195("LockedSet")=0)
	End if 
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Cal to sp_RTRVProjTypes Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	$0:=False:C215
End if 
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

//CLOSE WINDOW
CLEAR SET:C117("BeginProjTypesSet")
CLEAR SET:C117("DeletedProjTypesSet")
CLEAR SET:C117("CurrentProjTypesSet")

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Project Types "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//End 