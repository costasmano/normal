//%attributes = {"invisible":true}

// ----------------------------------------------------
// ut_AssignNextNumber
// User name (OS): cjmiller
// Date and time: 03/12/04, 09:50:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 is the key to the sequence table
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/9/09 16:31:31)
	Mods_2009_03
	//  `Set variable ◊ut_NextCounterNumber_l to -1 as the last step to signal we're done here.
	//Ugrade to v11
	//Modified by: Charles Miller (4/29/11 11:38:25)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 10:25:43)
	// Modified by: Charles Miller-(Designer)-(10/20/16 
	Mods_2016_10
	//  `Increased Delay process to 30; Added IDLE 
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:39:50)
	Mods_2023_04
	//  `removed IDLE 
End if 

//◊NextNumberArray_al
C_TEXT:C284($1; $Key_txt)
$Key_txt:=$1
C_LONGINT:C283($2; $ArrayPosition_l; $ut_NextCounterNumber_l; $INCSequenceNextNumber_l)
$ArrayPosition_l:=$2
READ WRITE:C146([Sequences:28])
QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$Key_txt)

If (Records in selection:C76([Sequences:28])=0)
	CREATE RECORD:C68([Sequences:28])  //This is the first time for this sequence.
	[Sequences:28]Name:1:=$Key_txt
	[Sequences:28]Value:2:=1  //Starting number.
Else 
	//Get the next sequence
	LOAD RECORD:C52([Sequences:28])
	While (Locked:C147([Sequences:28]))  //Another process is getting a number
		UNLOAD RECORD:C212([Sequences:28])
		//IDLE
		DELAY PROCESS:C323(Current process:C322; 30)
		//IDLE
		LOAD RECORD:C52([Sequences:28])
	End while 
	
	[Sequences:28]Value:2:=[Sequences:28]Value:2+1  //Increment the sequence value
	
End if 

<>NextNumberArray_al{$ArrayPosition_l}:=[Sequences:28]Value:2
//$ut_NextCounterNumber_l:=

SAVE RECORD:C53([Sequences:28])
UNLOAD RECORD:C212([Sequences:28])
REDUCE SELECTION:C351([Sequences:28]; 0)  // clear slelection

// End method ut_AssignNextNumber