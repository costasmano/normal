//%attributes = {"invisible":true}
//GP TEMP_IMP_Town_2
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure will be run once.
//Import the tab-delimited text file containing AKB's version of the town
//codes that are sequentially numbered within each of the old districts.

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($Town; $TownCode; $BDept; $Dist; $OldDist; $Place; $County)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$text:="In the following dialog box, Select AKB's tab-delimited "
$text:=$text+"text file containing town-district codes."
ALERT:C41($text)
C_TIME:C306($dImportFile; $dImportRpt)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 
$path:=GetPath

//TRACE

$file:=$path+"AKB's Town Import Report"
$dImportRpt:=Create document:C266($file)
$text:="Town-Dist Code Import Report"+<>sCR+<>sCR
$text:=$text+"B.Dept."+<>sTab+"Town Code"+<>sTab+"Town Imported"+<>sTab+"Stored Town"
$text:=$text+<>sTab+"Comment"+<>sCR+<>sCR
SEND PACKET:C103($dImportRpt; $text)

$i:=0
RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)
While (OK=1)
	$i:=$i+1
	RECEIVE PACKET:C104($dImportFile; $BDept; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $TownCode; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Dist; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OldDist; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Place; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $County; <>sCR)
	
	$BDept:=Substring:C12(ChkBDept($BDept); 1; 3)
	$TownCode:=Substring:C12($TownCode; 1; 3)
	$OldDist:=Substring:C12($OldDist; 1; 1)
	$text:=$BDept+<>sTab+$TownCode+<>sTab+$Town+<>sTab
	QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$BDept)
	Case of 
		: (Records in selection:C76([Town Data:2])=0)
			$text:=$text+<>sTab+"Error - Could not find BDept."+<>sCR
		: (Records in selection:C76([Town Data:2])=1)
			$text:=$text+[Town Data:2]Town Name:1+<>sTab
			If ($Town#[Town Data:2]Town Name:1)
				$text:=$text+"Warning: Town name is different.   "
			End if 
			If ([Town Data:2]Town Dist Code:11#"")
				$text:=$text+"**"+[Town Data:2]Town Dist Code:11+"**   "
			End if 
			If ([Town Data:2]District:6#$Dist)
				$text:=$text+"Dist="+[Town Data:2]District:6+":"+$Dist+"   "
			End if 
			If ([Town Data:2]OldDistrictNo1:3#$OldDist)
				$text:=$text+"Old Dist="+[Town Data:2]OldDistrictNo1:3+":"+$OldDist+"   "
			End if 
			If ([Town Data:2]Place_Code:5#$Place)
				$text:=$text+"Place="+[Town Data:2]Place_Code:5+":"+$Place+"   "
			End if 
			If ([Town Data:2]County Code:10#$County)
				$text:=$text+"County="+[Town Data:2]County Code:10+":"+$County+"   "
			End if 
			$text:=$text+<>sCR
			[Town Data:2]Town Dist Code:11:=$TownCode
			SAVE RECORD:C53([Town Data:2])
		Else 
			$text:=$text+<>sTab+"Error - More than one matching BDept?"+<>sCR
	End case 
	SEND PACKET:C103($dImportRpt; $text)
	
	RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)
End while 

$text:=(2*<>sCR)+"Town Data Import Completed."+<>sCR
$text:=$text+String:C10($i)+" records processed."+<>sCR
SEND PACKET:C103($dImportRpt; $text)
CLOSE DOCUMENT:C267($dImportRpt)
CLOSE DOCUMENT:C267($dImportFile)
