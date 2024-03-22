//%attributes = {"invisible":true}
C_TEXT:C284($0; $vtRes)
$vtRes:=""
If ([Activity Log:59]Activity Type:3#"GRP")
	$vtRes:=fBLOB_2_Text([Activity Log:59]Data:10; [Activity Log:59]Data Type:11)
Else 
	$vtRes:=fGrpBlob2Text([Activity Log:59]Data:10)
End if 
$0:=$vtRes