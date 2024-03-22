//%attributes = {"invisible":true}
//GP TEMP_IMP_Town_Codes
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure will be run once.
//Import the tab-delimited text file containing the town codes that
//are sequentially numbered within each of the old districts.

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($Town; $TownCode; $BDept; $RPA)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$text:="In the following dialog box, Select the tab-delimited "
$text:=$text+"text file containing town-district codes."
ALERT:C41($text)
C_TIME:C306($dImportFile; $dImportRpt)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 
$path:=GetPath

//TRACE

$file:=$path+"Town Data Import Report"
$dImportRpt:=Create document:C266($file)
$text:="Town-Dist Code Import Report"+<>sCR+<>sCR
$text:=$text+"B.Dept."+<>sTab+"Town Code"+<>sTab+"RPA"+<>sTab+"Town Imported"+<>sTab+"Stored Town"
$text:=$text+<>sTab+"Comment"+<>sCR+<>sCR
SEND PACKET:C103($dImportRpt; $text)

$i:=0
RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)
While (OK=1)
	$i:=$i+1
	RECEIVE PACKET:C104($dImportFile; $TownCode; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $BDept; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $RPA; <>sCR)
	
	$BDept:=Substring:C12(ChkBDept($BDept); 1; 3)
	$text:=$BDept+<>sTab+$TownCode+<>sTab+$RPA+<>sTab+$Town+<>sTab
	QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$BDept)
	Case of 
		: (Records in selection:C76([Town Data:2])=0)
			$text:=$text+<>sTab+"Error - Could not find BDept."+<>sCR
		: (Records in selection:C76([Town Data:2])=1)
			$text:=$text+[Town Data:2]Town Name:1+<>sTab
			If ($Town#[Town Data:2]Town Name:1)
				$text:=$text+"Warning: Town name is different.     "
			End if 
			If (Num:C11([Town Data:2]RPC_1:7)#Num:C11($RPA))
				$text:=$text+"RPC_1="+[Town Data:2]RPC_1:7+"  RPC_2="+[Town Data:2]RPC_2:8
			End if 
			If ([Town Data:2]Town Dist Code:11#"")
				$text:=$text+" **"+[Town Data:2]Town Dist Code:11+"** "
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
