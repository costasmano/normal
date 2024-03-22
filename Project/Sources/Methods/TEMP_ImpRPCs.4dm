//%attributes = {"invisible":true}
//GP TEMP_ImpRPCs
//Import Regional Planning Commission (or Agency) names.

C_TEXT:C284($RPCCode; $RPC; $text)

$text:="In the following dialog box, Select the tab-delimited "
$text:=$text+"text file containing RPC codes and names."
ALERT:C41($text)
C_TIME:C306($dImportFile)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 

TRACE:C157

RECEIVE PACKET:C104($dImportFile; $RPCCode; <>sTab)
While (OK=1)
	RECEIVE PACKET:C104($dImportFile; $RPC; <>sCR)
	CREATE RECORD:C68([RPCs:72])
	[RPCs:72]Code:1:=$RPCCode
	[RPCs:72]RPC Name:2:=$RPC
	SAVE RECORD:C53([RPCs:72])
	RECEIVE PACKET:C104($dImportFile; $RPCCode; <>sTab)
End while 
CLOSE DOCUMENT:C267($dImportFile)