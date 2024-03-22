//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrievePRJxrefs
// User name (OS): charlesmiller
// Date and time: 11/12/08, 15:15:35
// ----------------------------------------------------
// Description
// This method will retrieve and validate project xref records
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_07  //r003 `07/27/09, 10:37:58   `Fix errors when SQL calls fail
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($EOL)
C_LONGINT:C283($win)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm; $SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Project File xref Attributes "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Project File XREF Attributes")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Project File XREF Attributes"; 0; False:C215; ""; 3)

If (SQL_Direct("sp_RTRVPRJAttributes"))
	C_TIME:C306($StartTime_tm; $RemainingTime_tm)
	
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l; $Deletedrecords_l; $RecordNumber_l)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	
	
	ALL RECORDS:C47([PRJ_ATTRFileNoXrefs:131])
	CREATE SET:C116([PRJ_ATTRFileNoXrefs:131]; "BeginSet")
	CREATE EMPTY SET:C140([PRJ_ATTRFileNoXrefs:131]; "DeletedSet")
	ARRAY LONGINT:C221($RecordNumber_al; 0)
	C_BOOLEAN:C305($UpdateRecord_b)
	
	$SizeOfArray_l:=Size of array:C274(PRJ_PROJECT_NO_al)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Retrieved "+String:C10($SizeOfArray_l)+" potential [PRJ_ATTRFileNoXrefs] records"+$EOL
	OB SET:C1220($progressObj_o; "total"; $SizeOfArray_l)
	For ($Loop_l; 1; $SizeOfArray_l)
		UpdateProgressNew($progressObj_o; $Loop_l)
		//GOTO XY(5;2)
		//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		
		QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1=PRJ_AttributeID_al{$Loop_l}; *)
		QUERY:C277([PRJ_ATTRFileNoXrefs:131];  & ; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=PRJ_PROJECT_NO_al{$Loop_l})
		$RecordNumber_l:=-999
		If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])=0)
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_PROJECT_NO_al{$Loop_l})
			If (Records in selection:C76([PRJ_ProjectFile:117])>0)
				CREATE RECORD:C68([PRJ_ATTRFileNoXrefs:131])
				[PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1:=PRJ_AttributeID_al{$Loop_l}
				[PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2:=PRJ_PROJECT_NO_al{$Loop_l}
				[PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3:=Date:C102(PRJ_CreatedDate_atxt{$Loop_l})
				SAVE RECORD:C53([PRJ_ATTRFileNoXrefs:131])
				$RecordNumber_l:=Record number:C243([PRJ_ATTRFileNoXrefs:131])
				
				UNLOAD RECORD:C212([PRJ_ATTRFileNoXrefs:131])
				$NewRecords_l:=$NewRecords_l+1
			End if 
		Else 
			If (ut_LoadRecord(->[PRJ_ATTRFileNoXrefs:131]))
				$RecordNumber_l:=Record number:C243([PRJ_ATTRFileNoXrefs:131])
				If ([PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3#Date:C102(PRJ_CreatedDate_atxt{$Loop_l}))
					[PRJ_ATTRFileNoXrefs:131]ATTFile_Created_d:3:=Date:C102(PRJ_CreatedDate_atxt{$Loop_l})
					SAVE RECORD:C53([PRJ_ATTRFileNoXrefs:131])
					$UpdatedRecords_l:=$UpdatedRecords_l+1
				End if 
				UNLOAD RECORD:C212([PRJ_ATTRFileNoXrefs:131])
			End if 
		End if 
		If ($RecordNumber_l>-1)
			INSERT IN ARRAY:C227($RecordNumber_al; 0; 1)
			$RecordNumber_al{1}:=$RecordNumber_l
		End if 
	End for 
	CREATE SELECTION FROM ARRAY:C640([PRJ_ATTRFileNoXrefs:131]; $RecordNumber_al)
	CREATE SET:C116([PRJ_ATTRFileNoXrefs:131]; "CurrentSet")
	DIFFERENCE:C122("BeginSet"; "CurrentSet"; "DeletedSet")
	
	If (Records in set:C195("DeletedSet")>0)
		USE SET:C118("DeletedSet")
		Repeat 
			DELETE SELECTION:C66([PRJ_ATTRFileNoXrefs:131])
			
			If (Records in set:C195("LockedSet")>0)
				USE SET:C118("LockedSet")
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322; 60)
			End if 
		Until (Records in set:C195("LockedSet")=0)
	End if 
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"deleted "+String:C10(Records in set:C195("DeletedSet"))+" [PRJ_ATTRFileNoXrefs] records"+$EOL
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"created "+String:C10($NewRecords_l)+" [PRJ_ATTRFileNoXrefs] records"+$EOL
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"modified "+String:C10($UpdatedRecords_l)+" [PRJ_ATTRFileNoXrefs] records"+$EOL
	CLEAR SET:C117("DeletedSet")
	CLEAR SET:C117("BeginSet")
	CLEAR SET:C117("CurrentSet")
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVPRJAttributes Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	$0:=False:C215
End if 
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

//CLOSE WINDOW

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Project File xref Attributes "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//End ut_PRJRetrievePRJxrefs