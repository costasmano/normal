//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitItem12
	//created: April 24, 1997
	//by: Albert Leung
	//purpose: initialize the data for Item 12
	//based on:
	//If Item 104 = 1 or Item 26 = 01,02,11,12,14,06
	//then Item 12 = true
	//else
	//Item 12 = false  
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 6 pixels to 1 character
	
End if 

//Optimize for server

C_LONGINT:C283($i)

ARRAY TEXT:C222($aItem26; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY BOOLEAN:C223($aItem104; 0)
ARRAY BOOLEAN:C223($aItem12; 0)

NewWindow(220; 90; 0)
GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Loading Item12,26,104")

ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item26:120; $aItem26; [Bridge MHD NBIS:1]Item104:119; $aItem104; [Bridge MHD NBIS:1]Item12:196; $aItem12)

For ($i; 1; Size of array:C274($aItem26))
	If (($aItem104{$i}=True:C214) | (Position:C15($aItem26{$i}; "01.02.11.12.14.06")>0))
		$aItem12{$i}:=True:C214
	Else 
		$aItem12{$i}:=False:C215
	End if 
End for 


GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Saving Changes")

START TRANSACTION:C239

ARRAY TO SELECTION:C261($aItem12; [Bridge MHD NBIS:1]Item12:196)

CLOSE WINDOW:C154

If (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Some records were in use. Changes not saved!")
End if 