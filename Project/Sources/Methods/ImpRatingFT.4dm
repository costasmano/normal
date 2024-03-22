//%attributes = {"invisible":true}
//proccedure: ImRatingFT
//created by: Albert Leung
//date: 8/18/98
//Modified 2-10-2000 : CM
//    Adjusted GOTO XY x param from 6 pixels to 1 character


C_TIME:C306($dImportFile; $dErrorLog)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($tbuff; $path; $text)
C_LONGINT:C283($counter)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$dImportFile:=Open document:C264(""; "TEXT")
$path:=GetPath
$dErrorLog:=Create document:C266($path+"error.log")
NewWindow(200; 30; 0; 4; "Importing")
$counter:=1
ALL RECORDS:C47([RatingReports:65])
While (Ok=1)
	RECEIVE PACKET:C104($dImportFile; $tbuff; <>sCR)
	$BIN:=Substring:C12($tbuff; 49; 3)
	//Process a record
	If ((Length:C16($BIN)=3) & (Blank($BIN)=False:C215))
		QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=$BIN)
		If (Records in selection:C76([RatingReports:65])>0)
			For ($i; 1; Records in selection:C76([RatingReports:65]))
				[RatingReports:65]DataFileType:32:="STAAD-3"
				[RatingReports:65]DataFile:27:=True:C214
				SAVE RECORD:C53([RatingReports:65])
				NEXT RECORD:C51([RatingReports:65])
			End for 
		Else 
			$text:="Reference error for "+$BIN+<>sCR+"Line: "+$tbuff+<>sCR
			SEND PACKET:C103($dErrorLog; $text)
		End if 
		ALL RECORDS:C47([RatingReports:65])
	End if 
	$counter:=$counter+1
	If ($counter%25=0)
		GOTO XY:C161(1; 1)  //2-10-2000 : CM
		MESSAGE:C88("Record "+String:C10($counter))
	End if 
End while 

CLOSE WINDOW:C154
CLOSE DOCUMENT:C267($dImportFile)
CLOSE DOCUMENT:C267($dErrorLog)