//%attributes = {"invisible":true}
//GP SET_NO_CS_ACT
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Set number of Condition States for each Category and
//set number of Actions for each Condition State.

C_LONGINT:C283($NoCat; $i; $NoCS; $j)

ALL RECORDS:C47([BMS Categories:49])
$NoCat:=Records in selection:C76([BMS Categories:49])
For ($i; 1; $NoCat)
	RELATE MANY:C262([BMS Categories:49]Category ID:1)
	$NoCS:=Records in selection:C76([Cond States:51])
	[BMS Categories:49]Num of CSs:7:=$NoCS
	SAVE RECORD:C53([BMS Categories:49])
	For ($j; 1; $NoCS)
		RELATE MANY:C262([Cond States:51]Cond State ID:1)
		[Cond States:51]Num of Actions:6:=Records in selection:C76([CS Actions:52])
		SAVE RECORD:C53([Cond States:51])
		NEXT RECORD:C51([Cond States:51])
	End for 
	NEXT RECORD:C51([BMS Categories:49])
End for 