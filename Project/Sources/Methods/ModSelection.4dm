//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: ModSelection
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created by: Jim Steinman
	//Date: 10/1/95
	
	//Purpose: Displays an output layout listing of file indicated by pFile.
	
	//<>fGeneric:=False
	//<>f_Ver1x10:=False
	//<>f_Ver1x20:=False
	//<>fJ_Steinman:=False
	
	//Modified: 10/5/95
	//<>fK_Wilbur:=False
	
	// Modified by: Costas Manousakis-(Designer)-(2024-02-02 13:02:10)
	Mods_2024_02
	//  `replaced SET MENU BAR with ControlMenuBar
End if 

C_LONGINT:C283($LWidth; $LHeight; $LPosition; $LWindowType)

ControlMenuBar(2)  // changes Mods_2024_02

FORM SET INPUT:C55(pFile->; "Input")
FORM SET OUTPUT:C54(pFile->; "Output")
ALL RECORDS:C47(pFile->)
$LWidth:=605  //Desired width of the interior of the window to be opened.
$LHeight:=420  //Desired height.
$LPosition:=1  //Stack windows
$LWindowType:=4
NewWindow($LWidth; $LHeight; $LPosition; $LWindowType)

WindowTitle
//Start change Oct-2001 -->
If (User in group:C338(Current user:C182; "ReadWrite"))
	MODIFY SELECTION:C204(pFile->; *)
Else 
	DISPLAY SELECTION:C59(pFile->; *)
End if 

CLOSE WINDOW:C154
//End of procedure 