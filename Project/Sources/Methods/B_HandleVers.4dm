//%attributes = {"invisible":true}
If (False:C215)
	//procedure: M_HandleVers
	//by: Albert Leung
	//date: 11/17/97
	//purpose: set the version number of the program
End if 
vDBDate:=<>dbDate
vVersionN:=<>Version
CENTER_WINDOW(350; 120)
DIALOG:C40([Dialogs:21]; "VersionNumber")
CLOSE WINDOW:C154

If (Ok=1)
	ALL RECORDS:C47([Preferences:57])
	FIRST RECORD:C50([Preferences:57])
	[Preferences:57]dbDate:7:=Current date:C33(*)
	<>dbDate:=Current date:C33(*)
	SAVE RECORD:C53([Preferences:57])
End if 