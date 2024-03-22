//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitItem13
	//created: May 1, 1997
	//by: Albert Leung
	//purpose: initialize the data for Item 13 to blanks
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 6 pixels to 1 character
	
End if 

//Optimize for server

C_LONGINT:C283($i)

ARRAY TEXT:C222($aItem13A; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222($aItem13B; 0)  //Command Replaced was o_ARRAY string length was 2

NewWindow(220; 90; 0)
GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Loading Item13A, Item13B")

ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item 13A:197; $aItem13A; [Bridge MHD NBIS:1]Item 13B:198; $aItem13B)

For ($i; 1; Size of array:C274($aItem13A))
	If (Length:C16($aItem13A{$i})<10)
		$aItem13A{$i}:=sFillVar("0"; 10)
	End if 
	If (Length:C16($aItem13B{$i})<2)
		$aItem13B{$i}:=sFillVar("0"; 2)
	End if 
End for 


GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Saving Changes")

START TRANSACTION:C239

ARRAY TO SELECTION:C261($aItem13A; [Bridge MHD NBIS:1]Item 13A:197; $aItem13B; [Bridge MHD NBIS:1]Item 13B:198)

CLOSE WINDOW:C154

If (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Some records were in use. Changes not saved!")
End if 