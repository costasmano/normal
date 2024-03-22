//%attributes = {"invisible":true}
//procedure: ArchiveLogFile
//purpose: Archive old log data to file - can be reloaded using XImportLogFile
If (False:C215)
	//by: Albert Leung
	//created: 5/7/2002
	
	Mods_2004_CM11
	Mods_2005_CM05
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(5/17/2006 12:16:33)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(10/25/2007 11:03:04)
	Mods_2007_CM12_5302
	// Added Parameters
	// $1 : Archive Option (text) 
	//  ` 1 : Archive all to prior year
	//  ` 2 : Archive $2 records
	//  ` 3 : Archive prior to date $2
	//  ` 4 : Archive all
	// $2 : Secondparam (text) : depends on $1
	//  ` if $1=1 -> $2=CBDelete 
	//  ` if $1=2 -> $2=Num of records to archive 
	//  ` if $1=3 -> $2=Date prior  
	//  ` if $1=4 -> $2=CBDelete 
	// $3 : Third param Optional (text) depends on $1
	//  ` if $1=2 -> $3=CBDelete
	//  ` if $1=3 -> $3=CBDelete
	
	// CBDelete (0,1) 0: don't delete, 1: Delete after archiving
	// ex:
	//ArchiveLogFile("2";"40000";"1")
	Mods_2011_05  //r002 CJ Miller`05/20/11, 12:08:33      `Change directory where exports are stored to the users documents folder
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
	// Modified by: Costas Manousakis-(Designer)-(8/26/20 14:02:03)
	Mods_2020_08_bug
	//  `added info about the export to the tag variable at the start of the export
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 14:50:19)
	Mods_2023_04
	//  `removed IDLE
End if 
//TRACE
C_TEXT:C284($LogFName; $vsTag; $vsTimeStr)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($vsMsg)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($vlNbActLog; $vlNbOwnerData; $i; $j; $k; $Interval)
C_LONGINT:C283($vlStartMSec; $vlEndExpMsec; $vlStartDelMSec; $vlEndDelMSec)
C_LONGINT:C283($vlElapsedMSec; $vlHrs; $vlMins; $vlSecs)
C_DATE:C307($year; vDate)
C_TEXT:C284($targetfolder)
C_BOOLEAN:C305($DoArchive_b; $OnServer_b)
$DoArchive_b:=False:C215
$OnServer_b:=(Application type:C494=4D Server:K5:6)
C_LONGINT:C283(vlArchRecstoExport; r1; r2; r3; r4; CBDelete)
r1:=0
r2:=0
r3:=0
r4:=0
CBDelete:=1

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	C_LONGINT:C283($ArchiveOption)
	$ArchiveOption:=Num:C11($1)
	Case of 
		: ($ArchiveOption=1)
			r1:=1
			C_TEXT:C284($2)
			CBDelete:=Num:C11($2)
			$DoArchive_b:=True:C214
		: ($ArchiveOption=2)
			r2:=1
			C_TEXT:C284($2)
			vlArchRecstoExport:=Num:C11($2)
			C_TEXT:C284($3)
			CBDelete:=Num:C11($3)
			If (vlArchRecstoExport>0)
				$DoArchive_b:=True:C214
			End if 
			
		: ($ArchiveOption=3)
			r3:=1
			C_TEXT:C284($2)
			vDate:=Date:C102($2)
			C_TEXT:C284($3)
			CBDelete:=Num:C11($3)
			If (vDate>!00-00-00!)
				$DoArchive_b:=True:C214
			End if 
			
		: ($ArchiveOption=4)
			r4:=1
			C_TEXT:C284($2)
			CBDelete:=Num:C11($2)
			$DoArchive_b:=True:C214
	End case 
	If (CBDelete>0)
		CBDelete:=1
	End if 
Else 
	C_LONGINT:C283($W; $H)
	FORM GET PROPERTIES:C674([Dialogs:21]; "ArchiveDlog"; $W; $H)
	//$TempWin:=Open form window([Dialogs];"ArchiveDlog";Movable dialog box )
	CENTER_WINDOW($W; $H; Movable dialog box:K34:7)
	DIALOG:C40([Dialogs:21]; "ArchiveDlog")
	CLOSE WINDOW:C154
	$DoArchive_b:=(OK=1)
