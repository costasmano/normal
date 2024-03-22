//%attributes = {"invisible":true}
If (False:C215)
	//GP: Dec_Sequence
	//by: Albert Leung
	//created: 5/14/2001
	//modified:
	//purpose: Accesses the [Sequences] file to and decrements the sequence number.
	//Use this procedure to roll back an Inc_Sequence.
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	//$1 - $SeqName:  name in sequence record.
End if 

C_TEXT:C284($SeqName)  // Command Replaced was o_C_STRING length was 20

Files2ReadWrite(->[Sequences:28])
$SeqName:=$1
QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName)

If (Records in selection:C76([Sequences:28])#0)
	//Wait for our turn
	While (Locked:C147([Sequences:28]))  //Another process is getting a number
		UNLOAD RECORD:C212([Sequences:28])
		DELAY PROCESS:C323(Current process:C322; 10)
		LOAD RECORD:C52([Sequences:28])
	End while 
	
	[Sequences:28]Value:2:=[Sequences:28]Value:2-1  //Decrement the sequence value
	
End if 

SAVE RECORD:C53([Sequences:28])
UNLOAD RECORD:C212([Sequences:28])
Files2ReadOnly(->[Sequences:28])
