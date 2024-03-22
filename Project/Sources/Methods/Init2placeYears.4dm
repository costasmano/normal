//%attributes = {"invisible":true}
If (False:C215)
	//procedure: Init2placeYears
	//created: April 24, 1997
	//by: Albert Leung
	//purpose: initialize the data for Item 30,97,115
	//converts year 90 to 1990 and so forth
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 10 pixels to 2 character
	
End if 

//Optimize for server

C_LONGINT:C283($i)

ARRAY INTEGER:C220($aItem30; 0)
ARRAY INTEGER:C220($aItem97; 0)
ARRAY INTEGER:C220($aItem115; 0)

NewWindow(220; 90; 0)
GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Loading Item 30,97,115")

ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item30:89; $aItem30; [Bridge MHD NBIS:1]Item97:158; $aItem97; [Bridge MHD NBIS:1]Item115:160; $aItem115)

For ($i; 1; Size of array:C274($aItem30))
	Case of 
		: ($aItem30{$i}<30)
			$aItem30{$i}:=$aItem30{$i}+2000
		: (($aItem30{$i}<=99) & ($aItem30{$i}>=30))
			$aItem30{$i}:=$aItem30{$i}+1900
		: ($aItem30{$i}>3000)
			$aItem30{$i}:=$aItem30{$i}-1900
	End case 
	If ($aItem97{$i}#0)
		Case of 
			: ($aItem97{$i}<30)
				$aItem97{$i}:=$aItem97{$i}+2000
			: (($aItem97{$i}<=99) & ($aItem97{$i}>=30))
				$aItem97{$i}:=$aItem97{$i}+1900
			: ($aItem97{$i}>3000)
				$aItem97{$i}:=$aItem97{$i}-1900
		End case 
	End if 
	If ($aItem115{$i}#0)
		Case of 
			: ($aItem115{$i}<30)
				$aItem115{$i}:=$aItem115{$i}+2000
			: (($aItem115{$i}<=99) & ($aItem115{$i}>=30))
				$aItem115{$i}:=$aItem115{$i}+1900
			: ($aItem115{$i}>3000)
				$aItem115{$i}:=$aItem115{$i}-1900
		End case 
	End if 
End for 


GOTO XY:C161(2; 3)  //2-10-2000 : CM
MESSAGE:C88("Saving Changes")

START TRANSACTION:C239

ARRAY TO SELECTION:C261($aItem30; [Bridge MHD NBIS:1]Item30:89; $aItem97; [Bridge MHD NBIS:1]Item97:158; $aItem115; [Bridge MHD NBIS:1]Item115:160)

CLOSE WINDOW:C154

If (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Some records were in use. Changes not saved!")
End if 