End if 

If ($DoArchive_b)
	C_BOOLEAN:C305($WaitMsg_b)
	$WaitMsg_b:=False:C215
	While (Semaphore:C143("<>Archiving"))  //so only one archive operation at a time can be done
		If (Not:C34($OnServer_b))
			If (Not:C34($WaitMsg_b))
				ALERT:C41("Will wait for other archive processes to end first!")
				$WaitMsg_b:=True:C214
			End if 
		End if 
		
		DELAY PROCESS:C323(Current process:C322; 120)
		
	End while 
	
	Case of 
		: (r1=1)
			$year:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33(*))))
			QUERY:C277([Activity Log:59]; [Activity Log:59]dDate:5<$year)
		: (r2=1)
			ALL RECORDS:C47([Activity Log:59])
			ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
			REDUCE SELECTION:C351([Activity Log:59]; vlArchRecstoExport)
		: (r3=1)
			QUERY:C277([Activity Log:59]; [Activity Log:59]dDate:5<vDate)
		: (r4=1)
			ALL RECORDS:C47([Activity Log:59])
	End case 
	$vlNbActLog:=Records in selection:C76([Activity Log:59])
	C_BOOLEAN:C305($Conf_b)
	$Conf_b:=False:C215
	
	If ($OnServer_b & ($vlNbActLog>0))
		$Conf_b:=True:C214
	Else 
		CONFIRM:C162("Archive "+String:C10($vlNbActLog; "#,###,##0")+" records to file?")
		$Conf_b:=(OK=1)
	End if 
	
	If ($Conf_b)
		Startup_PL  //in case running on server
		Characters
		
		$vlStartMSec:=Milliseconds:C459  //Starting millisecond mark
		$LogFName:="archiveLog_"+String:C10(Year of:C25(Current date:C33(*)))+"-"+String:C10(Month of:C24(Current date:C33(*)); "00")+"-"+String:C10(Day of:C23(Current date:C33(*)); "00")
		$LogFName:=$LogFName+"_"+String:C10(Current time:C178(*))
		$LogFName:=Replace string:C233($LogFName; ":"; "_")  //: is from the time string
		$LogFName:=Replace string:C233($LogFName; "/"; "-")  // / is from the Date string
		If ($OnServer_b)
			//On server we put it in a directory accessible to the user
			
			$targetfolder:=ut_ReturnUserDocFolder("ArchivedLogs")
			
		Else 
			$targetfolder:=Select folder:C670("Select folder for archive log file")
			//<>ProgressPID:=StartProgress ("";"None";"Exporting Activity Log")
			$Interval:=MaxNum(MinNum(Int:C8($vlNbActLog/40); 20); 2)  // get an update interval between 2 and 20
			//UpdateProgress (0;$vlNbActLog)  // start the progress bar...
			C_OBJECT:C1216($progressObj_o)
			$progressObj_o:=ProgressNew("Exporting Activity Log"; $vlNbActLog; True:C214; ""; 3)
		End if 
		
		SET CHANNEL:C77(10; $targetfolder+$LogFName)  //Open a channel for a document
		
		$k:=0
		//create a set to hold the deletions 
		Case of 
			: (r1=1)
				CREATE SET:C116([Activity Log:59]; "DelActLog")
			: (r2=1)
				CREATE EMPTY SET:C140([Activity Log:59]; "DelActLog")
			: (r3=1)
				CREATE SET:C116([Activity Log:59]; "DelActLog")
			: (r4=1)
				CREATE SET:C116([Activity Log:59]; "DelActLog")
		End case 
		FIRST RECORD:C50([Activity Log:59])
		//Create a tag for the export - add info about this export
		$vsTag:="NBISARCHIVE"+JSON Stringify:C1217(SYSUTIL_GetActLogArchiveInfo)
		SEND VARIABLE:C80($vsTag)
		//Tag the number of activity log records
		SEND VARIABLE:C80($vlNbActLog)
		For ($i; 1; $vlNbActLog)
			SEND RECORD:C78([Activity Log:59])
			If (r2=1)
				ADD TO SET:C119([Activity Log:59]; "DelActLog")
			End if 
			//Owners of data
			RELATE MANY:C262([Activity Log:59])
			$vlNbOwnerData:=Records in selection:C76([Owners of Data:62])
			//Tag the number of owner records
			SEND VARIABLE:C80($vlNbOwnerData)
			If ($vlNbOwnerData>0)
				FIRST RECORD:C50([Owners of Data:62])
				For ($j; 1; $vlNbOwnerData)
					SEND RECORD:C78([Owners of Data:62])
					NEXT RECORD:C51([Owners of Data:62])
				End for 
			End if 
			NEXT RECORD:C51([Activity Log:59])
			$k:=$k+1
			If (Not:C34($OnServer_b))
				If ($k%$Interval=0)  //Don't slow down things just to display
					//UpdateProgress ($i;$vlNbActLog)
					//update progress
					UpdateProgressNew($progressObj_o; $i)
					
				End if 
				
			End if 
		End for 
		//Close the document
		SET CHANNEL:C77(11)
		//CLOSE WINDOW
		If (Not:C34($OnServer_b))
			//quit progress
			Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))  //CALL PROCESS(<>ProgressPID)
		End if 
		$vlEndExpMsec:=Milliseconds:C459
		If (CBDelete=1)
			If (Not:C34($OnServer_b))
				SHORT_MESSAGE("Deleting records...")
			End if 
			
			$vlStartDelMSec:=Milliseconds:C459
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			USE SET:C118("DelActLog")
			//RELATE MANY SELECTION([Owners of Data]RefID)
			DELETE SELECTION:C66([Activity Log:59])
			$vlEndDelMSec:=Milliseconds:C459
			$vsMsg:="Successfully Exported to "+$LogFName+" and "
			$vsMsg:=$vsMsg+"Deleted "+String:C10($k; "#,###,##0")+" Activity Log records."
			$vlElapsedMSec:=$vlEndExpMsec-$vlStartMSec
			$vlHrs:=Int:C8($vlElapsedMSec/(3600*1000))
			$vlMins:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000))/(60*1000))
			$vlSecs:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000)-($vlMins*60*1000))/1000)
			$vsTimeStr:=String:C10($vlHrs)+":"+String:C10($vlMins)+":"+String:C10($vlSecs)
			$vsMsg:=$vsMsg+<>sCR+"Export Time elapsed = "+$vsTimeStr
			$vlElapsedMSec:=$vlEndDelMSec-$vlStartDelMSec
			$vlHrs:=Int:C8($vlElapsedMSec/(3600*1000))
			$vlMins:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000))/(60*1000))
			$vlSecs:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000)-($vlMins*60*1000))/1000)
			$vsTimeStr:=String:C10($vlHrs)+":"+String:C10($vlMins)+":"+String:C10($vlSecs)
			$vsMsg:=$vsMsg+<>sCR+"Delete Time elapsed = "+$vsTimeStr
			If (Not:C34($OnServer_b))
				CLOSE WINDOW:C154
			End if 
			
		Else 
			$vlElapsedMSec:=$vlEndExpMsec-$vlStartMSec
			$vlHrs:=Int:C8($vlElapsedMSec/(3600*1000))
			$vlMins:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000))/(60*1000))
			$vlSecs:=Int:C8(($vlElapsedMSec-($vlHrs*3600*1000)-($vlMins*60*1000))/1000)
			$vsTimeStr:=String:C10($vlHrs)+":"+String:C10($vlMins)+":"+String:C10($vlSecs)
			$vsMsg:=String:C10($k; "###,##0")+" total records exported successfully to "+$LogFName
			$vsMsg:=$vsMsg+<>sCR+"Time Elapsed = "+$vsTimeStr
		End if 
		If ($OnServer_b)
			C_TEXT:C284(MessageDefDir_txt)
			MessageDefDir_txt:=$targetfolder
			ut_StartMessage(2; ($LogFName+"_log"))
			ut_Message($vsMsg)
			ut_CloseMessage
		Else 
			ALERT:C41($vsMsg)
		End if 
		
	End if 
	CLEAR SEMAPHORE:C144("<>Archiving")
End if 