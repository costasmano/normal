//%attributes = {"invisible":true}
If (False:C215)
	//function: aLookUpDest
	//by: Albert Leung
	//created: 1/31/97
	//purpose: try to look up in a table where the local record 
	//resides on a different machine
	//$1: filenumber
	//$2: local id
	//Copyright © 1995-1997,  Albert S. Leung, All Rights Reserved.
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been
	//  `create log of duplicate records found - will be emailed at the end of download do this only when in Data transfer process
	//Modified by: administrator (1/5/16 14:16:58)
End if 

C_LONGINT:C283($1; $filenum)
C_TEXT:C284($2; $3; $localid; $dest)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80

$filenum:=$1
$localid:=$2
$dest:=$3

READ ONLY:C145([FileIDRes Table:60])
QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4=$dest; *)
QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$localid; *)
QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]File Number:1=$filenum)
Case of 
	: (Records in selection:C76([FileIDRes Table:60])=1)
		$0:=[FileIDRes Table:60]Destination ID:3
	: (Records in selection:C76([FileIDRes Table:60])=0)
		$0:=""
	Else 
		
		If (ut_ReturnProcessName(Current process:C322)="Data Transfer")
			
			If (tMailNote="")
				tMailNote:=Data file:C490+Char:C90(Carriage return:K15:38)
				tMailNote:=tMailNote+"[FileIDRes Table]Destination"+Char:C90(Tab:K15:37)+"[FileIDRes Table]Local ID"+Char:C90(Tab:K15:37)+"[FileIDRes Table]File Number"+Char:C90(Carriage return:K15:38)
			End if 
			tMailNote:=tMailNote+$dest+Char:C90(Tab:K15:37)+$localid+Char:C90(Tab:K15:37)+String:C10($filenum)+Char:C90(Carriage return:K15:38)
		End if 
		$0:=""
End case 
READ WRITE:C146([FileIDRes Table:60])