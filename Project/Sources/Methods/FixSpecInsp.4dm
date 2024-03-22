//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FixSpecInsp
	//purpose: swop data between Item 93c and Other inspection
	//created: 1/7/99
	//by: Albert Leung
End if 

ARRAY DATE:C224($aItem93c; 0)
ARRAY DATE:C224($aOtherIDate; 0)
ARRAY BOOLEAN:C223($aItem92ca; 0)
ARRAY BOOLEAN:C223($aOtherInsp; 0)
ARRAY INTEGER:C220($aItem92cb; 0)
ARRAY INTEGER:C220($aOtherIFreq; 0)

C_LONGINT:C283($i)
C_DATE:C307($dtemp)
C_BOOLEAN:C305($btemp)
C_LONGINT:C283($itemp)  //Command Replaced was o_C_INTEGER

MessageNM("Loading data…")

ALL RECORDS:C47([Bridge MHD NBIS:1])
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OtherIDate:41; $aOtherIDate)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OtherInsp:42; $aOtherInsp)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OtherIFreq:43; $aOtherIFreq)

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item93C:171; $aItem93c)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item92CA:167; $aItem92ca)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item92CB:168; $aItem92cb)

For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))  //swop the values
	$dtemp:=$aOtherIDate{$i}
	$btemp:=$aOtherInsp{$i}
	$itemp:=$aOtherIFreq{$i}
	$aOtherIDate{$i}:=$aItem93c{$i}
	$aOtherInsp{$i}:=$aItem92ca{$i}
	$aOtherIFreq{$i}:=$aItem92cb{$i}
	$aItem93c{$i}:=$dtemp
	$aItem92ca{$i}:=$btemp
	$aItem92cb{$i}:=$itemp
End for 

CLOSE WINDOW:C154
MessageNM("Saving changes…")

START TRANSACTION:C239

ARRAY TO SELECTION:C261($aOtherIDate; [Bridge MHD NBIS:1]OtherIDate:41)
ARRAY TO SELECTION:C261($aOtherInsp; [Bridge MHD NBIS:1]OtherInsp:42)
ARRAY TO SELECTION:C261($aOtherIFreq; [Bridge MHD NBIS:1]OtherIFreq:43)

ARRAY TO SELECTION:C261($aItem93c; [Bridge MHD NBIS:1]Item93C:171)
ARRAY TO SELECTION:C261($aItem92ca; [Bridge MHD NBIS:1]Item92CA:167)
ARRAY TO SELECTION:C261($aItem92cb; [Bridge MHD NBIS:1]Item92CB:168)

CLOSE WINDOW:C154

If (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Some records were in use. Changes not saved!")
End if 