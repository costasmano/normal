//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitFilePalette
	//date: July 1, 1997
	//purpose: load the file palette at startup  
End if 

//The following is for displaying the file buttons and window controls
<>LFilesPalet:=0
<>LFilePalPID:=LSpawnProcess("P_FilesPalette"; <>LStackSize; "$FilesPalette"; True:C214; False:C215)
UpdatWindArray("Splash Screen")
<>asWindows:=1
<>aiWindows{0}:=1