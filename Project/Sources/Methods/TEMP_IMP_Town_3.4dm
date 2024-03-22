//%attributes = {"invisible":true}
//GP TEMP_IMP_Town_3
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure will be run once.
//Import the tab-delimited text file containing town data from the 1990 census.
//Compare that data to the existing data and generate a report.

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($Town; $Place; $County)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$text:="In the following dialog box, select the tab-delimited "
$text:=$text+"text file containing town data from the 1990 census."
ALERT:C41($text)
C_TIME:C306($dImportFile; $dImportRpt)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 

TRACE:C157
$path:=GetPath

$file:=$path+"1990 Census - Comparison Report"
$dImportRpt:=Create document:C266($file)
$text:="1990 Census - Town Data Comparison Report"+<>sCR+<>sCR
$text:=$text+"Town Imported"+<>sTab+"Stored Town"
$text:=$text+<>sTab+"Comment"+<>sCR+<>sCR
SEND PACKET:C103($dImportRpt; $text)

$i:=0
RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)
While (OK=1)
	$i:=$i+1
	RECEIVE PACKET:C104($dImportFile; $Place; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $County; <>sCR)
	
	$text:=$Town+<>sTab
	QUERY:C277([Town Data:2]; [Town Data:2]Town Name:1=$Town)
	Case of 
		: (Records in selection:C76([Town Data:2])=0)
			$text:=$text+<>sTab+"Error - Could not find town.  Place="+$Place+" County="+$County+<>sCR
		: (Records in selection:C76([Town Data:2])=1)
			$text:=$text+[Town Data:2]Town Name:1+<>sTab
			//      If ($Town#[Town Data]Town Name)
			//        $text:=$text+"Warning: Town name is different.   "
			//      End if 
			If (Num:C11([Town Data:2]Place_Code:5)#Num:C11($Place))
				$text:=$text+"Place="+String:C10(Num:C11([Town Data:2]Place_Code:5))+":"+$Place+"   "
			End if 
			If (Num:C11([Town Data:2]County Code:10)#Num:C11($County))
				$text:=$text+"County="+String:C10(Num:C11([Town Data:2]County Code:10))+":"+$County+"   "
			End if 
			$text:=$text+<>sCR
		Else 
			$text:=$text+<>sTab+"Error - More than one matching town?"+<>sCR
	End case 
	SEND PACKET:C103($dImportRpt; $text)
	
	RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)
End while 

$text:=(2*<>sCR)+"Town Data Import Completed."+<>sCR
$text:=$text+String:C10($i)+" records processed."+<>sCR
SEND PACKET:C103($dImportRpt; $text)
CLOSE DOCUMENT:C267($dImportRpt)
CLOSE DOCUMENT:C267($dImportFile)
