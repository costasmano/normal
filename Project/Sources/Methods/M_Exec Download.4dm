//%attributes = {"invisible":true}
//procedure: M_Exec Download
//for the menu do the data transfer

C_LONGINT:C283($Lpid)
If (False:C215)
	//XDownLoadServer
	ut_SQLDownloadNewRecords
	
	// Modified by: Costas Manousakis-(Designer)-(3/25/16 16:29:34)
	Mods_2016_03_bug
	//  `check if a data transfer is in progress - all data transfer processes are now named "Data Transfer""
End if 
If (Not:C34(<>fQuit))
	
	$Lpid:=LProcessID("Data Transfer")
	
	If ($Lpid>0)
		ALERT:C41("Data Transfer already in progress!")
		BRING TO FRONT:C326($Lpid)
	Else 
		$Lpid:=New process:C317("ut_SQLDownloadNewRecords"; <>LStackSize; "Data Transfer"; ""; 3)
	End if 
End if 
