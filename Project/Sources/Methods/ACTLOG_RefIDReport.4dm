//%attributes = {"invisible":true}
//Method: ACTLOG_RefIDReport
//Description
// Scan the sequences of RefID in [Activity Log] and produce a report
// indicating the ranges of RefIDs - will create a CSV file with
// RangeStart , RangeEnd, RangeSpan, RangeCount
//  // RangeSpan is the differnece between the last RefID in one range and the first RefID in the next range
//  // RangeCount is the number of records in the range
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-27T00:00:00, 15:35:19
	// ----------------------------------------------------
	//Created : 
	
	// Modified by: Costas Manousakis-(Designer)-(2022-07-15 17:27:24)
	Mods_2022_07
	//  `added a header row to the csv report
End if 
//
//produce a report on the sequence of RefIDs in the activity log table

ARRAY LONGINT:C221($RefIDs_aL; 0)
ARRAY LONGINT:C221($RefIDrangeStart_aL; 1)
ARRAY LONGINT:C221($RefIDrangeEnd_aL; 1)
ARRAY LONGINT:C221($RefIDrangeSpan_aL; 1)
ARRAY LONGINT:C221($RefIDrangeCount_aL; 1)

ALL RECORDS:C47([Activity Log:59])
ARRAY LONGINT:C221($RefIDs_aL; Records in selection:C76([Activity Log:59]))
C_LONGINT:C283($StartTick; $endTick)

If (True:C214)
	//This is safer since Selection to array handles by itself better the case where the number of records is too large.
	$StartTick:=Tickcount:C458
	ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
	SELECTION TO ARRAY:C260([Activity Log:59]RefID:28; $RefIDs_aL)
	
Else 
	$StartTick:=Tickcount:C458
	Begin SQL
		select RefId from [Activity log]
		order by RefID ASC
		into :$RefIDs_aL ;
	End SQL
End if 
$endTick:=Tickcount:C458
ALERT:C41("duration = "+String:C10($endTick-$StartTick; "###,###,###,###,###,###"))
//SORT ARRAY($RefIDs_aL;>)
$RefIDrangeStart_aL{1}:=$RefIDs_aL{1}
$RefIDrangeCount_aL{1}:=1
C_LONGINT:C283($Span; $i)
$Span:=Num:C11(Request:C163("Enter max span"; "200"))

SHORT_MESSAGE("Scanning....")

If ($span<=0)
	$span:=200
End if 

For ($i; 2; Size of array:C274($RefIDs_aL))
	
	If ($RefIDs_aL{$i}>($RefIDs_aL{$i-1}+$span))
		//found a gap of 5 IDs
		$RefIDrangeEnd_aL{Size of array:C274($RefIDrangeEnd_aL)}:=$RefIDs_aL{$i-1}
		$RefIDrangeSpan_aL{Size of array:C274($RefIDrangeSpan_aL)}:=$RefIDs_aL{$i}-$RefIDs_aL{$i-1}
		$RefIDrangeCount_aL{Size of array:C274($RefIDrangeCount_aL)}:=$i-$RefIDrangeCount_aL{Size of array:C274($RefIDrangeCount_aL)}
		APPEND TO ARRAY:C911($RefIDrangeStart_aL; $RefIDs_aL{$i})
		APPEND TO ARRAY:C911($RefIDrangeEnd_aL; 0)
		APPEND TO ARRAY:C911($RefIDrangeSpan_aL; 0)
		APPEND TO ARRAY:C911($RefIDrangeCount_aL; $i)
	End if 
	
End for 
$RefIDrangeEnd_aL{Size of array:C274($RefIDrangeEnd_aL)}:=$RefIDs_aL{Size of array:C274($RefIDs_aL)}
$RefIDrangeCount_aL{Size of array:C274($RefIDrangeCount_aL)}:=Size of array:C274($RefIDs_aL)-$RefIDrangeCount_aL{Size of array:C274($RefIDrangeCount_aL)}

CLOSE WINDOW:C154

ALERT:C41("Finished scanning! Found "+String:C10(Size of array:C274($RefIDrangeEnd_aL))+" ranges.")
C_TEXT:C284($CSVText_txt)
$CSVText_txt:=ut_ArrayToText_CSV(","; ->$RefIDrangeStart_aL; ->$RefIDrangeEnd_aL; ->$RefIDrangeSpan_aL; ->$RefIDrangeCount_aL)
$CSVText_txt:="StartRefID,EndRefID,GapToNextRange,RangeCount"+Char:C90(Carriage return:K15:38)+$CSVText_txt
C_TEXT:C284($csvFile)
ARRAY TEXT:C222($csvfiles_atxt; 0)
$csvFile:=Select document:C905(""; "csv"; "Choose csv file"; File name entry:K24:17; $csvfiles_atxt)
TEXT TO DOCUMENT:C1237($csvfiles_atxt{1}; $CSVText_txt; UTF8 text without length:K22:17)
SHOW ON DISK:C922($csvfiles_atxt{1})

//End ACTLOG_RefIDReport