//%attributes = {"invisible":true}
//proccedure: ImportCoords
//created by: Albert Leung
//date: 4/24/97
//purpose: Get data from planning file.
//This is a DOS file so expect CRLF at the end of every record.

//Modified 2-10-2000 : CM
//    Adjusted GOTO XY x param from 6 pixels to 1 character


C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($lat)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($long)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($tbuff)
C_TEXT:C284($nstuff)
C_TEXT:C284($sFldDel)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($counter)
C_REAL:C285($r1; $r2)

ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3

$sFldDel:=","
$dImportFile:=Open document:C264(""; "TEXT")
//First line of data
RECEIVE PACKET:C104($dImportFile; $nstuff; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $BIN; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $long; $sFldDel)
RECEIVE PACKET:C104($dImportFile; $lat; <>sCR)
RECEIVE PACKET:C104($dImportFile; $tbuff; 1)  //ignore the line feed character

NewWindow(200; 30; 0; 4; "Importing")
$counter:=0
ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $aBIN)
While (Ok=1)
	//Process a record
	If ((Length:C16($BIN)=3) & (Blank($BIN)=False:C215))
		GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; Find in array:C230($aBIN; $BIN))
		$r1:=Num:C11($lat)
		$r2:=Num:C11($long)*-1
		[Bridge MHD NBIS:1]Item16A:68:=Int:C8($r1)  //degrees
		[Bridge MHD NBIS:1]Item17A:70:=Int:C8($r2)
		$r1:=Dec:C9($r1)*60  //minutes
		$r2:=Dec:C9($r2)*60
		[Bridge MHD NBIS:1]Item16B:69:=Int:C8($r1)
		[Bridge MHD NBIS:1]Item17B:71:=Int:C8($r2)
		$r1:=Dec:C9($r1)*60  //seconds
		$r2:=Dec:C9($r2)*60
		[Bridge MHD NBIS:1]Item16C:109:=$r1
		[Bridge MHD NBIS:1]Item17C:136:=$r2
		SAVE RECORD:C53([Bridge MHD NBIS:1])
	End if 
	//read in a record
	RECEIVE PACKET:C104($dImportFile; $nstuff; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $BIN; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $long; $sFldDel)
	RECEIVE PACKET:C104($dImportFile; $lat; <>sCR)
	RECEIVE PACKET:C104($dImportFile; $tbuff; 1)  //ignore the line feed character
	
	$counter:=$counter+1
	If ($counter%25=0)
		GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
		MESSAGE:C88("Record "+String:C10($counter))
	End if 
End while 

CLOSE WINDOW:C154
CLOSE DOCUMENT:C267($dImportFile)