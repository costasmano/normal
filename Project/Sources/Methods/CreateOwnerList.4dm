//%attributes = {"invisible":true}
If (False:C215)
	//procedure: CreateOwnerList
	//by: Albert Leung
	//created: 3/25/98
	//modified:
	//purpose: create an array of distinct owners of data
	//Copyright © 1995-1998,  Albert S. Leung, All Rights Reserved.
End if 

C_TEXT:C284($OwnerSel)  // Command Replaced was o_C_STRING length was 80
ARRAY TEXT:C222(aOwnerList; 0)  //Command Replaced was o_ARRAY string length was 80

ALL RECORDS:C47([Owners of Data:62])
DISTINCT VALUES:C339([Owners of Data:62]Owner Name:2; aOwnerList)

CENTER_WINDOW(320; 150)
DIALOG:C40([Dialogs:21]; "AppendOwner")
If (Ok=1)
	$OwnerSel:=aOwnerList{aOwnerList}
	ALERT:C41("Owner selected is: "+$OwnerSel)
End if 

ARRAY TEXT:C222(aOwnerList; 0)  //Command Replaced was o_ARRAY string length was 80