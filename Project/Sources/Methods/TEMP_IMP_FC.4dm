//%attributes = {"invisible":true}
//GP TEMP_IMP_FC
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//This procedure imports a tab-delimited text file containing 
//BINs with changes in Functional Classification.
//Compare that data to the existing data and generate a report.

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($BIN; $FC)
C_LONGINT:C283($i; $j; $Diff)  //Command Replaced was o_C_INTEGER

$text:="In the following dialog box, select the tab-delimited "
$text:=$text+"text file containing Functional Classification changes."
ALERT:C41($text)

vdImpFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 
$path:=GetPath

//TRACE

$file:=$path+"Functional Class. Changes Rpt."
vdUpdateRpt:=Create document:C266($file)
$text:="Functional Classification Changes Report"+<>sCR+<>sCR
$text:=$text+"BIN"+<>sTab+"New FC"
$text:=$text+<>sTab+"Old FC"+<>sTab+"Difference"+<>sCR+<>sCR
SEND PACKET:C103(vdUpdateRpt; $text)

$i:=0
$j:=0
RECEIVE PACKET:C104(vdImpFile; $BIN; <>sTab)
While (OK=1)
	$i:=$i+1
	RECEIVE PACKET:C104(vdImpFile; $FC; <>sCR)
	$FC:=String:C10(Num:C11($FC); "00")
	
	$text:=$BIN+<>sTab+$FC+<>sTab
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
	Case of 
		: (Records in selection:C76([Bridge MHD NBIS:1])=0)
			$text:=$text+"Error - Could not find BIN."+<>sCR
		: (Records in selection:C76([Bridge MHD NBIS:1])=1)
			$Diff:=Num:C11($FC)-Num:C11([Bridge MHD NBIS:1]Item26:120)
			$text:=$text+[Bridge MHD NBIS:1]Item26:120+<>sTab+String:C10($Diff; "+#0;-#0;")+<>sCR
			If ([Bridge MHD NBIS:1]Item26:120#$FC)
				$j:=$j+1
				[Bridge MHD NBIS:1]Item26:120:=$FC
				SAVE RECORD:C53([Bridge MHD NBIS:1])
			End if 
		Else 
			$text:=$text+"Error - More than one matching BIN?"+<>sCR
	End case 
	SEND PACKET:C103(vdUpdateRpt; $text)
	
	RECEIVE PACKET:C104(vdImpFile; $BIN; <>sTab)
End while 

$text:=(2*<>sCR)+"Functional Classification Import Completed."+<>sCR
$text:=$text+String:C10($i)+" records processed."+<>sCR
$text:=$text+String:C10($j)+" records updated."+<>sCR
SEND PACKET:C103(vdUpdateRpt; $text)
CLOSE DOCUMENT:C267(vdUpdateRpt)
CLOSE DOCUMENT:C267(vdImpFile)
